# lite-ui.nvim - Theming Update Summary

## 🎨 New Theming System

### What's New?

lite-ui.nvim now includes a comprehensive theming system with **11 pre-built themes** and support for custom themes!

## 📦 New Files

1. **lua/lite-ui/themes.lua** - Complete theming engine with pre-built themes
2. **THEMES.md** - Comprehensive theme gallery and documentation

## 🎭 Available Themes

### Pre-built Themes (11 total):

1. **default** - Uses Neovim's default colors
2. **kanagawa** - Deep blues and warm accents (Japanese wave inspired)
3. **github-dark** - Clean GitHub dark interface
4. **catppuccin** - Soothing pastel colors (Mocha variant)
5. **tokyonight** - Vibrant night-time aesthetic
6. **gruvbox** - Retro warm colors with high contrast
7. **nord** - Arctic bluish-grey palette
8. **dracula** - Dark with vibrant, punchy colors
9. **onedark** - Inspired by Atom's One Dark
10. **rose-pine** - Natural pine and soho vibes
11. **nightfox** - Highly accessible with vibrant colors

## 🚀 Usage Examples

### Basic Theme Setup

```lua
require("lite-ui").setup({
  theme = "kanagawa"
})
```

### Custom Theme

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

### Dynamic Theme Switching

```vim
:LiteUITheme           " List all themes
:LiteUITheme kanagawa  " Switch to kanagawa
:LiteUIDemo            " Test current theme
```

## 🔧 Technical Implementation

### Theme Structure

Each theme defines colors for different UI elements:

```lua
{
  border = { fg = "#...", bg = "#..." },      -- Window border
  background = { bg = "#..." },                -- Window background
  title = { fg = "#...", bold = true },       -- Title/header
  selected = { fg = "#...", bg = "#..." },    -- Selected item (select only)
  prompt = { fg = "#..." },                   -- Prompt text (input only)
  input_text = { fg = "#..." },               -- Input field text
  select_text = { fg = "#..." },              -- Select menu text
  number = { fg = "#..." },                   -- Item numbers (select only)
}
```

### Highlight Groups

The theme system creates these highlight groups:

**Input:**
- `LiteUIInputBorder`
- `LiteUIInputBackground`
- `LiteUIInputTitle`
- `LiteUIInputPrompt`
- `LiteUIInputText`

**Select:**
- `LiteUISelectBorder`
- `LiteUISelectBackground`
- `LiteUISelectTitle`
- `LiteUISelectSelected`
- `LiteUISelectText`
- `LiteUISelectNumber`

### Color Specification

Colors can be specified in two ways:

1. **Highlight group link** (string):
   ```lua
   border = "FloatBorder"
   ```

2. **Direct color definition** (table):
   ```lua
   border = { 
     fg = "#FFFFFF", 
     bg = "#000000", 
     bold = true,
     italic = true 
   }
   ```

## 📝 API Reference

### Theme Functions

```lua
local themes = require("lite-ui.themes")

-- Apply a theme
themes.apply_theme("kanagawa")

-- Add custom theme
themes.add_theme("my_theme", {
  -- theme definition
})

-- List available themes
local theme_names = themes.list_themes()

-- Access themes table directly
local kanagawa_colors = themes.themes.kanagawa
```

### Commands

- `:LiteUITheme` - List all available themes
- `:LiteUITheme <name>` - Switch to specified theme
- `:LiteUIDemo` - Show demo of input and select with current theme

## 🔄 Modified Files

### 1. config.lua
- Added `theme` configuration option
- Added `theme_override` options for input and select
- Theme is applied during setup

### 2. init.lua
- Added theme management commands (`:LiteUITheme`, `:LiteUIDemo`)
- Exposed themes API: `require("lite-ui").themes`
- Better initialization with theme support

### 3. input.lua
- Applied themed highlight groups via `winhighlight`
- Uses `LiteUIInput*` highlight groups

### 4. select.lua
- Applied themed highlight groups via `winhighlight`
- Uses `LiteUISelect*` highlight groups
- Number colors from theme

### 5. README.md
- Added theme showcase section
- Theme usage examples
- Custom theme creation guide
- Dynamic theme switching documentation

## 🎯 Benefits

### For Users:
- ✨ Beautiful, cohesive UI out of the box
- 🎨 11 professionally designed themes
- 🔧 Easy customization
- 🔄 Dynamic theme switching
- 📚 Comprehensive documentation

