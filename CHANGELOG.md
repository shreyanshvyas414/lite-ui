# Changelog - lite-ui.nvim Fixes

## Version 1.1.0 - Major Fixes (Current)

### 🐛 Bug Fixes

#### 1. **Floating Window Not Showing in lazy.nvim**
- **Issue**: Plugin worked when called directly but not in lazy.nvim config
- **Root Cause**: `lazy = true` (default) delayed plugin loading before other modules were ready
- **Fix**: 
  - Set `lazy = false` to load immediately
  - Set `priority = 1000` to load before other UI plugins
  - Example:
    ```lua
    {
      "shreyanshvyas414/lite-ui",
      lazy = false,    -- ✨ CRITICAL
      priority = 1000, -- ✨ CRITICAL
      config = function()
        require("lite-ui").setup({ theme = "kanagawa" })
      end
    }
    ```

#### 2. **Dialog Showing in Status Line Instead of Floating Window**
- **Issue**: Border characters displayed incorrectly, causing dialog to appear as text in status line
- **Root Cause**: Border characters were using HTML entities (e.g., `â•­`) instead of proper UTF-8
- **Fix**: 
  - Updated `config.lua` border_chars with proper UTF-8 box-drawing characters
  - Before: `"â•­", "â"€"` (corrupted)
  - After: `"╭", "─"` (proper UTF-8)

#### 3. **Border Characters Not Rendering**
- **Issue**: Dialog borders appeared as garbled text
- **Root Cause**: File encoding issue - borders were stored as HTML entities instead of UTF-8
- **Fix**: 
  - Re-encoded all border character arrays to proper UTF-8
  - Verified character encoding:
    ```lua
    rounded = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }
    single = { "┌", "─", "┐", "│", "┘", "─", "└", "│" }
    double = { "╔", "═", "╗", "║", "╝", "═", "╚", "║" }
    solid = { "▛", "▀", "▜", "▐", "▟", "▄", "▙", "▌" }
    ```

### 📋 API Updates

#### 1. **Modern LSP Configuration**
- **Issue**: Documentation used deprecated `lspconfig` setup
- **Fix**: Updated to use modern `vim.lsp.config` API
- **Old (Deprecated)**:
  ```lua
  local lspconfig = require("lspconfig")
  local capabilities = require("cmp_nvim_lsp").default_capabilities()
  lspconfig.lua_ls.setup({ capabilities = capabilities })
  ```
- **New (Recommended)**:
  ```lua
  local lspconfig = require("lspconfig")
  lspconfig.lua_ls.setup({})
  
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(event)
      vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { buffer = event.buf })
    end
  })
  ```

#### 2. **Updated Input Module**
- Added proper relative positioning support in `input.lua`
- Respects `input.relative` config option ("cursor" or "editor")
- Improved window placement logic:
  ```lua
  if relative_pos == "cursor" then
    win_config.row = -2  -- Above cursor
    win_config.col = 0   -- Left-aligned
  else
    -- Editor-relative (centered)
    local row = math.floor((height - win_height) / 2) - 1
    local col = math.floor((width - win_width) / 2)
  end
  ```

#### 3. **Updated Select Module**
- Improved `calculate_window_config` to respect relative positioning
- Better height calculation for scrollable lists
- Proper cursor positioning after window opens

### 📚 Documentation Updates

#### 1. **README.md Improvements**
- Added explicit lazy.nvim setup with `lazy = false` and `priority = 1000`
- Added troubleshooting section for floating window issues
- Updated LSP setup to use modern vim.lsp.config API
- Added complete setup examples for different package managers
- Improved Getting Started guide with step-by-step instructions

#### 2. **Clearer Configuration Examples**
- Separated basic and advanced configurations
- Added configuration comments explaining what each option does
- Provided examples for common issues and solutions

### 🔧 Configuration Changes

#### Default Config Improvements
- **relative positioning**: Now properly respects "cursor" vs "editor" setting
- **border characters**: Now use proper UTF-8 encoding
- **window placement**: Improved centering and positioning logic

#### New Configuration Options Documented
- `input.relative`: "cursor" or "editor" (default: "cursor")
- `input.auto_detect_cword`: Auto-prefill with symbol under cursor (default: true)
- `select.relative`: "cursor" or "editor" (default: "editor")

### ⚠️ Migration Notes

If you're upgrading from v1.0.0:

1. **Update your lazy.nvim plugin spec**:
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

2. **Clear Neovim cache**:
   ```bash
   rm -rf ~/.cache/nvim
   rm -rf ~/.local/share/nvim
   rm -rf ~/.local/state/nvim
   ```

3. **Update LSP configuration** (if using):
   Replace `vim.lsp.buf.rename` setup with modern LspAttach approach

4. **No changes needed** for:
   - Theme configuration
   - Input/select options
   - Keymap setup
   - Custom themes

### 🧪 Testing Recommendations

After updating, test these scenarios:

1. **Basic floating window**:
   ```lua
   :lua vim.ui.input({prompt = "Test: "}, function(input) print(input) end)
   ```
   ✓ Should show a floating window with a rounded border

2. **LSP rename** (with LSP configured):
   ```lua
   function hello() end
   -- Place cursor on 'hello'
   <leader>cr  -- Should show rename dialog with [hello] prefilled
   ```

3. **Select dialog** (test with Telescope or plugin that uses vim.ui.select)
   ✓ Should show centered select menu with proper borders

### 📦 Files Changed

- ✅ `config.lua` - Fixed border character encoding
- ✅ `input.lua` - Improved relative positioning
- ✅ `select.lua` - Improved relative positioning
- ✅ `init.lua` - Better module loading
- ✅ `README.md` - Updated documentation and examples
- ✅ `themes.lua` - No changes (works as-is)
- ✅ `lite-ui.lua` - No changes (works as-is)

### 🎯 Key Takeaways

The main issues were:
1. **lazy.nvim**: Needed `lazy = false` and `priority = 1000`
2. **Border rendering**: UTF-8 encoding was corrupted, now fixed
3. **Positioning**: Both input and select now respect relative positioning
4. **LSP API**: Documented updated to modern API patterns

All fixes are backward compatible with existing configurations!

---

## Version 1.0.0 - Initial Release

Initial plugin release with:
- Beautiful input and select UI components
- 11 pre-built themes
- LSP rename support with auto-detection
- Zero dependencies
- Minimal overhead
