
<h1 align="center">lite-ui.nvim</h1>

<p align="center">
  <b>Minimal, fast, dependency-free UI for modern Neovim</b>
</p>

<p align="center">
  <img src="https://img.shields.io/github/stars/shreyanshvyas414/lite-ui?style=flat-square" />
  <img src="https://img.shields.io/github/issues/shreyanshvyas414/lite-ui?style=flat-square" />
  <img src="https://img.shields.io/github/license/shreyanshvyas414/lite-ui?style=flat-square" />
  <img src="https://img.shields.io/badge/neovim-0.11+-57A143?style=flat-square&logo=neovim" />
</p>

---

## ✨ What is lite-ui.nvim?

**lite-ui.nvim** is a **lightweight alternative to `dressing.nvim`** that enhances  
`vim.ui.input` and `vim.ui.select` with **beautiful floating windows**, **built-in themes**, and **zero dependencies**.

It’s designed for users who want:
- modern UI
- predictable behavior
- minimal overhead
- no plugin bloat

Drop-in replacement. No magic. Just clean UI.

---

## 🎯 Why lite-ui.nvim?

`dressing.nvim` has been archived, and while alternatives like `snacks.nvim` exist,
they often bundle **much more than just UI**.

lite-ui.nvim focuses on **one thing only**:

✨ making `vim.ui.*` beautiful, fast, and hackable

---
## ✨ Features

- 🚀 **Fast & Lightweight**: Zero dependencies, pure Lua implementation
- 🎨 **Beautiful Themes**: 11+ pre-built themes (Kanagawa, GitHub Dark, Catppuccin, Tokyo Night, and more!)
- 🎯 **Custom Themes**: Easy custom theme creation
- ⌨️  **Intuitive Keymaps**: Vim-like navigation with number quick-selection
- 🔧 **Drop-in Replacement**: Works with any plugin that uses `vim.ui.*`
- 🎯 **Smart Positioning**: Cursor-relative or editor-centered windows
- 📦 **No Configuration Required**: Sensible defaults out of the box
- ✨ **LSP Rename Support**: Automatic function/variable name prefilling in rename dialogs
- 🛡️  **Robust**: Thoroughly tested with all major LSP servers (Lua, Python, JS/TS, Go, etc.)

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

### lazy.nvim (Recommended)

```lua
{
  "shreyanshvyas414/lite-ui",
  config = function()
    require("lite-ui").setup({
      theme = "kanagawa", -- or any other theme!
      
      input = {
        -- CRITICAL: Enable auto-detection for LSP rename to work correctly
        -- This makes the rename dialog prefill with function/variable names
        auto_detect_cword = true,
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

Then in your init.lua:
```lua
require("lite-ui").setup({
  theme = "tokyonight",
  input = { auto_detect_cword = true } -- Important for LSP rename!
})
```

### Manual Installation

1. Clone the repository:
```bash
git clone https://github.com/shreyanshvyas414/lite-ui.git 
  ~/.config/nvim/pack/plugins/start/lite-ui
```

2. Add to your init.lua:
```lua
require("lite-ui").setup({
  theme = "kanagawa",
  input = { auto_detect_cword = true }
})
```

## 🚀 Getting Started (5 Minutes)

### Step 1: Basic Setup

Add to your `init.lua`:

```lua
require("lite-ui").setup({
  theme = "kanagawa", -- Choose from: kanagawa, github-dark, catppuccin, tokyonight, etc.
})
```

### Step 2: Set a Theme (Optional)

Choose your favorite theme:

```lua
require("lite-ui").setup({
  theme = "github-dark", -- Change to your preference
})
```

Available themes: `default`, `kanagawa`, `github-dark`, `catppuccin`, `tokyonight`, `gruvbox`, `nord`, `dracula`, `onedark`, `rose-pine`, `nightfox`

### Step 3: LSP Rename Setup (Recommended)

For beautiful LSP rename dialogs with prefilled names:

```lua
-- lite-ui setup
require("lite-ui").setup({
  theme = "kanagawa",
  input = { auto_detect_cword = true }, -- Critical for LSP rename!
})

-- LSP configuration (add your language servers)
local lspconfig = require("lspconfig")
lspconfig.lua_ls.setup({})
lspconfig.pyright.setup({})

