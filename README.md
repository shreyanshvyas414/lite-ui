# lite-ui.nvim

A minimal, fast, dependency-free alternative to dressing.nvim for modern Neovim UI. Provides beautiful, customizable floating windows for `vim.ui.input` and `vim.ui.select` with **built-in themes**!

## ✨ Features

- 🚀 **Fast & Lightweight**: Zero dependencies, pure Lua implementation
- 🎨 **Beautiful Themes**: 11+ pre-built themes (Kanagawa, GitHub Dark, Catppuccin, Tokyo Night, and more!)
- 🎯 **Custom Themes**: Easy custom theme creation
- ⌨️  **Intuitive Keymaps**: Vim-like navigation with number quick-selection
- 🔧 **Drop-in Replacement**: Works with any plugin that uses `vim.ui.*`
- 🎯 **Smart Positioning**: Cursor-relative or editor-centered windows
- 📦 **No Configuration Required**: Sensible defaults out of the box

## 📸 Theme Showcase

<details>
<summary>🌊 Kanagawa</summary>

```lua
require("lite-ui").setup({ theme = "kanagawa" })
```
Deep blues and warm accents inspired by the iconic Japanese wave painting.
</details>

<details>
<summary>🐙 GitHub Dark</summary>

```lua
require("lite-ui").setup({ theme = "github-dark" })
```
Clean and professional, matching GitHub's dark interface.
</details>

<details>
<summary>🌸 Catppuccin</summary>

```lua
require("lite-ui").setup({ theme = "catppuccin" })
```
Soothing pastel colors that are easy on the eyes.
</details>

<details>
<summary>🌃 Tokyo Night</summary>

```lua
require("lite-ui").setup({ theme = "tokyonight" })
```
Vibrant night-time city aesthetic with electric blues.
</details>

<details>
<summary>🍂 Gruvbox</summary>

```lua
require("lite-ui").setup({ theme = "gruvbox" })
```
Retro warm colors with high contrast.
</details>

<details>
<summary>❄️ Nord</summary>

```lua
require("lite-ui").setup({ theme = "nord" })
```
Arctic, bluish-grey color palette.
</details>

<details>
<summary>🧛 Dracula</summary>

```lua
require("lite-ui").setup({ theme = "dracula" })
```
Dark theme with vibrant, punchy colors.
</details>

<details>
<summary>🌙 Onedark</summary>

```lua
require("lite-ui").setup({ theme = "onedark" })
```
Inspired by Atom's One Dark theme.
</details>

<details>
<summary>🌹 Rose Pine</summary>

```lua
require("lite-ui").setup({ theme = "rose-pine" })
```
Natural pine, faux fur, and a bit of soho vibes.
</details>

<details>
<summary>🦊 Nightfox</summary>

```lua
require("lite-ui").setup({ theme = "nightfox" })
```
Highly accessible with vibrant colors.
</details>

## 📦 Installation

### lazy.nvim

```lua
{
  "shreyanshvyas414/lite-ui.nvim",
  config = function()
    require("lite-ui").setup({
      theme = "kanagawa" -- or any other theme!
    })
  end
}
```

### packer.nvim

```lua
use {
  "shreyanshvyas414/lite-ui.nvim",
  config = function()
    require("lite-ui").setup({ theme = "catppuccin" })
  end
}
```

### vim-plug

```vim
Plug 'shreyanshvyas414/lite-ui.nvim'
```

Then in your init.lua:
```lua
require("lite-ui").setup({ theme = "tokyonight" })
```

## 🎯 Usage

Just call `setup()` in your config - lite-ui will automatically enhance `vim.ui.input` and `vim.ui.select` for all plugins that use them (Telescope, LSP rename, etc.).

### Basic Setup (with theme)

```lua
require("lite-ui").setup({
  theme = "kanagawa" -- Choose your theme!
})
```

### Custom Configuration

```lua
require("lite-ui").setup({
  theme = "github-dark", -- Choose a theme
  
  input = {
    enabled = true,
    relative = "cursor",      -- "cursor" or "editor"
    border = "rounded",        -- "rounded", "single", "double", "solid", "shadow", or custom array
    min_width = 20,
    max_width = 0.9,           -- 90% of screen width (or absolute number)
    win_options = {
      winblend = 10,           -- Transparency (0-100)
    },
    start_in_insert = true,    -- Start in insert mode
  },
  select = {
    enabled = true,
    relative = "editor",       -- "cursor" or "editor"
    border = "rounded",
    min_width = 40,
    max_width = 0.9,
    max_height = 15,           -- Maximum items shown before scrolling
    win_options = {
      winblend = 10,
      cursorline = true,
    },
    show_numbers = true,       -- Show numbers for quick selection
    number_format = "%d. %s",  -- Format for numbered items
  },
})
```

## ⌨️  Keymaps

### Input Window
- `<CR>` (Normal/Insert) - Confirm input
- `<Esc>` (Normal/Insert) - Cancel
- `q` (Normal) - Cancel

