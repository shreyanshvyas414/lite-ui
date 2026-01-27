local M = {}

-- Module level state
local state = {
  callback = nil,
  bufnr = nil,
  winid = nil,
}

local function close_and_callback(result)
  local callback = state.callback
  state.callback = nil
  state.bufnr = nil
  
  if state.winid and vim.api.nvim_win_is_valid(state.winid) then
    pcall(vim.api.nvim_win_close, state.winid, true)
  end
  state.winid = nil
  
  if callback then
    vim.schedule(function()
      callback(result)
    end)
  end
end

function M.input(opts, on_confirm)
  opts = opts or {}
  local config = require("lite-ui.config")

  if not config.options.input.enabled then
    local result = vim.fn.input({
      prompt = opts.prompt or "",
      default = opts.default or "",
    })
    return on_confirm(result)
  end

  -- CRITICAL: Get word under cursor BEFORE opening any window
  -- This must happen in the original buffer context
  local default_text = opts.default or ""
  
  if default_text == "" and config.options.input.auto_detect_cword then
    local prompt_lower = (opts.prompt or ""):lower()
    if prompt_lower:match("name") or prompt_lower:match("rename") then
      -- Get word from current position
      default_text = vim.fn.expand("<cword>")
    end
  end

  -- Close any existing window
  if state.winid and vim.api.nvim_win_is_valid(state.winid) then
    pcall(vim.api.nvim_win_close, state.winid, true)
  end

  state.callback = on_confirm

  -- Create buffer - MUST be nofile, NOT prompt
  local bufnr = vim.api.nvim_create_buf(false, true)
  vim.bo[bufnr].buftype = "nofile"  -- ← THIS IS CRITICAL - NO "prompt"!
  vim.bo[bufnr].bufhidden = "wipe"
  vim.bo[bufnr].swapfile = false
  vim.bo[bufnr].modifiable = true
  
  -- Set the text
  if default_text ~= "" then
    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { default_text })
  end
  
  state.bufnr = bufnr

  -- Window config
  local width = vim.o.columns
  local height = vim.o.lines
  local win_width = math.min(60, math.floor(width * 0.9))
  local win_height = 1
  
  local border = config.get_border(config.options.input.border)
  
  local win_config = {
    relative = "editor",
    width = win_width,
    height = win_height,
    row = math.floor((height - win_height) / 2),
    col = math.floor((width - win_width) / 2),
    style = "minimal",
    border = border,
    title = opts.prompt and (" " .. opts.prompt .. " ") or nil,
    title_pos = "left",
  }

  -- Open window
  local ok, winid = pcall(vim.api.nvim_open_win, bufnr, true, win_config)
  if not ok then
    local result = vim.fn.input({
      prompt = opts.prompt or "",
      default = default_text,
    })
    state.callback = nil
    state.bufnr = nil
    return on_confirm(result)
  end
  
  state.winid = winid

  -- Apply highlights
  local themes = require("lite-ui.themes")
  pcall(vim.api.nvim_set_option_value, "winhighlight",
    string.format("Normal:%s,FloatBorder:%s,FloatTitle:%s",
      themes.hl_groups.input.background,
      themes.hl_groups.input.border,
      themes.hl_groups.input.title
    ), { win = winid })

  -- Keymaps
  vim.keymap.set({"n", "i"}, "<CR>", function()
    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    close_and_callback(lines[1] or "")
  end, { buffer = bufnr, nowait = true })

  vim.keymap.set({"n", "i"}, "<Esc>", function()
    close_and_callback(nil)
  end, { buffer = bufnr, nowait = true })

  vim.keymap.set("n", "q", function()
    close_and_callback(nil)
  end, { buffer = bufnr, nowait = true })

  vim.keymap.set({"n", "i"}, "<C-c>", function()
    close_and_callback(nil)
  end, { buffer = bufnr, nowait = true })

  -- Auto-cancel on buffer leave
  vim.api.nvim_create_autocmd("BufLeave", {
    buffer = bufnr,
    once = true,
    callback = function()
      if state.callback then
        close_and_callback(nil)
      end
    end,
  })

  -- Position cursor and enter insert mode
  if config.options.input.start_in_insert then
    vim.schedule(function()
      if vim.api.nvim_win_is_valid(winid) then
        vim.api.nvim_set_current_win(winid)
        
        -- Move cursor to end of text
        if default_text ~= "" then
          vim.api.nvim_win_set_cursor(winid, {1, #default_text})
        end
        
        vim.cmd("startinsert")
      end
    end)
  end
end

return M