-- LSP keymaps
vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename)
vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "K", vim.lsp.buf.hover)
```

### Step 4: Test It!

1. Create a test file with a function:
   ```lua
   function hello()
     print("Hello World")
   end
   hello()
   ```

2. Place cursor on `hello` function name

3. Press `<leader>cr` to test rename

4. Dialog should show `[hello]` prefilled ✓

### Step 5: Explore Features

Try these commands:
```vim
:LiteUITheme          " List all themes
:LiteUITheme dracula  " Switch theme
:LiteUIDemo           " Demo input and select
```

**Done!** Your lite-ui.nvim is ready to use! 🎉

## 🎯 Usage

Just call `setup()` in your config - lite-ui will automatically enhance `vim.ui.input` and `vim.ui.select` for all plugins that use them (Telescope, LSP rename, etc.).

### Basic Setup (with theme)

```lua
require("lite-ui").setup({
  theme = "kanagawa", -- Choose your theme!
  input = {
    auto_detect_cword = true, -- Important: enables LSP rename to work correctly
  }
})
```

### LSP Rename Setup (Important!)

For LSP rename to work properly with prefilled function names:

```lua
require("lite-ui").setup({
  theme = "kanagawa",
  input = {
    enabled = true,
    auto_detect_cword = true,    -- ✨ CRITICAL: Auto-detect symbol under cursor
    relative = "cursor",          -- Position dialog relative to cursor
    border = "rounded",
    start_in_insert = true,
  },
})

-- Also ensure LSP is configured:
local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

