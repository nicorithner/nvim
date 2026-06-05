# Minimal Neovim Config

A clean, minimal Neovim setup for web development (JS/TS/CSS/SCSS/HTML).
No AI code suggestions - standard LSP-driven completion only.

## Installation

1. Backup old config:
   ```bash
   mv ~/.config/nvim ~/.config/nvim.backup
   ```

2. Clone/copy this config to `~/.config/nvim/`

3. Install required global CLIs:
   ```bash
   npm i -g typescript typescript-language-server prettier
   ```

4. Launch nvim. lazy.nvim will bootstrap and install plugins. Wait until install completes, then restart nvim.

## Plugins & Features

- **Theme:** catppuccin (mocha)
- **Fuzzy finder:** telescope
- **Completion:** nvim-cmp + LSP
- **Formatting:** none-ls (prettier)
- **Syntax:** treesitter + rainbow delimiters
- **Editing:** nvim-autopairs + nvim-surround
- **UI:** bufferline (tabs), lualine (statusline)
- **Git:** gitsigns (change indicators)
- **File explorer:** nvim-tree
- **Diagnostics:** trouble.nvim

---

# Keybindings Cheatsheet

**Leader key:** `Space`

> Tip: Press `Space` and wait to see which-key popup with available commands

## Buffer Navigation

| Key | Action |
|-----|--------|
| `Tab` | Next buffer |
| `Shift+Tab` | Previous buffer |
| `Space bd` | Close current buffer |

## File Explorer (nvim-tree)

| Key | Action |
|-----|--------|
| `Space e` | Toggle file tree |
| `Space r` | Reveal current file in tree |
| `Space tr` | Toggle tree and return to editor |

**Inside nvim-tree:**
| Key | Action |
|-----|--------|
| `Enter` | Open file/folder |
| `a` | Create new file |
| `d` | Delete file |
| `r` | Rename file |
| `c` | Copy file |
| `p` | Paste file |
| `y` | Copy filename |
| `Y` | Copy relative path |
| `q` | Close tree |
| `R` | Refresh |
| `H` | Toggle hidden files |

## Telescope (Fuzzy Finder)

| Key | Action |
|-----|--------|
| `Space ff` | Find files |
| `Space fg` | Live grep (search in project) |
| `Space fb` | List open buffers |
| `Space fh` | Search help tags |
| `Space fk` | Search all keymaps |

**Inside Telescope:**
| Key | Action |
|-----|--------|
| `Ctrl+j/k` | Move up/down in results |
| `Enter` | Open selected |
| `Ctrl+x` | Open in horizontal split |
| `Ctrl+v` | Open in vertical split |
| `Ctrl+t` | Open in new tab |
| `Esc` | Close telescope |

## LSP Features

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gr` | Go to references |
| `gi` | Go to implementation |
| `K` | Show hover documentation |
| `Space rn` | Rename symbol |
| `Space ca` | Code action (quick fixes) |
| `Space fm` | Format buffer |
| `Space ts` | Toggle semantic highlighting |

## Diagnostics

| Key | Action |
|-----|--------|
| `Space d` | Show diagnostic in floating window |
| `[d` | Go to previous diagnostic |
| `]d` | Go to next diagnostic |
| `Space xx` | Toggle diagnostics panel (Trouble) |
| `Space xd` | Buffer diagnostics only |
| `Space xl` | Location list |
| `Space xq` | Quickfix list |

## Autocompletion

| Key | Action |
|-----|--------|
| `Tab` | Select next item / expand snippet |
| `Shift+Tab` | Select previous item |
| `Enter` | Confirm selection |
| `Ctrl+Space` | Trigger completion manually |
| `Ctrl+e` | Close completion menu |

## Surround Text (nvim-surround)

### Add Surroundings

| Key | Action | Example |
|-----|--------|---------|
| `ys{motion}{char}` | Surround motion with char | `ysiw"` = surround word with quotes |
| `yss{char}` | Surround entire line | `yss)` = surround line with () |

