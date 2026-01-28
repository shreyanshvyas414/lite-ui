# 🎨 lite-ui.nvim Theme Gallery

A showcase of all available themes and how to use them.

## 🚀 Quick Start

```lua
require("lite-ui").setup({
  theme = "kanagawa" -- Choose any theme from below!
})
```

## 🎭 Theme Previews

### 🌊 Kanagawa

**Inspired by**: The Great Wave off Kanagawa painting  
**Aesthetic**: Deep blues, warm accents, traditional Japanese colors

```lua
require("lite-ui").setup({ theme = "kanagawa" })
```

**Colors**:
- Border: `#54546D` (Muted purple-grey)
- Background: `#1F1F28` (Deep navy)
- Title: `#7E9CD8` (Soft blue)
- Selected: `#2D4F67` (Deep teal)
- Numbers: `#7AA89F` (Jade green)

**Best for**: Users who enjoy calming, nature-inspired themes

---

### 🐙 GitHub Dark

**Inspired by**: GitHub's official dark interface  
**Aesthetic**: Clean, professional, high contrast

```lua
require("lite-ui").setup({ theme = "github-dark" })
```

**Colors**:
- Border: `#30363D` (Charcoal grey)
- Background: `#0D1117` (True black)
- Title: `#58A6FF` (Bright blue)
- Selected: `#1F6FEB` (GitHub blue)
- Numbers: `#56D364` (Success green)

**Best for**: Developers who love GitHub's aesthetic

---

### 🌸 Catppuccin (Mocha)

**Inspired by**: Catppuccin Mocha color palette  
**Aesthetic**: Soothing pastels, easy on the eyes

```lua
require("lite-ui").setup({ theme = "catppuccin" })
```

**Colors**:
- Border: `#585B70` (Muted grey)
- Background: `#1E1E2E` (Dark blue-grey)
- Title: `#89B4FA` (Lavender blue)
- Selected: `#45475A` (Charcoal)
- Numbers: `#A6E3A1` (Mint green)

**Best for**: Long coding sessions, reducing eye strain

---

### 🌃 Tokyo Night

**Inspired by**: Tokyo's neon-lit night skyline  
**Aesthetic**: Vibrant blues and purples, electric energy

```lua
require("lite-ui").setup({ theme = "tokyonight" })
```

**Colors**:
- Border: `#565F89` (Slate blue)
- Background: `#1A1B26` (Dark navy)
- Title: `#7AA2F7` (Sky blue)
- Selected: `#283457` (Deep blue)
- Numbers: `#9ECE6A` (Lime green)

**Best for**: Night owls and cyberpunk enthusiasts

---

### 🍂 Gruvbox

**Inspired by**: Retro groove aesthetic  
**Aesthetic**: Warm colors, high contrast, vintage feel

```lua
require("lite-ui").setup({ theme = "gruvbox" })
```

**Colors**:
- Border: `#665C54` (Brown-grey)
- Background: `#282828` (Dark brown)
- Title: `#83A598` (Aqua blue)
- Selected: `#504945` (Warm grey)
- Numbers: `#B8BB26` (Yellow-green)

**Best for**: Vintage aesthetics, warm color lovers

---

### ❄️ Nord

**Inspired by**: Arctic, north-bluish color palette  
**Aesthetic**: Cool, professional, minimalist

```lua
require("lite-ui").setup({ theme = "nord" })
```

**Colors**:
- Border: `#4C566A` (Polar grey)
- Background: `#2E3440` (Polar night)
- Title: `#88C0D0` (Frost cyan)
- Selected: `#434C5E` (Slate)
- Numbers: `#A3BE8C` (Aurora green)

**Best for**: Minimalists and cool-color enthusiasts

---

### 🧛 Dracula

**Inspired by**: The famous Dracula theme  
**Aesthetic**: Dark with vibrant, punchy accents

```lua
require("lite-ui").setup({ theme = "dracula" })
```

**Colors**:
- Border: `#6272A4` (Purple-grey)
- Background: `#282A36` (Deep purple-black)
- Title: `#BD93F9` (Bright purple)
- Selected: `#44475A` (Dark grey)
- Numbers: `#50FA7B` (Neon green)

**Best for**: Dark theme lovers who want vibrant accents

---

### 🌙 Onedark

**Inspired by**: Atom's One Dark theme  
**Aesthetic**: Balanced, professional, widely loved

```lua
require("lite-ui").setup({ theme = "onedark" })
```

**Colors**:
- Border: `#3E4452` (Charcoal)
- Background: `#282C34` (Dark grey)
- Title: `#61AFEF` (Blue)
- Selected: `#3E4452` (Charcoal)
- Numbers: `#98C379` (Green)

**Best for**: Users transitioning from Atom or VSCode

---

### 🌹 Rose Pine

**Inspired by**: Natural pine and faux fur  
**Aesthetic**: Warm, cozy, sophisticated

```lua
require("lite-ui").setup({ theme = "rose-pine" })
```

**Colors**:
- Border: `#403D52` (Muted purple)
- Background: `#191724` (Deep wine)
- Title: `#9CCFD8` (Teal)
- Selected: `#26233A` (Dark plum)
- Numbers: `#31748F` (Ocean blue)