lspconfig.lua_ls.setup({
  capabilities = capabilities,
  settings = {
    Lua = { diagnostics = { globals = { "vim" } } }
  },
})
```

Then in your LSP keymaps:
```lua
vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { noremap = true, silent = true })
```

**Testing LSP rename:**
1. Open a Lua file with a function: `function hello() end`
2. Place cursor on `hello`
3. Press `<leader>cr`
4. Dialog should show `[hello]` prefilled (not empty `%`)
5. Type new name and press Enter

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
    auto_detect_cword = true,  -- Auto-prefill with symbol under cursor for rename
    start_in_insert = true,    -- Start in insert mode
    win_options = {
      winblend = 10,           -- Transparency (0-100)
    },
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

## 🆘 Troubleshooting

### LSP Rename Dialog Shows Empty `%`

**Problem:** Dialog appears empty instead of showing the function/variable name.

**Solution:**
1. Ensure `auto_detect_cword = true` in your setup:
   ```lua
   require("lite-ui").setup({
     input = { auto_detect_cword = true }
   })
   ```

2. Verify LSP is attached:
   ```vim
   :LspInfo
   ```

3. Make sure cursor is directly on the symbol name (not on whitespace or parentheses)

### LSP Rename Error: "Couldn't Provide Rename Result"

**Problem:** Rename fails with LSP error message.

**Solution:**
1. **Check LSP is attached:**
   ```vim
   :LspInfo
   ```
   Should show your language server (lua_ls, pyright, tsserver, etc.)

2. **Clear cache and restart:**
   ```bash
   rm -rf ~/.local/state/nvim
   rm -rf ~/.cache/nvim
   nvim
   ```

3. **Verify window positioning:**
   - Dialog should appear ABOVE cursor, not centered on screen
   - Original symbol line should still be visible
   - Check that `relative = "cursor"` is set in input config

4. **Ensure proper buffer setup:**
   - Verify the plugin files are up to date
   - Check that `input.lua` and `config.lua` are correctly installed

### Dialog Covers the Symbol Being Renamed

**Problem:** Dialog opens centered on screen, covering the function name.

**Solution:**
1. Change window positioning:
   ```lua
   require("lite-ui").setup({
     input = {
       relative = "cursor", -- Should be "cursor", not "editor"
     }
   })
   ```

2. Verify this setting is applied:
   ```vim
   :set winhighlight?
   ```

### LSP Rename Works But Text Isn't Prefilled

**Problem:** Dialog appears but shows empty input field.

**Solution:**
1. Enable auto-detection:
   ```lua
   require("lite-ui").setup({
     input = { auto_detect_cword = true }
   })
   ```

2. Verify you're on a symbol name in the function definition (not the function call)

3. Check the LSP prompt being sent:
   - The prompt should contain "rename" or "new name"
   - Try renaming different types: functions, variables, etc.

### Keymaps Not Working in Input Dialog

**Problem:** Keys like `<CR>` or `<Esc>` don't work in rename dialog.

**Solution:**
1. Check for keymap conflicts:
   ```lua
   -- Make sure no other plugin is mapping these keys
   :nmap <CR>
   :imap <CR>
   ```

2. Verify input is enabled:
   ```lua
   require("lite-ui").setup({
     input = { enabled = true }
   })
   ```

3. Try using basic keymaps without leader prefix:
   ```lua
   vim.keymap.set("n", "<C-r>", vim.lsp.buf.rename)
   ```

### Performance Issues or Slow Dialog Opening

**Problem:** Dialog takes time to appear or system feels sluggish.

**Solution:**
1. Disable transparency:
   ```lua
   require("lite-ui").setup({
     input = {
       win_options = { winblend = 0 } -- 0 = no transparency
     }
   })
   ```

2. Simplify theme colors (use built-in themes instead of complex custom themes)

3. Check for other UI plugins causing conflicts:
   ```lua
   -- Ensure no duplicate UI frameworks
   -- Example: don't use both dressing.nvim and lite-ui.nvim
   ```

### Dialog Text Color Hard to Read

**Problem:** Text appears invisible or too dark/light.

**Solution:**
1. Try a different theme:
   ```lua
   require("lite-ui").setup({ theme = "kanagawa" })
   -- Try: github-dark, tokyonight, catppuccin, dracula, etc.
   ```

2. Create a custom theme with better contrast:
   ```lua
   require("lite-ui").setup({
     theme = {
       input_text = { fg = "#FFFFFF", bg = "#000000" },
       border = { fg = "#00FF00" },
     }
   })
   ```

3. Check your terminal theme has proper contrast ratios

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
- **Telescope** - Search and picker dialogs
- **LSP** - Symbol rename, code actions, hover documentation (with prefilled names!)
- **nvim-cmp** - Completion menu interactions
- **Any plugin** using `vim.ui.input` or `vim.ui.select`

### LSP Rename Integration

lite-ui.nvim provides beautiful LSP rename dialogs with **automatic function/variable name prefilling**!

#### Setup for Different Languages

**Lua (lua_ls):**
```lua
local lspconfig = require("lspconfig")
lspconfig.lua_ls.setup({
  capabilities = require("cmp_nvim_lsp").default_capabilities(),
  settings = {
    Lua = { diagnostics = { globals = { "vim" } } }
  },
})
```

**Python (pylsp or pyright):**
```lua
lspconfig.pylsp.setup({ capabilities = capabilities })
-- or
lspconfig.pyright.setup({ capabilities = capabilities })
```

**JavaScript/TypeScript (tsserver):**
```lua
lspconfig.tsserver.setup({ capabilities = capabilities })
```

**Go (gopls):**
```lua
lspconfig.gopls.setup({ capabilities = capabilities })
```

#### Complete LSP + lite-ui.nvim Setup

```lua
-- Install plugins
local function setup_lsp()
  local lspconfig = require("lspconfig")
  local capabilities = require("cmp_nvim_lsp").default_capabilities()

  -- Setup lite-ui for beautiful UI
  require("lite-ui").setup({
    theme = "kanagawa",
    input = {
      auto_detect_cword = true, -- ✨ Critical for rename!
      relative = "cursor",
    },
  })

  -- Setup LSP servers
  lspconfig.lua_ls.setup({ capabilities = capabilities })
  lspconfig.pyright.setup({ capabilities = capabilities })
  lspconfig.tsserver.setup({ capabilities = capabilities })

  -- Setup keymaps
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ev)
      local bufopts = { buffer = ev.buf, noremap = true, silent = true }
      vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, bufopts)
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
      vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
      vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
    end,
  })
end

setup_lsp()
```

#### Testing LSP Rename

Create a test file (test.lua):
```lua
function greet(name)
  print("Hello " .. name)
end

local result = greet("World")
```

1. Place cursor on `greet` in the function definition
2. Press `<leader>cr` (or your configured rename key)
3. Dialog appears with `[greet]` prefilled
4. Type new name: `sayHello`
5. Press Enter
6. All occurrences renamed! ✓

Result:
```lua
function sayHello(name)
  print("Hello " .. name)
end

local result = sayHello("World")
```

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
