```markdown
Minimal Neovim config README
============================

Purpose
- Minimal, clean Neovim setup for web development (JS/TS/CSS/SASS).
- No AI code suggestions. Standard LSP-driven completion only.

Installation
1. Backup old config:
   mv ~/.config/nvim ~/.config/nvim.backup

2. Place init.lua at ~/.config/nvim/init.lua (the provided file).

3. Install required global CLIs (recommended):
   npm i -g typescript typescript-language-server
   npm i -g eslint_d eslint
   npm i -g prettier
   npm i -g stylelint stylelint-config-standard stylelint-scss

   (Prefer per-project installs in package.json for reproducible linting.)

4. Launch nvim. lazy.nvim will bootstrap and install plugins. Wait until install completes, then restart nvim.

Plugins & features
- catppuccin theme (mocha)
- telescope (find_files, live_grep)
- nvim-cmp + LSP (no AI)
- none-ls (prettier / eslint_d)
- treesitter + rainbow delimiters
- nvim-autopairs + nvim-surround
- bufferline + simple Tab cycling
- gitsigns shows changed lines in the gutter
- nvim-tree file explorer

Keymaps cheatsheet
==================

Leader key: `<Space>`

Buffer navigation
-----------------
- `Tab` : next buffer
- `Shift+Tab` : previous buffer
- `<Leader>bd` : close buffer (Space + b + d)

File explorer (nvim-tree)
--------------------------
- `<Leader>e` : toggle file tree (Space + e)
- `<Leader>r` : reveal current file in tree (Space + r)
- `<Leader>tr` : toggle tree and return to editor (Space + t + r)

Telescope (fuzzy finder)
-------------------------
- `<Leader>ff` : find files (Space + f + f)
- `<Leader>fg` : live grep/search in project (Space + f + g)
- `<Leader>fb` : list buffers (Space + f + b)
- `<Leader>fh` : search help tags (Space + f + h)

LSP features
------------
- `gd` : go to definition
- `K` : show hover documentation
- `<Leader>rn` : rename symbol (Space + r + n)
- `<Leader>f` : format code (Space + f)

Notes
- For best linting and formatting, install and configure eslint and stylelint per-project.
- The config uses eslint_d (fast) if available; it will fall back to eslint.
- You can customize plugin options in the init.lua file.
```
