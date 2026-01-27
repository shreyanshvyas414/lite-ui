local M = {}

-- Module-level state
local state = {
  callback = nil,
  items = nil,
  bufnr = nil,
  winid = nil,
}

local function close_and_callback(item, idx)
  -- Get the callback before clearing state
  local callback = state.callback

  -- Clear state first
  state.callback = nil
  state.items = nil
  state.bufnr = nil

  -- Close window if it's still valid
  if state.winid and vim.api.nvim_win_is_valid(state.winid) then
    pcall(vim.api.nvim_win_close, state.winid, true)
  end
  state.winid = nil

  -- Call the callback if it exists
  if callback then
    vim.schedule(function()
      callback(item, idx)
    end)
  end
end

local function format_items(items, format_item, show_numbers, number_format)
  local formatted = {}

  for i, item in ipairs(items) do
    local text
    if format_item then
      -- Use custom formatter if provided
      text = format_item(item)
    elseif type(item) == "table" then
      -- For tables, try common display fields
      text = item.text or item.label or item.name or vim.inspect(item)
    else
      -- Convert to string
      text = tostring(item)
    end

    -- Add line number prefix if enabled
    if show_numbers then
      text = string.format(number_format, i, text)
    end

    table.insert(formatted, text)
  end

  return formatted
end

local function calculate_window_config(prompt, items_count, formatted_lines)
  local config = require("lite-ui.config")
  local width = vim.o.columns
  local height = vim.o.lines

  -- Calculate width based on longest line
  local max_width = vim.api.nvim_strwidth(prompt or "Select:")
  for _, line in ipairs(formatted_lines) do
    max_width = math.max(max_width, vim.api.nvim_strwidth(line))
  end

  -- Add padding for scrollbar and borders
  local min_width = math.max(config.options.select.min_width, max_width + 4)
  
  local max_width_value = config.options.select.max_width
  if max_width_value < 1 then
    max_width_value = math.floor(width * max_width_value)
  end
  
  local win_width = math.min(min_width, max_width_value)

  -- Calculate height (cap at max_height, will scroll if more)
  local win_height = math.min(items_count, config.options.select.max_height)

  -- Get border configuration
  local border = config.get_border(config.options.select.border)

  -- Position based on config
  local win_config = {
    relative = config.options.select.relative,
    width = win_width,
    height = win_height,
    style = "minimal",
    border = border,
    title = prompt and (" " .. prompt .. " ") or " Select ",
    title_pos = "left",
  }

  -- Calculate position
  if config.options.select.relative == "cursor" then
    win_config.row = 1
    win_config.col = 0
  else
    -- Centered in editor
    local row = math.floor((height - win_height) / 2) - 1
    local col = math.floor((width - win_width) / 2)
    win_config.row = row
    win_config.col = col
  end

  return win_config
end

local function create_select_buffer(formatted_lines)
  -- Create scratch buffer
  local bufnr = vim.api.nvim_create_buf(false, true)

  -- Set buffer options
  vim.bo[bufnr].buftype = "nofile"
  vim.bo[bufnr].bufhidden = "wipe"
  vim.bo[bufnr].filetype = "LiteUISelect"
  vim.bo[bufnr].modifiable = false -- Read-only

  -- Populate buffer with items
  vim.bo[bufnr].modifiable = true
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, formatted_lines)
  vim.bo[bufnr].modifiable = false

  return bufnr
end