**Examples:**
- `ysiw"` - Surround inner word with `"` → `hello` becomes `"hello"`
- `ysiw)` - Surround inner word with `()` → `hello` becomes `(hello)`
- `ysiw}` - Surround inner word with `{}` → `hello` becomes `{hello}`
- `ysiw]` - Surround inner word with `[]` → `hello` becomes `[hello]`
- `ysiw>` - Surround inner word with `<>` → `hello` becomes `<hello>`
- `ysiw'` - Surround inner word with `'` → `hello` becomes `'hello'`
- `ys$"` - Surround from cursor to end of line with `"`
- `yss"` - Surround entire line with `"`

### Change Surroundings

| Key | Action | Example |
|-----|--------|---------|
| `cs{old}{new}` | Change surrounding | `cs"'` = change `"` to `'` |

**Examples:**
- `cs"'` - Change `"hello"` to `'hello'`
- `cs)}` - Change `(hello)` to `{hello}`
- `cs]>` - Change `[hello]` to `<hello>`
- `cst"` - Change HTML tag to `"` → `<p>hello</p>` becomes `"hello"`

### Delete Surroundings

| Key | Action | Example |
|-----|--------|---------|
| `ds{char}` | Delete surrounding | `ds"` = remove `"` |

**Examples:**
- `ds"` - Delete `"hello"` → `hello`
- `ds)` - Delete `(hello)` → `hello`
- `dst` - Delete surrounding HTML tag → `<p>hello</p>` becomes `hello`

### Visual Mode Surround (Custom)

Select text first (v, V, or Ctrl+v), then:

| Key | Action |
|-----|--------|
| `Space s(` | Wrap with `()` |
| `Space s[` | Wrap with `[]` |
| `Space s{` | Wrap with `{}` |
| `Space s"` | Wrap with `""` |
| `Space s'` | Wrap with `''` |
| `Space s\`` | Wrap with backticks |
| `Space s<` | Wrap with `<>` |

## Essential Vim Motions

### Navigation

| Key | Action |
|-----|--------|
| `h/j/k/l` | Left/down/up/right |
| `w/b` | Next/previous word |
| `e` | End of word |
| `0/$` | Start/end of line |
| `^` | First non-blank character |
| `gg/G` | Start/end of file |
| `{/}` | Previous/next paragraph |
| `Ctrl+d/u` | Half page down/up |
| `Ctrl+f/b` | Full page down/up |
| `%` | Jump to matching bracket |
| `f{char}` | Jump to char on line |
| `t{char}` | Jump to before char |
| `;/,` | Repeat f/t forward/backward |

### Editing

| Key | Action |
|-----|--------|
| `i/a` | Insert before/after cursor |
| `I/A` | Insert at start/end of line |
| `o/O` | New line below/above |
| `x` | Delete character |
| `dd` | Delete line |
| `D` | Delete to end of line |
| `cc` | Change entire line |
| `C` | Change to end of line |
| `cw` | Change word |
| `ciw` | Change inner word |
| `ci"` | Change inside quotes |
| `ci(` | Change inside parentheses |
| `yy` | Yank (copy) line |
| `yw` | Yank word |
| `p/P` | Paste after/before |
| `u` | Undo |
| `Ctrl+r` | Redo |
| `.` | Repeat last command |

### Selection (Visual Mode)

| Key | Action |
|-----|--------|
| `v` | Character-wise selection |
| `V` | Line-wise selection |
| `Ctrl+v` | Block selection |
| `viw` | Select inner word |
| `vi"` | Select inside quotes |
| `vi(` | Select inside parentheses |
| `vit` | Select inside HTML tag |
| `vat` | Select around HTML tag |

### Search

| Key | Action |
|-----|--------|
| `/pattern` | Search forward |
| `?pattern` | Search backward |
| `n/N` | Next/previous match |
| `*/#` | Search word under cursor |

### Windows

| Key | Action |
|-----|--------|
| `Ctrl+w s` | Split horizontal |
| `Ctrl+w v` | Split vertical |
| `Ctrl+w h/j/k/l` | Navigate windows |
| `Ctrl+w q` | Close window |
| `Ctrl+w =` | Equal window sizes |
| `Ctrl+w _` | Maximize height |
| `Ctrl+w \|` | Maximize width |

## Git Signs

| Key | Action |
|-----|--------|
| `]c` | Next git change |
| `[c` | Previous git change |

---

## Notes

- For best linting/formatting, install eslint and prettier per-project
- Customize plugins in `lua/plugins.lua`
- Run `:checkhealth` to diagnose issues
- Run `:Mason` to manage LSP servers
