local M = {}

-- Module level state to track the active input session
local state = {
  callback = nil,
  bufnr = nil,
  winid = nil,
}

local function close_and_callback(result)
  -- Get the callback before clearing state
  local callback = state.callback

  -- Clear state first
  state.callback = nil
  state.bufnr = nil

  -- Close window if it's still valid
  if state.winid and vim.api.nvim_win_is_valid(state.winid) then
    pcall(vim.api.nvim_win_close, state.winid, true)
  end
  state.winid = nil

  -- Call the callback if it exists
  if callback then
    vim.schedule(function()
      callback(result)
    end)
  end
end

local function create_input_buffer(default_text)
  -- Create a scratch buffer (unlisted, temporary)
  local bufnr = vim.api.nvim_create_buf(false, true)

  -- Set buffer options
  vim.bo[bufnr].buftype = "nofile" -- Changed from "prompt" to avoid % character
  vim.bo[bufnr].bufhidden = "wipe" -- Delete buffer when hidden
  vim.bo[bufnr].filetype = "LiteUIInput" -- For custom highlighting if needed
  vim.bo[bufnr].swapfile = false -- Disable swap file

  -- Set the default text if provided
  if default_text and default_text ~= "" then
    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { default_text })
    -- Move cursor to end of line in the buffer
    vim.api.nvim_buf_call(bufnr, function()
      vim.cmd("normal! $")
    end)
  end

  return bufnr
end

local function calculate_window_config(prompt)
  local config = require("lite-ui.config")
  local width = vim.o.columns
  local height = vim.o.lines

  -- Calculate window dimensions
  local prompt_width = vim.api.nvim_strwidth(prompt or "")
  local min_width = math.max(config.options.input.min_width, prompt_width + 10)
  
  local max_width_value = config.options.input.max_width
  if max_width_value < 1 then
    max_width_value = math.floor(width * max_width_value)
  end
  
  local win_width = math.min(min_width, max_width_value)
  local win_height = 1

  -- Get border configuration
  local border = config.get_border(config.options.input.border)

  -- Position based on config
  local win_config = {
    relative = config.options.input.relative,
    width = win_width,
    height = win_height,
    style = "minimal",
    border = border,
    title = prompt and (" " .. prompt .. " ") or nil,
    title_pos = "left",
  }

  -- Calculate position based on relative mode
  if config.options.input.relative == "cursor" then
    win_config.row = 1 -- 1 line below cursor
    win_config.col = 0 -- Aligned with cursor
  else
    -- Centered in editor
    local row = math.floor((height - win_height) / 2) - 1
    local col = math.floor((width - win_width) / 2)
    win_config.row = row
    win_config.col = col
  end

  return win_config
end

local function setup_keymaps(bufnr)
  -- Confirm on Enter (in both normal and insert mode)
  vim.keymap.set("n", "<CR>", function()
    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    local result = table.concat(lines, "\n") -- Join all lines
    close_and_callback(result)
  end, { buffer = bufnr, nowait = true, desc = "Confirm input" })

  vim.keymap.set("i", "<CR>", function()
    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    local result = table.concat(lines, "\n") -- Join all lines
    close_and_callback(result)
  end, { buffer = bufnr, nowait = true, desc = "Confirm input" })

  -- Cancel on Escape (in both modes)
  vim.keymap.set("n", "<Esc>", function()
    close_and_callback(nil)
  end, { buffer = bufnr, nowait = true, desc = "Cancel input" })

  vim.keymap.set("i", "<Esc>", function()
    close_and_callback(nil)
  end, { buffer = bufnr, nowait = true, desc = "Cancel input" })

  -- Cancel on Ctrl-C (common in many editors)
  vim.keymap.set({ "n", "i" }, "<C-c>", function()
    close_and_callback(nil)
  end, { buffer = bufnr, nowait = true, desc = "Cancel input" })

  -- Cancel on quit (normal mode only)
  vim.keymap.set("n", "q", function()
    close_and_callback(nil)
  end, { buffer = bufnr, nowait = true, desc = "Cancel input" })
end

local function setup_autocmds(bufnr)
  -- Cancel if user leaves the buffer
  vim.api.nvim_create_autocmd("BufLeave", {
    buffer = bufnr,
    once = true,
    callback = function()
      -- Only cancel if callback still exists (not already called)
      if state.callback then
        close_and_callback(nil)
      end
    end,
  })
end

function M.input(opts, on_confirm)
  opts = opts or {}
  local config = require("lite-ui.config")

  -- Check if input is enabled
  if not config.options.input.enabled then
    -- Fall back to default vim.ui.input
    local result = vim.fn.input({
      prompt = opts.prompt or "",
      default = opts.default or "",
      completion = opts.completion,
    })
    return on_confirm(result)
  end

  -- Auto-detect default text for LSP rename if not provided
  -- This handles cases where LSP doesn't send a default value
  local default_text = opts.default
  if (not default_text or default_text == "") and config.options.input.auto_detect_cword then
    -- Check if this looks like an LSP rename (has "name" in prompt)
    local prompt_lower = (opts.prompt or ""):lower()
    if prompt_lower:match("name") or prompt_lower:match("rename") then
      -- Get the word under cursor as default
      default_text = vim.fn.expand("<cword>")
    end
  end

  -- Close any existing input window
  if state.winid and vim.api.nvim_win_is_valid(state.winid) then
    pcall(vim.api.nvim_win_close, state.winid, true)
  end

  -- Store the callback
  state.callback = on_confirm

  -- Create buffer with auto-detected or provided default
  local bufnr = create_input_buffer(default_text)
  state.bufnr = bufnr

  -- Calculate window configuration
  local win_config = calculate_window_config(opts.prompt)

  -- Open the window
  local ok, winid = pcall(vim.api.nvim_open_win, bufnr, true, win_config)
  if not ok then
    -- Fallback if window creation fails
    local result = vim.fn.input({
      prompt = opts.prompt or "",
      default = default_text or "",
    })
    state.callback = nil
    state.bufnr = nil
    return on_confirm(result)
  end
  
  state.winid = winid

  -- Apply window options from config
  for opt, value in pairs(config.options.input.win_options) do
    pcall(vim.api.nvim_set_option_value, opt, value, { win = winid })
  end

  -- Apply themed highlight groups
  local themes = require("lite-ui.themes")
  pcall(vim.api.nvim_set_option_value, "winhighlight", 
    string.format("Normal:%s,FloatBorder:%s,FloatTitle:%s",
      themes.hl_groups.input.background,
      themes.hl_groups.input.border,
      themes.hl_groups.input.title
    ), { win = winid })

  -- Set up keymaps
  setup_keymaps(bufnr)

  -- Set up autocmds
  setup_autocmds(bufnr)

  -- Enter insert mode at the end of the line if configured
  if config.options.input.start_in_insert then
    vim.schedule(function()
      -- Make sure we're in the right window
      if vim.api.nvim_win_is_valid(winid) then
        vim.api.nvim_set_current_win(winid)
        -- Move to end of line and enter insert mode
        vim.cmd("normal! $")
        vim.cmd("startinsert!")
      end
    end)
  end
end

return M