local function setup_keymaps(bufnr, items_count)
  -- Confirm selection on Enter
  vim.keymap.set("n", "<CR>", function()
    local cursor = vim.api.nvim_win_get_cursor(0)
    local idx = cursor[1] -- Line number is 1-indexed

    if idx >= 1 and idx <= items_count then
      close_and_callback(state.items[idx], idx)
    end
  end, { buffer = bufnr, nowait = true, desc = "Confirm selection" })

  -- Cancel on Escape and q
  vim.keymap.set("n", "<Esc>", function()
    close_and_callback(nil, nil)
  end, { buffer = bufnr, nowait = true, desc = "Cancel selection" })

  vim.keymap.set("n", "q", function()
    close_and_callback(nil, nil)
  end, { buffer = bufnr, nowait = true, desc = "Cancel selection" })

  -- Number key quick selection (1-9)
  for i = 1, math.min(9, items_count) do
    vim.keymap.set("n", tostring(i), function()
      close_and_callback(state.items[i], i)
    end, { buffer = bufnr, nowait = true, desc = "Select item " .. i })
  end

  -- Navigation shortcuts
  vim.keymap.set("n", "<Down>", "j", { buffer = bufnr, remap = true, desc = "Move down" })
  vim.keymap.set("n", "<Up>", "k", { buffer = bufnr, remap = true, desc = "Move up" })
  vim.keymap.set("n", "J", "5j", { buffer = bufnr, remap = true, desc = "Move down 5 lines" })
  vim.keymap.set("n", "K", "5k", { buffer = bufnr, remap = true, desc = "Move up 5 lines" })
  vim.keymap.set("n", "gg", "gg", { buffer = bufnr, remap = true, desc = "Go to top" })
  vim.keymap.set("n", "G", "G", { buffer = bufnr, remap = true, desc = "Go to bottom" })
end

local function setup_autocmds(bufnr)
  -- Cancel if user leaves the buffer
  vim.api.nvim_create_autocmd("BufLeave", {
    buffer = bufnr,
    once = true,
    callback = function()
      if state.callback then
        close_and_callback(nil, nil)
      end
    end,
  })
end

local function setup_window_options(winid)
  local config = require("lite-ui.config")
  local themes = require("lite-ui.themes")

  -- Apply user-configured window options
  for opt, value in pairs(config.options.select.win_options) do
    pcall(vim.api.nvim_set_option_value, opt, value, { win = winid })
  end

  -- Apply themed highlight groups
  pcall(vim.api.nvim_set_option_value, "winhighlight",
    string.format("Normal:%s,FloatBorder:%s,FloatTitle:%s,CursorLine:%s",
      themes.hl_groups.select.background,
      themes.hl_groups.select.border,
      themes.hl_groups.select.title,
      themes.hl_groups.select.selected
    ), { win = winid })

  -- Enable cursorline for visual feedback
  vim.wo[winid].cursorline = true
  vim.wo[winid].cursorlineopt = "both"

  -- Disable line numbers in the select window
  vim.wo[winid].number = false
  vim.wo[winid].relativenumber = false
end

function M.select(items, opts, on_choice)
  opts = opts or {}
  local config = require("lite-ui.config")

  -- Check if select is enabled
  if not config.options.select.enabled then
    -- Fall back to vim.ui.select (will use default)
    return on_choice(nil, nil)
  end

  -- Validate items
  if not items or #items == 0 then
    return on_choice(nil, nil)
  end

  -- Close any existing select window
  if state.winid and vim.api.nvim_win_is_valid(state.winid) then
    pcall(vim.api.nvim_win_close, state.winid, true)
  end

  -- Store state
  state.callback = on_choice
  state.items = items

  -- Format items for display
  local formatted_lines = format_items(
    items,
    opts.format_item,
    config.options.select.show_numbers,
    config.options.select.number_format
  )

  -- Create buffer
  local bufnr = create_select_buffer(formatted_lines)
  state.bufnr = bufnr

  -- Calculate window configuration
  local win_config = calculate_window_config(opts.prompt, #items, formatted_lines)

  -- Open window
  local ok, winid = pcall(vim.api.nvim_open_win, bufnr, true, win_config)
  if not ok then
    -- Fallback if window creation fails
    state.callback = nil
    state.items = nil
    state.bufnr = nil
    return on_choice(nil, nil)
  end
  
  state.winid = winid

  -- Set up window options
  setup_window_options(winid)

  -- Set up keymaps
  setup_keymaps(bufnr, #items)

  -- Set up autocmds
  setup_autocmds(bufnr)

  -- Position cursor on first item
  pcall(vim.api.nvim_win_set_cursor, winid, { 1, 0 })
end

return M
