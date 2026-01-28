local M = {}

local state = {
  callback = nil,
  bufnr = nil,
  winid = nil,
}

local function close_and_callback(result)
  local callback = state.callback
  
  -- Clear state
  state.callback = nil
  state.bufnr = nil
  
  -- Close window
  if state.winid and vim.api.nvim_win_is_valid(state.winid) then
    vim.api.nvim_win_close(state.winid, true)
  end
  state.winid = nil
  
  -- Execute callback
  if callback then
    vim.schedule(function()
      callback(result)
    end)
  end
end

function M.input(opts, on_confirm)
  opts = opts or {}
  local config = require("lite-ui.config")

  -- Fallback to default if disabled
  if not config.options.input.enabled then
    local result = vim.fn.input({
      prompt = opts.prompt or "",
      default = opts.default or "",
      completion = opts.completion,
    })
    on_confirm(result)
    return
  end

  -- Get default text - either from opts or from cursor word
  local default_text = opts.default or ""
  
  -- CRITICAL FIX: Auto-detect word under cursor for LSP rename
  -- This is what gets PREFILLED in the dialog (fixing the empty % issue)
  if (not default_text or default_text == "") and config.options.input.auto_detect_cword then
    local prompt_lower = (opts.prompt or ""):lower()
    -- Match various rename prompts: "Rename", "Renamed to", "New Name", etc.
    if prompt_lower:match("rename") or prompt_lower:match("new name") or prompt_lower:match("name to") then
      default_text = vim.fn.expand("<cword>")
    end
  end

  -- Close any existing input window
  if state.winid and vim.api.nvim_win_is_valid(state.winid) then
    vim.api.nvim_win_close(state.winid, true)
  end

  -- Store callback
  state.callback = on_confirm

  -- Create buffer (CRITICAL: use "nofile" NOT "prompt"!)
  -- The buftype MUST be "nofile" for LSP rename to work properly
  local bufnr = vim.api.nvim_create_buf(false, true)
  state.bufnr = bufnr
  
  -- CRITICAL: Buffer options
  -- Using "nofile" allows vim.lsp.buf.rename() to communicate properly
  -- If buftype="prompt", it interferes with LSP's ability to detect the buffer
  vim.bo[bufnr].buftype = "nofile"  -- CRITICAL: MUST be "nofile" for LSP rename!
  vim.bo[bufnr].bufhidden = "wipe"
  vim.bo[bufnr].swapfile = false
  vim.bo[bufnr].modifiable = true
  vim.bo[bufnr].undofile = false
  vim.bo[bufnr].filetype = "LiteUIInput"
  
  -- Set default text - this is what shows PREFILLED in the dialog
  -- This fixes the "empty % placeholder" issue
  if default_text and default_text ~= "" then
    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { default_text })
  end

  -- Window configuration
  local width = vim.o.columns
  local height = vim.o.lines
  local win_width = math.min(60, math.floor(width * 0.9))
  local win_height = 1
  
  local border = config.get_border(config.options.input.border)
  
  -- CRITICAL: Position dialog properly for LSP rename
  -- Position ABOVE cursor (row = -2) so it doesn't cover the symbol being renamed
  -- This ensures LSP can still "see" the symbol under cursor in original buffer
  local win_config = {
    relative = "cursor",  -- Position relative to cursor
    width = win_width,
    height = win_height,
    row = -2,  -- Above cursor (negative moves up)
    col = 0,   -- Left-aligned with cursor
    style = "minimal",
    border = border,
    title = opts.prompt and (" " .. opts.prompt .. " ") or nil,
    title_pos = "left",
    noautocmd = true,
  }

  -- Open window
  local winid = vim.api.nvim_open_win(bufnr, true, win_config)
  state.winid = winid

  -- Apply highlights
  local themes = require("lite-ui.themes")
  vim.api.nvim_set_option_value("winhighlight",
    string.format("Normal:%s,FloatBorder:%s,FloatTitle:%s",
      themes.hl_groups.input.background,
      themes.hl_groups.input.border,
      themes.hl_groups.input.title
    ), { win = winid })

  -- Keymaps - Confirm
  vim.keymap.set({"n", "i"}, "<CR>", function()
    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    close_and_callback(lines[1] or "")
  end, { buffer = bufnr, nowait = true, silent = true })

  -- Keymaps - Cancel
  vim.keymap.set({"n", "i"}, "<Esc>", function()
    close_and_callback(nil)
  end, { buffer = bufnr, nowait = true, silent = true })

  vim.keymap.set("n", "q", function()
    close_and_callback(nil)
  end, { buffer = bufnr, nowait = true, silent = true })

  vim.keymap.set({"n", "i"}, "<C-c>", function()
    close_and_callback(nil)
  end, { buffer = bufnr, nowait = true, silent = true })

  -- Auto-close on buffer leave
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
  vim.schedule(function()
    if not vim.api.nvim_win_is_valid(winid) then
      return
    end
    
    -- Set cursor to end of text so user can edit
    if default_text and default_text ~= "" then
      -- Place cursor at end of default text
      vim.api.nvim_win_set_cursor(winid, {1, #default_text})
    else
      -- Empty text, place at beginning
      vim.api.nvim_win_set_cursor(winid, {1, 0})
    end
    
    -- Enter insert mode to allow editing
    if config.options.input.start_in_insert then
      vim.cmd("startinsert!")  -- Using startinsert! to append after text
    end
  end)
end

return M
