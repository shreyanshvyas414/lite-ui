# lite-ui.nvim

A minimal, fast, dependency-free alternative to dressing.nvim for modern Neovim UI. Provides beautiful, customizable floating windows for `vim.ui.input` and `vim.ui.select`.

## ✨ Features

- 🚀 **Fast & Lightweight**: Zero dependencies, pure Lua implementation
- 🎨 **Customizable**: Configure borders, positioning, colors, and more
- ⌨️  **Intuitive Keymaps**: Vim-like navigation with number quick-selection
- 🔧 **Drop-in Replacement**: Works with any plugin that uses `vim.ui.*`
- 🎯 **Smart Positioning**: Cursor-relative or editor-centered windows
- 📦 **No Configuration Required**: Sensible defaults out of the box

## 📦 Installation

### lazy.nvim

```lua
{
  "shreyanshvyas414/lite-ui.nvim",
  config = function()
    require("lite-ui").setup()
  end
}
```

### packer.nvim

```lua
use {
  "shreyanshvyas414/lite-ui.nvim",
  config = function()
    require("lite-ui").setup()
  end
}
```

### vim-plug

```vim
Plug 'shreyanshvyas414/lite-ui.nvim'
```

Then in your init.lua:
```lua
require("lite-ui").setup()
```

## 🎯 Usage

Just call `setup()` in your config - lite-ui will automatically enhance `vim.ui.input` and `vim.ui.select` for all plugins that use them (Telescope, LSP rename, etc.).

### Basic Setup

```lua
require("lite-ui").setup()
```

### Custom Configuration

```lua
require("lite-ui").setup({
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