### Select Window
- `<CR>` - Confirm selection
- `<Esc>` / `q` - Cancel
- `j` / `k` / `<Down>` / `<Up>` - Navigate
- `J` / `K` - Jump 5 lines
- `gg` / `G` - Jump to top/bottom
- `1-9` - Quick select items 1-9

## 🎨 Theming

### Available Themes

lite-ui comes with 11 beautiful pre-built themes:
- `default` - Uses Neovim's default colors
- `kanagawa` - Deep blues and warm accents
- `github-dark` - Clean GitHub dark interface
- `catppuccin` - Soothing pastel colors
- `tokyonight` - Vibrant night-time aesthetic
- `gruvbox` - Retro warm colors
- `nord` - Arctic bluish-grey palette
- `dracula` - Dark with vibrant colors
- `onedark` - Inspired by Atom's One Dark
- `rose-pine` - Natural pine and soho vibes
- `nightfox` - Highly accessible with vibrant colors

### Using Themes

```lua
-- Set theme in setup
require("lite-ui").setup({
  theme = "kanagawa"
})
```

### Switching Themes Dynamically

```lua
-- List available themes
:LiteUITheme

-- Switch to a different theme
:LiteUITheme tokyonight
```

### Testing Themes

Try out the UI with a demo:
```lua
:LiteUIDemo
```

### Creating Custom Themes

You can create your own themes! Each theme defines colors for different UI elements:

```lua
require("lite-ui").setup({
  theme = {
    -- Color definitions (can be hex or highlight group names)
    border = { fg = "#89B4FA", bg = "#1E1E2E" },
    background = { bg = "#1E1E2E" },
    title = { fg = "#CBA6F7", bold = true },
    selected = { fg = "#CDD6F4", bg = "#45475A", bold = true },
    prompt = { fg = "#F5C2E7", bold = true },
    input_text = { fg = "#CDD6F4", bg = "#1E1E2E" },
    select_text = { fg = "#CDD6F4", bg = "#1E1E2E" },
    number = { fg = "#A6E3A1", bg = "#1E1E2E" },
  }
})
```

Or add it permanently:

```lua
local lite_ui = require("lite-ui")

-- Add custom theme
lite_ui.themes.add_theme("my_theme", {
  border = { fg = "#FF0000" },
  background = { bg = "#000000" },
  -- ... other colors
})

-- Use it
lite_ui.setup({ theme = "my_theme" })
```

### Theme Definition Reference

```lua
{
  border = "FloatBorder",           -- Border color (string or table)
  background = "NormalFloat",        -- Background color
  title = "FloatTitle",              -- Title/prompt color
  selected = "PmenuSel",             -- Selected item color (select only)
  prompt = "Title",                  -- Prompt text color (input only)
  input_text = "Normal",             -- Input text color
  select_text = "Normal",            -- Select item text color
  number = "LineNr",                 -- Item number color (select only)
}
```

You can use:
- Highlight group names (strings): `"Normal"`, `"Title"`, etc.
- Direct color definitions (tables): `{ fg = "#FFFFFF", bg = "#000000", bold = true }`

## 🎨 Border Styles

Available border styles:
- `rounded` - ╭─╮│╯─╰│
- `single` - ┌─┐│┘─└│
- `double` - ╔═╗║╝═╚║
- `solid` - ▛▀▜▐▟▄▙▌
- `shadow` - Shadow effect
- Custom array - Provide your own 8-character array

## 🔧 Advanced Configuration

### Disable Specific Components

```lua
require("lite-ui").setup({
  input = {
    enabled = false,  -- Disable input, use default vim.ui.input
  },
  select = {
    enabled = true,   -- Keep select enabled
  },
})
```

### Custom Border Characters

```lua
require("lite-ui").setup({
  input = {
    border = { "╔", "═", "╗", "║", "╝", "═", "╚", "║" },
  },
})
```

### Restore Original vim.ui

```lua
-- If you need to restore the original vim.ui functions
require("lite-ui").restore()
```

## 🤝 Integrations

Works seamlessly with:
- Telescope
- LSP (rename, code actions, etc.)
- nvim-cmp
- Any plugin using `vim.ui.input` or `vim.ui.select`

## 🆚 Comparison with dressing.nvim

| Feature | lite-ui.nvim | dressing.nvim |
|---------|--------------|---------------|
| Dependencies | 0 | 0 |
| Lines of Code | ~400 | ~1000+ |
| Telescope Support | ✅ | ✅ |
| Built-in Providers | Input & Select | Input, Select, + Telescope |
| Configuration | Simple | Extensive |
| Performance | Minimal overhead | Slightly more overhead |

lite-ui.nvim is perfect if you want a simple, fast UI enhancement without extra complexity.

## 📝 License

MIT

## 🙏 Credits

Inspired by [dressing.nvim](https://github.com/stevearc/dressing.nvim)
