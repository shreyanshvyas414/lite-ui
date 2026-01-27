local M = {}

-- Define pre-built themes
M.themes = {
  -- Default theme (uses Neovim's default colors)
  default = {
    border = "FloatBorder",
    background = "NormalFloat",
    title = "FloatTitle",
    selected = "PmenuSel",
    prompt = "Title",
    input_text = "Normal",
    select_text = "Normal",
  },

  -- Kanagawa inspired theme
  kanagawa = {
    border = { fg = "#54546D", bg = "#1F1F28" },
    background = { bg = "#1F1F28" },
    title = { fg = "#7E9CD8", bg = "#1F1F28", bold = true },
    selected = { fg = "#DCD7BA", bg = "#2D4F67", bold = true },
    prompt = { fg = "#7FB4CA", bold = true },
    input_text = { fg = "#DCD7BA", bg = "#1F1F28" },
    select_text = { fg = "#C8C093", bg = "#1F1F28" },
    number = { fg = "#7AA89F", bg = "#1F1F28" },
  },

  -- GitHub Dark theme
  ["github-dark"] = {
    border = { fg = "#30363D", bg = "#0D1117" },
    background = { bg = "#0D1117" },
    title = { fg = "#58A6FF", bg = "#0D1117", bold = true },
    selected = { fg = "#C9D1D9", bg = "#1F6FEB", bold = true },
    prompt = { fg = "#79C0FF", bold = true },
    input_text = { fg = "#C9D1D9", bg = "#0D1117" },
    select_text = { fg = "#C9D1D9", bg = "#0D1117" },
    number = { fg = "#56D364", bg = "#0D1117" },
  },

  -- Catppuccin Mocha inspired theme
  catppuccin = {
    border = { fg = "#585B70", bg = "#1E1E2E" },
    background = { bg = "#1E1E2E" },
    title = { fg = "#89B4FA", bg = "#1E1E2E", bold = true },
    selected = { fg = "#CDD6F4", bg = "#45475A", bold = true },
    prompt = { fg = "#F5C2E7", bold = true },
    input_text = { fg = "#CDD6F4", bg = "#1E1E2E" },
    select_text = { fg = "#CDD6F4", bg = "#1E1E2E" },
    number = { fg = "#A6E3A1", bg = "#1E1E2E" },
  },

  -- Tokyo Night inspired theme
  tokyonight = {
    border = { fg = "#565F89", bg = "#1A1B26" },
    background = { bg = "#1A1B26" },
    title = { fg = "#7AA2F7", bg = "#1A1B26", bold = true },
    selected = { fg = "#C0CAF5", bg = "#283457", bold = true },
    prompt = { fg = "#BB9AF7", bold = true },
    input_text = { fg = "#C0CAF5", bg = "#1A1B26" },
    select_text = { fg = "#A9B1D6", bg = "#1A1B26" },
    number = { fg = "#9ECE6A", bg = "#1A1B26" },
  },

  -- Gruvbox Dark theme
  gruvbox = {
    border = { fg = "#665C54", bg = "#282828" },
    background = { bg = "#282828" },
    title = { fg = "#83A598", bg = "#282828", bold = true },
    selected = { fg = "#EBDBB2", bg = "#504945", bold = true },
    prompt = { fg = "#FABD2F", bold = true },
    input_text = { fg = "#EBDBB2", bg = "#282828" },
    select_text = { fg = "#D5C4A1", bg = "#282828" },
    number = { fg = "#B8BB26", bg = "#282828" },
  },

  -- Nord theme
  nord = {
    border = { fg = "#4C566A", bg = "#2E3440" },
    background = { bg = "#2E3440" },
    title = { fg = "#88C0D0", bg = "#2E3440", bold = true },
    selected = { fg = "#ECEFF4", bg = "#434C5E", bold = true },
    prompt = { fg = "#81A1C1", bold = true },
    input_text = { fg = "#ECEFF4", bg = "#2E3440" },
    select_text = { fg = "#D8DEE9", bg = "#2E3440" },
    number = { fg = "#A3BE8C", bg = "#2E3440" },
  },

  -- Dracula theme
  dracula = {
    border = { fg = "#6272A4", bg = "#282A36" },
    background = { bg = "#282A36" },
    title = { fg = "#BD93F9", bg = "#282A36", bold = true },
    selected = { fg = "#F8F8F2", bg = "#44475A", bold = true },
    prompt = { fg = "#FF79C6", bold = true },
    input_text = { fg = "#F8F8F2", bg = "#282A36" },
    select_text = { fg = "#F8F8F2", bg = "#282A36" },
    number = { fg = "#50FA7B", bg = "#282A36" },
  },

  -- Onedark theme
  onedark = {
    border = { fg = "#3E4452", bg = "#282C34" },
    background = { bg = "#282C34" },
    title = { fg = "#61AFEF", bg = "#282C34", bold = true },
    selected = { fg = "#ABB2BF", bg = "#3E4452", bold = true },
    prompt = { fg = "#C678DD", bold = true },
    input_text = { fg = "#ABB2BF", bg = "#282C34" },
    select_text = { fg = "#ABB2BF", bg = "#282C34" },
    number = { fg = "#98C379", bg = "#282C34" },
  },

  -- Rose Pine theme
  ["rose-pine"] = {
    border = { fg = "#403D52", bg = "#191724" },
    background = { bg = "#191724" },
    title = { fg = "#9CCFD8", bg = "#191724", bold = true },
    selected = { fg = "#E0DEF4", bg = "#26233A", bold = true },
    prompt = { fg = "#C4A7E7", bold = true },
    input_text = { fg = "#E0DEF4", bg = "#191724" },
    select_text = { fg = "#E0DEF4", bg = "#191724" },
    number = { fg = "#31748F", bg = "#191724" },
  },

  -- Nightfox theme
  nightfox = {
    border = { fg = "#526176", bg = "#192330" },
    background = { bg = "#192330" },
    title = { fg = "#719CD6", bg = "#192330", bold = true },
    selected = { fg = "#CDCECF", bg = "#2B3B51", bold = true },
    prompt = { fg = "#C099FF", bold = true },
    input_text = { fg = "#CDCECF", bg = "#192330" },
    select_text = { fg = "#CDCECF", bg = "#192330" },
    number = { fg = "#81B29A", bg = "#192330" },
  },
}

-- Highlight group names
M.hl_groups = {
  input = {
    border = "LiteUIInputBorder",
    background = "LiteUIInputBackground",
    title = "LiteUIInputTitle",
    prompt = "LiteUIInputPrompt",
    text = "LiteUIInputText",
  },
  select = {
    border = "LiteUISelectBorder",
    background = "LiteUISelectBackground",
    title = "LiteUISelectTitle",
    selected = "LiteUISelectSelected",
    text = "LiteUISelectText",
    number = "LiteUISelectNumber",
  },
}

-- Apply a color definition (can be string or table)
local function apply_color(hl_group, color_def)
  if type(color_def) == "string" then
    -- Link to existing highlight group
    vim.api.nvim_set_hl(0, hl_group, { link = color_def })
  elseif type(color_def) == "table" then
    -- Direct color definition
    vim.api.nvim_set_hl(0, hl_group, color_def)
  end
end

-- Apply theme colors
function M.apply_theme(theme_name)
  local theme = M.themes[theme_name]
  
  if not theme then
    vim.notify(
      string.format("Theme '%s' not found. Using default theme.", theme_name),
      vim.log.levels.WARN
    )
    theme = M.themes.default
  end

  -- Apply input highlights
  apply_color(M.hl_groups.input.border, theme.border)
  apply_color(M.hl_groups.input.background, theme.background)
  apply_color(M.hl_groups.input.title, theme.title)
  apply_color(M.hl_groups.input.prompt, theme.prompt)
  apply_color(M.hl_groups.input.text, theme.input_text)

  -- Apply select highlights
  apply_color(M.hl_groups.select.border, theme.border)
  apply_color(M.hl_groups.select.background, theme.background)
  apply_color(M.hl_groups.select.title, theme.title)
  apply_color(M.hl_groups.select.selected, theme.selected)
  apply_color(M.hl_groups.select.text, theme.select_text)
  apply_color(M.hl_groups.select.number, theme.number or theme.select_text)
end

-- Add or override a theme
function M.add_theme(name, theme_def)
  M.themes[name] = theme_def
end

-- Get list of available themes
function M.list_themes()
  local theme_names = {}
  for name, _ in pairs(M.themes) do
    table.insert(theme_names, name)
  end
  table.sort(theme_names)
  return theme_names
end

return M
