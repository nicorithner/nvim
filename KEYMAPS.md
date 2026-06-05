# Neovim Keymaps Quick Reference

**Leader key:** `Space`

## 📋 Essential Commands

### Finding & Navigation
- `<Space>ff` - Find files (Telescope)
- `<Space>fg` - Grep/search in project
- `<Space>fb` - Browse buffers
- `<Space>fh` - Search help documentation
- `<Space>fk` - **Find keymaps** (search all available keybindings!)

### LSP (Code Intelligence)
- `gd` - Go to definition
- `gr` - Go to references
- `gi` - Go to implementation
- `K` - Show hover documentation
- `<Space>rn` - Rename symbol
- `<Space>ca` - Code actions (fixes/refactorings)
- `<Space>fm` - **Format current buffer**
- `<Space>d` - Show diagnostic/error details
- `<Space>li` - **LSP Info** (check if LSP is running)
- `[d` - Previous diagnostic
- `]d` - Next diagnostic

### Buffer Management
- `Tab` - Next buffer
- `Shift-Tab` - Previous buffer
- `<Space>bd` - Close current buffer

### File Explorer
- `<Space>e` - Toggle file tree (NvimTree)
- `<Space>r` - Reveal current file in tree

### Surround Text (Visual Mode)
Select text first, then:
- `<Space>s(` - Wrap with `()`
- `<Space>s[` - Wrap with `[]`
- `<Space>s{` - Wrap with `{}`
- `<Space>s"` - Wrap with `""`
- `<Space>s'` - Wrap with `''`
- `<Space>s\`` - Wrap with backticks
- `<Space>s<` - Wrap with `<>`

### Diagnostics (Trouble)
- `<Space>xx` - Toggle diagnostics panel
- `<Space>xd` - Buffer diagnostics only
- `<Space>xl` - Location list
- `<Space>xq` - Quickfix list

### Autocompletion (Insert Mode)
- `Ctrl-Space` - Trigger completion menu
- `Tab` - Select next item / expand snippet
- `Shift-Tab` - Select previous item / jump back in snippet
- `Enter` - Confirm selection
- `Ctrl-e` - Close completion menu

**Completion Sources (in priority order):**
1. **[LSP]** - Language server (max 15 items) - **CONTEXT-AWARE SUGGESTIONS**
2. **[Snip]** - Code snippets (max 8 items) - Type `af` (arrow fn), `fn` (function), `for`, `if`
3. **[Path]** - File paths (max 5 items)

**Note:** Buffer word suggestions are disabled to keep completions clean and LSP-focused!

**Popular JavaScript snippets:**
- `af` → arrow function
- `fn` → function
- `for` → for loop
- `foreach` → forEach loop
- `if` → if statement
- `ife` → if-else statement

### Toggle Features
- `<Space>ts` - Toggle semantic highlighting

## 🎨 Visual Features
- **Rainbow parentheses** - Automatically colors matching brackets
- **Autopairs** - Auto-closes brackets, quotes, etc.
- **Which-key** - Press `Space` and wait to see available commands

## 💡 Pro Tips
1. **Don't remember a keymap?** Press `<Space>fk` to search all keybindings!
2. **Format your code:** `<Space>fm` formats the current file
3. **Auto-format on save is DISABLED** - Use manual format command when needed
4. **Hover for docs:** Press `K` over any function/variable
5. **Which-key popup:** Just press `Space` and wait 300ms to see options
6. **LSP not working?** Press `<Space>li` to check LSP status and see which servers are attached
7. **Better completions:** Make sure you see **[LSP]** labels in the completion menu - those are the smart suggestions!

## 🔧 Language Support
- JavaScript/TypeScript (ts_ls) - **Instant completions**
- HTML (html + emmet_ls)
- CSS/SCSS (cssls + emmet_ls)
- Java (jdtls)
- **C++ (clangd)** - ⚠️ Takes 10-20 seconds to fully initialize after opening file
- Lua (lua_ls)

**Note for C++:** If you don't see completions immediately:
1. Wait 10-20 seconds after opening a `.cpp` file
2. Check with `<Space>li` to verify clangd is running
3. For best results, work in a project with proper C++ structure

## 📦 Next Steps
After editing the config, restart Neovim. Lazy.nvim and Mason will automatically:
1. Install missing plugins
2. Install language servers (jdtls, clangd, etc.)
3. Install formatters (prettier, google-java-format, clang-format)

**Note:** Auto-format on save is **disabled**. Use `<Space>fm` to format manually when needed.

## 🐍 Python Support
- Python (pyright) - LSP for type checking and completions
- Formatter: black - Automatically formats Python code with `<Space>fm`
