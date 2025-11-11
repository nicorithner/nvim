-- core/options.lua
local o = vim.opt

o.termguicolors = true
o.number = true
o.relativenumber = true
o.cursorline = true
o.ignorecase = true
o.smartcase = true
o.tabstop = 2
o.shiftwidth = 2
o.expandtab = true
o.mouse = "a"
o.clipboard = "unnamedplus"

-- Try to set the catppuccin colorscheme if available; don't error if plugin not installed yet.
local ok, _ = pcall(vim.cmd, "colorscheme catppuccin")
if not ok then
  -- Fallback: do nothing (Neovim will use default colors) — theme will load once plugin is installed.
  -- Optionally you can set a fallback colorscheme here, e.g. "default" or another builtin theme.
  -- vim.cmd("colorscheme default")
end