### For Developers:
- 🏗️ Clean theme architecture
- 📦 Easy to add new themes
- 🎯 Type-safe color specifications
- 🔌 Extensible API

## 🧪 Testing

Test the theming system:

```lua
-- Test each theme
for _, theme_name in ipairs(require("lite-ui.themes").list_themes()) do
  vim.cmd("LiteUITheme " .. theme_name)
  vim.cmd("LiteUIDemo")
  vim.wait(2000)
end
```

## 📊 Theme Color Palettes

### Kanagawa
```
Border:     #54546D  Background: #1F1F28
Title:      #7E9CD8  Selected:   #2D4F67
Numbers:    #7AA89F
```

### GitHub Dark
```
Border:     #30363D  Background: #0D1117
Title:      #58A6FF  Selected:   #1F6FEB
Numbers:    #56D364
```

### Catppuccin
```
Border:     #585B70  Background: #1E1E2E
Title:      #89B4FA  Selected:   #45475A
Numbers:    #A6E3A1
```

### Tokyo Night
```
Border:     #565F89  Background: #1A1B26
Title:      #7AA2F7  Selected:   #283457
Numbers:    #9ECE6A
```

(See THEMES.md for complete color specifications of all themes)

## 🎓 Best Practices

### Theme Selection
1. **Match your colorscheme**: Choose a theme that complements your main colorscheme
2. **Consider contrast**: Higher contrast for readability, lower for comfort
3. **Test in different lighting**: Verify theme works in various environments
4. **Use transparency**: Combine with `winblend` for modern effects

### Custom Themes
1. **Use consistent color palette**: Stick to 5-8 main colors
2. **Ensure readability**: Maintain sufficient contrast
3. **Test both input and select**: Make sure both UIs look good
4. **Consider accessibility**: Use WCAG contrast guidelines

### Performance
- ✅ Themes are applied once during setup
- ✅ No performance overhead during usage
- ✅ Dynamic switching is instant
- ✅ No external dependencies

## 🚀 Future Enhancements

Potential additions (community feedback welcome):

1. **More themes**: Light themes, seasonal themes, brand themes
2. **Theme variants**: Multiple variants per theme (e.g., Catppuccin Latte/Frappe/Macchiato)
3. **Automatic theme detection**: Match current colorscheme automatically
4. **Theme generator**: Web tool to create custom themes
5. **Animation support**: Smooth theme transitions
6. **Per-buffer themes**: Different themes for different file types

## 📚 Documentation Files

- **README.md** - Main documentation with theme quick-start
- **THEMES.md** - Comprehensive theme gallery with previews
- **lua/lite-ui/themes.lua** - Source code with all theme definitions

## 🎉 Migration Guide

### From Basic Setup

Before:
```lua
require("lite-ui").setup()
```

After (with theme):
```lua
require("lite-ui").setup({
  theme = "kanagawa"
})
```

### From Custom Colors

Before:
```lua
-- Users had to manually set highlight groups
vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#..." })
```

After:
```lua
-- Built-in theme system
require("lite-ui").setup({
  theme = {
    border = { fg = "#..." },
    -- ... other colors
  }
})
```

## ✨ Example Configurations

### Kanagawa with Transparency
```lua
require("lite-ui").setup({
  theme = "kanagawa",
  input = {
    win_options = { winblend = 15 }
  },
  select = {
    win_options = { winblend = 15 }
  }
})
```

### GitHub Dark with Custom Border
```lua
require("lite-ui").setup({
  theme = "github-dark",
  input = { border = "double" },
  select = { border = "double" }
})
```

### Mixed Theme (Custom)
```lua
require("lite-ui").setup({
  theme = {
    border = { fg = "#7E9CD8" },      -- Kanagawa blue
    background = { bg = "#0D1117" },   -- GitHub dark
    title = { fg = "#BD93F9" },        -- Dracula purple
    selected = { fg = "#CDD6F4", bg = "#45475A" },  -- Catppuccin
    -- ...
  }
})
```

## 🐛 Known Issues

None currently! The theming system is stable and tested.

## 🤝 Contributing

Want to add a theme? 

1. Add it to `lua/lite-ui/themes.lua`
2. Document it in `THEMES.md`
3. Test with `:LiteUIDemo`
4. Submit a PR!

---

Made with 💙 by the lite-ui community
