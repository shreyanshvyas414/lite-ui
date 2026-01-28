# lite-ui.nvim - Quick Reference Guide

## 🚀 Quick Start (30 seconds)

### 1. Add to lazy.nvim plugins:
```lua
-- ~/.config/nvim/lua/plugins/lite-ui.lua
return {
  "shreyanshvyas414/lite-ui",
  lazy = false,    -- ⭐ IMPORTANT
  priority = 1000, -- ⭐ IMPORTANT
  config = function()
    require("lite-ui").setup({ theme = "kanagawa" })
  end
}
```

### 2. Clear cache and restart:
```bash
rm -rf ~/.cache/nvim ~/.local/state/nvim
nvim
```

### 3. Test it:
```lua
:LiteUIDemo  " Should show beautiful dialog!
```

**Done! 🎉**

---

## 🎨 Themes (Pick One)

```lua
-- Available themes:
theme = "default"      -- Default colors
theme = "kanagawa"     -- 🌊 Deep blues (recommended)
theme = "github-dark"  -- 🐙 GitHub style
theme = "catppuccin"   -- 🌸 Pastel colors
theme = "tokyonight"   -- 🌃 Night city
theme = "gruvbox"      -- 🍂 Retro warm
theme = "nord"         -- ❄️ Arctic blue
theme = "dracula"      -- 🧛 Dark vibrant
theme = "onedark"      -- 🌙 Atom inspired
theme = "rose-pine"    -- 🌹 Natural
theme = "nightfox"     -- 🦊 Accessible
```

---

## 🔧 Basic Configuration

```lua
require("lite-ui").setup({
  theme = "kanagawa",
  
  input = {
    enabled = true,
    relative = "cursor",      -- Or "editor" for center
    border = "rounded",        -- Or "single", "double", "solid", "shadow"
    auto_detect_cword = true,  -- Auto-fill word under cursor
    start_in_insert = true,    -- Start typing immediately
  },
  
  select = {
    enabled = true,
    relative = "editor",
    border = "rounded",
    max_height = 15,
    show_numbers = true,       -- Press 1-9 to select
  },
})
```

---

## ⌨️ Keyboard Shortcuts

### Input Dialog
| Key | Action |
|-----|--------|
| `<CR>` | Confirm |
| `<Esc>` | Cancel |
| `q` | Cancel (normal mode) |
| `<C-c>` | Cancel |

### Select Dialog
| Key | Action |
|-----|--------|
| `<CR>` | Select item |
| `j`/`k` | Move down/up |
| `J`/`K` | Jump 5 lines |
| `gg`/`G` | First/last item |
| `1`-`9` | Quick select (if enabled) |
| `<Esc>`/`q` | Cancel |

---

## 🔌 LSP Rename Setup

### Step 1: Install LSP (if not done):
```lua
-- Add to plugins:
{
  "neovim/nvim-lspconfig",
  config = function()
    require("config.lsp")
  end
}
```

### Step 2: Create LSP config:
```lua
-- ~/.config/nvim/lua/config/lsp.lua
local lspconfig = require("lspconfig")

-- Setup servers
lspconfig.lua_ls.setup({})
lspconfig.pyright.setup({})
lspconfig.ts_ls.setup({})

-- Setup keymaps
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(event)
    local opts = { buffer = event.buf }
    vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  end
})
```

### Step 3: Test it:
```lua
-- Create test.lua with:
function hello() end
hello()

-- Place cursor on 'hello' and press <leader>cr
-- Dialog should show: [hello]
```

---

## 🐛 Troubleshooting

### Dialog not showing?
```bash
# 1. Clear cache
rm -rf ~/.cache/nvim ~/.local/state/nvim

# 2. Verify lazy.nvim settings
# Check: lazy = false and priority = 1000

# 3. Test manually
nvim
:lua vim.ui.input({prompt = "Test: "}, function(x) print(x) end)
```

### Text hard to read?
```lua
-- Try a different theme
require("lite-ui").setup({ theme = "dracula" })
```

### LSP rename not working?
```lua
-- Verify LSP is attached
:LspInfo

-- Verify lite-ui config
:lua print(require("lite-ui.config").options.input.auto_detect_cword)
```

### Keys not working?
```lua
-- Check for conflicts
:nmap <CR>
:imap <Esc>
```

---

## 📋 Commands

| Command | Action |
|---------|--------|
| `:LiteUIDemo` | Show example input/select |
| `:LiteUITheme` | List all themes |
| `:LiteUITheme kanagawa` | Change theme |

---

## 🎯 Common Tasks

### Use light theme instead of dark:
```lua
require("lite-ui").setup({
  theme = "github-dark"  -- Has light variants in your editor settings
})
```

### Center dialog on screen:
```lua
require("lite-ui").setup({
  input = { relative = "editor" }
})
```

### Disable dialog transparency:
```lua
require("lite-ui").setup({
  input = {
    win_options = { winblend = 0 }  -- 0 = fully opaque
  }
})
```

### Show item numbers in select menu:
```lua
require("lite-ui").setup({
  select = {
    show_numbers = true,
    number_format = "[%d] %s"  -- Custom format
  }
})
```

### Create custom theme:
```lua
require("lite-ui").setup({
  theme = {
    border = { fg = "#FF00FF", bg = "#000000" },
    background = { bg = "#000000" },
    title = { fg = "#00FF00", bold = true },
    selected = { fg = "#FFFFFF", bg = "#0000FF", bold = true },
  }
})
```

---

## 📁 File Locations

```
~/.config/nvim/
├── lua/
│   ├── plugins/
│   │   └── lite-ui.lua       ← Your plugin config
│   └── config/
│       └── lsp.lua            ← Your LSP config
└── init.lua                   ← Your main config

~/.local/share/nvim/
└── lazy/lite-ui/              ← Plugin installation
    ├── config.lua
    ├── init.lua
    ├── input.lua
    ├── select.lua
    ├── themes.lua
    └── lite-ui.lua
```

---

## 🔗 Related Links

- **GitHub**: https://github.com/shreyanshvyas414/lite-ui
- **LSPConfig**: https://github.com/neovim/nvim-lspconfig
- **Neovim Docs**: https://neovim.io/doc/user/

---

## 💡 Pro Tips

1. **LSP Rename**: Always use `relative = "cursor"` for rename dialogs
2. **Themes**: Change themes with `:LiteUITheme dracula`
3. **Performance**: Set `winblend = 0` for faster rendering
4. **Selection**: Enable `show_numbers = true` for quick selection
5. **Organization**: Keep LSP config in separate file (`config/lsp.lua`)

---

## ❓ Quick FAQ

**Q: Does lite-ui work with Telescope?**
A: Yes! lite-ui automatically works with Telescope and any plugin using `vim.ui.*`

**Q: Can I use custom colors?**
A: Yes, just pass a table with `fg`, `bg`, `bold` options instead of theme name

**Q: Is LSP required?**
A: No, lite-ui works standalone for any `vim.ui.input` or `vim.ui.select` calls

**Q: Can I restore default UI?**
A: Yes: `require("lite-ui").restore()`

**Q: Does it work with Packer?**
A: Yes, see README for Packer installation instructions

---

## 🎓 Learning Resources

- **Starting with Neovim**: https://learnvimscript.com/
- **LSP in Neovim**: https://neovim.io/doc/user/lsp.html
- **lua guide**: https://neovim.io/doc/user/lua.html

---

**Need help?** Check GitHub issues or see full README.md for detailed docs!