**Best for**: Elegant, sophisticated aesthetic lovers

---

### 🦊 Nightfox

**Inspired by**: Foxes in the night  
**Aesthetic**: Highly accessible, vibrant but balanced

```lua
require("lite-ui").setup({ theme = "nightfox" })
```

**Colors**:
- Border: `#526176` (Blue-grey)
- Background: `#192330` (Dark blue)
- Title: `#719CD6` (Sky blue)
- Selected: `#2B3B51` (Slate blue)
- Numbers: `#81B29A` (Sage green)

**Best for**: Those prioritizing accessibility and readability

---

### 🎯 Default

**Inspired by**: Neovim's built-in colors  
**Aesthetic**: Follows your colorscheme

```lua
require("lite-ui").setup({ theme = "default" })
```

**Best for**: Users who want UI to match their current colorscheme

---

## 🎨 Creating Custom Themes

### Method 1: Inline Theme Definition

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

### Method 2: Register and Use

```lua
local lite_ui = require("lite-ui")

-- Register your theme
lite_ui.themes.add_theme("my_awesome_theme", {
  border = { fg = "#FF6B6B", bg = "#1A1A2E" },
  background = { bg = "#1A1A2E" },
  title = { fg = "#4ECDC4", bold = true },
  selected = { fg = "#FFFFFF", bg = "#0F3460", bold = true },
  prompt = { fg = "#FFE66D", bold = true },
  input_text = { fg = "#E8E8E8", bg = "#1A1A2E" },
  select_text = { fg = "#E8E8E8", bg = "#1A1A2E" },
  number = { fg = "#95E1D3", bg = "#1A1A2E" },
})

-- Use it
lite_ui.setup({ theme = "my_awesome_theme" })
```

### Method 3: Link to Existing Highlight Groups

```lua
require("lite-ui").setup({
  theme = {
    border = "Comment",           -- Use Neovim's Comment highlight
    background = "Normal",         -- Use Normal background
    title = "Title",               -- Use Title highlight
    selected = "Visual",           -- Use Visual selection
    prompt = "Question",
    input_text = "Normal",
    select_text = "Normal",
    number = "LineNr",
  }
})
```

## 🔄 Switching Themes Dynamically

```vim
" List all themes
:LiteUITheme

" Switch to a theme
:LiteUITheme kanagawa
:LiteUITheme tokyonight
:LiteUITheme catppuccin
```

Or in Lua:

```lua
-- Switch theme programmatically
require("lite-ui.themes").apply_theme("dracula")

-- List available themes
local themes = require("lite-ui.themes").list_themes()
print(vim.inspect(themes))
```

## 🧪 Testing Themes

Run the demo command to see how your theme looks:

```vim
:LiteUIDemo
```

This will show both an input prompt and a select menu with your current theme.

## 📊 Theme Comparison

| Theme | Vibe | Contrast | Best For |
|-------|------|----------|----------|
| Kanagawa | Calm, Traditional | Medium | Long sessions |
| GitHub Dark | Clean, Professional | High | GitHub users |
| Catppuccin | Soft, Pastel | Low | Eye comfort |
| Tokyo Night | Vibrant, Modern | High | Night coding |
| Gruvbox | Warm, Retro | High | Vintage lovers |
| Nord | Cool, Minimal | Medium | Minimalists |
| Dracula | Dark, Vibrant | High | Dark lovers |
| Onedark | Balanced | Medium | VSCode users |
| Rose Pine | Cozy, Elegant | Medium | Sophistication |
| Nightfox | Accessible | Medium | Accessibility |

## 💡 Tips

1. **Match Your Colorscheme**: Choose a theme that complements your main colorscheme
2. **Consider Contrast**: Higher contrast = easier to read but more eye strain
3. **Test in Different Lighting**: Try your theme in both day and night
4. **Customize**: Don't be afraid to tweak colors to your preference
5. **Transparency**: Combine themes with `winblend` for translucent effects

```lua
require("lite-ui").setup({
  theme = "kanagawa",
  input = { win_options = { winblend = 20 } },
  select = { win_options = { winblend = 20 } },
})
```

## 🤝 Contributing Themes

Have a beautiful theme? Consider contributing it to lite-ui!

1. Add your theme to `lua/lite-ui/themes.lua`
2. Document it in this file
3. Submit a PR with screenshots

## 📝 Color Specification Format

```lua
{
  -- Using hex colors
  border = { fg = "#RRGGBB", bg = "#RRGGBB" },
  
  -- With text styling
  title = { fg = "#RRGGBB", bg = "#RRGGBB", bold = true, italic = true },
  
  -- Using highlight group names
  background = "NormalFloat",
  
  -- All available properties
  property = {
    fg = "#RRGGBB",      -- Foreground color
    bg = "#RRGGBB",      -- Background color
    bold = true,         -- Bold text
    italic = true,       -- Italic text
    underline = true,    -- Underlined text
    undercurl = true,    -- Curly underline
    strikethrough = true,-- Strikethrough text
  }
}
```

---

Made with 💙
