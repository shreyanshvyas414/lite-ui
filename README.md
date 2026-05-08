# lite-ui.nvim

Minimal, fast, dependency-free UI for modern Neovim.

[`dressing.nvim`](https://github.com/stevearc/dressing.nvim) has been archived. lite-ui.nvim replaces it — making `vim.ui.input` and `vim.ui.select` look great with zero dependencies and 11+ built-in themes.

---

## Installation

### lazy.nvim

```lua
{
  "shrey99sh/lite-ui",
  config = function()
    require("lite-ui").setup({
      theme = "kanagawa",
      input = { auto_detect_cword = true },
    })
  end
}
```

### packer.nvim

```lua
use {
  "shrey99sh/lite-ui",
  config = function()
    require("lite-ui").setup({
      theme = "kanagawa",
      input = { auto_detect_cword = true },
    })
  end
}
```

---

## Configuration

```lua
require("lite-ui").setup({
  theme = "kanagawa", -- see themes below

  input = {
    relative = "cursor",      -- "cursor" or "editor"
    border = "rounded",
    auto_detect_cword = true, -- prefills symbol name for LSP rename
  },

  select = {
    relative = "editor",
    border = "rounded",
    show_numbers = true,
  },
})
```

**Available themes:** `default`, `kanagawa`, `github-dark`, `catppuccin`, `tokyonight`, `gruvbox`, `nord`, `dracula`, `onedark`, `rose-pine`, `nightfox`

Switch themes on the fly:
```vim
:LiteUITheme tokyonight
```

---

## Keymaps

| Window | Key | Action |
|:------:|:---:|:------:|
| Input | `<CR>` / `<Esc>` | Confirm / Cancel |
| Select | `<CR>` / `<Esc>` | Confirm / Cancel |
| Select | `j` / `k` | Navigate |
| Select | `1-9` | Quick select |

---

## Troubleshooting

LSP rename not prefilling the symbol name — make sure `auto_detect_cword = true` and your cursor is on the symbol.

Dialog covering your code — switch to `relative = "cursor"`.

---

## Contributing

Clone the repo, make your changes, and open a pull request. Bug fixes, features, docs — all welcome!

```bash
git clone https://github.com/shrey99sh/lite-ui.git
```

---

## License

MIT — Inspired by [dressing.nvim](https://github.com/stevearc/dressing.nvim)
