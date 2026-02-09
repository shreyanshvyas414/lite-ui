# lite-ui.nvim

Minimal, fast, dependency-free UI for modern Neovim.

## Overview

lite-ui.nvim is a lightweight alternative to dressing.nvim that enhances vim.ui.input and vim.ui.select with beautiful floating windows, built-in themes, and zero dependencies.

## Why lite-ui.nvim?

dressing.nvim has been archived, and while alternatives like snacks.nvim exist, they often bundle much more than just UI. lite-ui.nvim focuses on one thing: making vim.ui.* beautiful, fast, and hackable.

## Features

- Fast & lightweight (zero dependencies, pure Lua)
- 11+ pre-built themes (Kanagawa, GitHub Dark, Catppuccin, Tokyo Night, etc.)
- Easy custom theme creation
- Vim-like navigation with number quick-selection
- Drop-in replacement for any plugin using vim.ui.*
- Smart positioning (cursor-relative or editor-centered)
- Sensible defaults (no configuration required)
- LSP rename support with automatic name prefilling
- Thoroughly tested with major LSP servers

## Installation

### lazy.nvim

```lua
{
  "shreyanshvyas414/lite-ui",
  config = function()
    require("lite-ui").setup({
      theme = "kanagawa",
      input = {
        auto_detect_cword = true, -- Important for LSP rename
      },
    })
  end
}
```

### packer.nvim

```lua
use {
  "shreyanshvyas414/lite-ui",
  config = function()
    require("lite-ui").setup({
      theme = "catppuccin",
      input = { auto_detect_cword = true }
    })
  end
}
```

### vim-plug

```vim
Plug 'shreyanshvyas414/lite-ui'
```

Then in init.lua:
```lua
require("lite-ui").setup({
  theme = "tokyonight",
  input = { auto_detect_cword = true }
})
```

## Quick Start

Add to init.lua:

```lua
require("lite-ui").setup({
  theme = "kanagawa", -- Choose your theme
})
```

Available themes: default, kanagawa, github-dark, catppuccin, tokyonight, gruvbox, nord, dracula, onedark, rose-pine, nightfox

## Configuration

```lua
require("lite-ui").setup({
  theme = "github-dark",
  
  input = {
    enabled = true,
    relative = "cursor",      -- "cursor" or "editor"
    border = "rounded",        -- "rounded", "single", "double", "solid", "shadow"
    min_width = 20,
    max_width = 0.9,           -- 90% of screen width
    auto_detect_cword = true,  -- Auto-prefill symbol for rename
    start_in_insert = true,
    win_options = {
      winblend = 10,           -- Transparency (0-100)
    },
  },
  
  select = {
    enabled = true,
    relative = "editor",
    border = "rounded",
    min_width = 40,
    max_width = 0.9,
    max_height = 15,
    win_options = {
      winblend = 10,
      cursorline = true,
    },
    show_numbers = true,       -- Show numbers for quick selection
    number_format = "%d. %s",
  },
})
```

## LSP Rename Setup

```lua
require("lite-ui").setup({
  theme = "kanagawa",
  input = {
    auto_detect_cword = true,
    relative = "cursor",
  },
})

-- LSP configuration
local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

lspconfig.lua_ls.setup({ capabilities = capabilities })
lspconfig.pyright.setup({ capabilities = capabilities })
lspconfig.tsserver.setup({ capabilities = capabilities })

-- Keymaps
vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename)
vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "K", vim.lsp.buf.hover)
```

## Keymaps

Input Window:
- CR (Normal/Insert) - Confirm
- Esc (Normal/Insert) - Cancel
- q (Normal) - Cancel

Select Window:
- CR - Confirm selection
- Esc / q - Cancel
- j/k or Down/Up - Navigate
- J/K - Jump 5 lines
- gg/G - Jump to top/bottom
- 1-9 - Quick select items

## Theming

Use built-in themes:

```lua
require("lite-ui").setup({ theme = "kanagawa" })
```

Switch themes dynamically:

```vim
:LiteUITheme
:LiteUITheme tokyonight
```

Create custom themes:

```lua
require("lite-ui").setup({
  theme = {
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

## Troubleshooting

LSP rename shows empty %:
- Ensure auto_detect_cword = true in setup
- Verify LSP is attached with :LspInfo
- Place cursor directly on symbol name

LSP rename error:
- Check LSP is attached with :LspInfo
- Clear cache: rm -rf ~/.local/state/nvim ~/.cache/nvim
- Verify relative = "cursor" in input config

Dialog covers symbol:
- Change to relative = "cursor" instead of "editor"

Text not prefilled:
- Enable auto_detect_cword = true
- Ensure cursor is on symbol in definition

## Commands

```vim
:LiteUITheme          " List available themes
:LiteUITheme dracula  " Switch to theme
:LiteUIDemo           " Test input and select
```

## Comparison with dressing.nvim

| Feature | lite-ui.nvim | dressing.nvim |
|---------|--------------|---------------|
| Dependencies | 0 | 0 |
| Lines of Code | ~400 | ~1000+ |
| Telescope Support | Yes | Yes |
| Built-in Providers | Input & Select | Input, Select, + Telescope |
| Configuration | Simple | Extensive |
| Performance | Minimal overhead | Slightly more overhead |

## License

MIT

## Credits

Inspired by dressing.nvim

