#  Changelog

## Version 1.1.0 - Major Fixes

### Bug Fixes

**Floating Window Not Showing in lazy.nvim**
- Issue: Plugin worked when called directly but not in lazy.nvim config
- Root Cause: lazy = true (default) delayed plugin loading
- Fix: Set lazy = false and priority = 1000

```lua
{
  "shreyanshvyas414/lite-ui",
  lazy = false,
  priority = 1000,
  config = function()
    require("lite-ui").setup({ theme = "kanagawa" })
  end
}
```

**Dialog Showing in Status Line Instead of Floating Window**
- Issue: Border characters displayed incorrectly
- Root Cause: Border characters using HTML entities instead of UTF-8
- Fix: Updated config.lua with proper UTF-8 box-drawing characters

**Border Characters Not Rendering**
- Issue: Dialog borders appeared as garbled text
- Root Cause: File encoding issue
- Fix: Re-encoded all border character arrays to proper UTF-8

```lua
rounded = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }
single = { "┌", "─", "┐", "│", "┘", "─", "└", "│" }
double = { "╔", "═", "╗", "║", "╝", "═", "╚", "║" }
solid = { "▛", "▀", "▜", "▐", "▟", "▄", "▙", "▌" }
```

### API Updates

**Modern LSP Configuration**
- Updated documentation to use modern vim.lsp.config API

Old (Deprecated):
```lua
local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()
lspconfig.lua_ls.setup({ capabilities = capabilities })
```

New (Recommended):
```lua
local lspconfig = require("lspconfig")
lspconfig.lua_ls.setup({})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(event)
    vim.keymap.set("n", "cr", vim.lsp.buf.rename, { buffer = event.buf })
  end
})
```

**Updated Input Module**
- Added proper relative positioning support
- Respects input.relative config option ("cursor" or "editor")
- Improved window placement logic

**Updated Select Module**
- Improved calculate_window_config to respect relative positioning
- Better height calculation for scrollable lists
- Proper cursor positioning after window opens

### Documentation Updates

- Added explicit lazy.nvim setup with lazy = false and priority = 1000
- Added troubleshooting section for floating window issues
- Updated LSP setup to use modern vim.lsp.config API
- Added complete setup examples for different package managers
- Improved Getting Started guide with step-by-step instructions
- Separated basic and advanced configurations
- Added configuration comments explaining each option

### Configuration Changes

Default Config Improvements:
- relative positioning now properly respects "cursor" vs "editor" setting
- border characters now use proper UTF-8 encoding
- window placement improved centering and positioning logic

New Configuration Options:
- input.relative: "cursor" or "editor" (default: "cursor")
- input.auto_detect_cword: Auto-prefill with symbol under cursor (default: true)
- select.relative: "cursor" or "editor" (default: "editor")

### Migration from v1.0.0

Update your lazy.nvim plugin spec:
```lua
{
  "shreyanshvyas414/lite-ui",
  lazy = false,    -- Add this
  priority = 1000, -- Add this
  config = function()
    require("lite-ui").setup({ theme = "kanagawa" })
  end
}
```

Clear Neovim cache:
```bash
rm -rf ~/.cache/nvim
rm -rf ~/.local/share/nvim
rm -rf ~/.local/state/nvim
```

Update LSP configuration if using - replace vim.lsp.buf.rename setup with modern LspAttach approach

No changes needed for:
- Theme configuration
- Input/select options
- Keymap setup
- Custom themes

### Testing After Update

Basic floating window:
```lua
:lua vim.ui.input({prompt = "Test: "}, function(input) print(input) end)
```
Should show a floating window with rounded border

LSP rename (with LSP configured):
```lua
function hello() end
-- Place cursor on 'hello'
cr  -- Should show rename dialog with [hello] prefilled
```

Select dialog - test with Telescope or plugin that uses vim.ui.select
Should show centered select menu with proper borders

### Files Changed

- config.lua - Fixed border character encoding
- input.lua - Improved relative positioning
- select.lua - Improved relative positioning
- init.lua - Better module loading
- README.md - Updated documentation and examples
- themes.lua - No changes
- lite-ui.lua - No changes

### Summary

Main issues fixed:
1. lazy.nvim needed lazy = false and priority = 1000
2. Border rendering UTF-8 encoding was corrupted
3. Both input and select now respect relative positioning
4. Documentation updated to modern API patterns

All fixes are backward compatible with existing configurations.

## Version 1.0.0 - Initial Release

Initial plugin release with:
- Beautiful input and select UI components
- 11 pre-built themes
- LSP rename support with auto-detection
- Zero dependencies
- Minimal overhead
