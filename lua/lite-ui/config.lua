local M = {}

M.defaults = {
  -- Theme configuration
  theme = "default", -- Can be: "default", "kanagawa", "github-dark", "catppuccin", "tokyonight", "gruvbox", "nord", "dracula", "onedark", "rose-pine", "nightfox", or custom table
  
  input = {
    enabled = true,
    -- Window position: "cursor" or "editor"
    relative = "cursor",
    -- Preferred border style: "rounded", "single", "double", "solid", "shadow", or custom array
    border = "rounded",
    -- Minimum and maximum width
    min_width = 20,
    max_width = 0.9, -- 90% of screen width
    -- Window options
    win_options = {
      winblend = 0, -- Transparency (0-100)
    },
    -- Prompt icon/prefix (optional)
    prompt_prefix = "",
    -- Start in insert mode
    start_in_insert = true,
    -- Override theme colors for input specifically (optional)
    theme_override = nil,
  },
  select = {
    enabled = true,
    relative = "editor",
    border = "rounded",
    min_width = 40,
    max_width = 0.9,
    -- Maximum height (number of items to show before scrolling)
    max_height = 15,
    -- Window options
    win_options = {
      winblend = 0,
      cursorline = true,
    },
    -- Show item numbers for quick selection
    show_numbers = true,
    -- Format for numbered items (default: "%d. %s")
    number_format = "%d. %s",
    -- Override theme colors for select specifically (optional)
    theme_override = nil,
  },
  -- Global settings
  border_chars = {
    rounded = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
    single = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
    double = { "╔", "═", "╗", "║", "╝", "═", "╚", "║" },
    solid = { "▛", "▀", "▜", "▐", "▟", "▄", "▙", "▌" },
    shadow = { "", "", "", " ", "", "▄", "▄", " " },
  },
}

M.options = {}

function M.setup(user_config)
  M.options = vim.tbl_deep_extend("force", M.defaults, user_config or {})
  
  -- Apply theme if specified
  local themes = require("lite-ui.themes")
  
  if type(M.options.theme) == "string" then
    -- Apply named theme
    themes.apply_theme(M.options.theme)
  elseif type(M.options.theme) == "table" then
    -- Apply custom theme
    themes.add_theme("_custom", M.options.theme)
    themes.apply_theme("_custom")
  end
end

-- Helper to get border chars
function M.get_border(border_style)
  if type(border_style) == "table" then
    return border_style
  end
  return M.options.border_chars[border_style] or border_style
end

return M
