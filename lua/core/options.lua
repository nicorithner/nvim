-- core/options.lua
local o = vim.opt

-- Add Mason bin to PATH so LSP servers can be found
vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin:" .. vim.env.PATH

o.termguicolors = true
o.number = true
-- o.relativenumber = true
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

-- Configure LSP floating windows with borders and padding
local border = {
  { "╭", "FloatBorder" },
  { "─", "FloatBorder" },
  { "╮", "FloatBorder" },
  { "│", "FloatBorder" },
  { "╯", "FloatBorder" },
  { "─", "FloatBorder" },
  { "╰", "FloatBorder" },
  { "│", "FloatBorder" },
}

vim.lsp.handlers["textDocument/hover"] = function(...)
  local bufnr, winnr = vim.lsp.handlers.hover(...)
  if winnr then
    vim.api.nvim_win_set_config(winnr, { border = border })
  end
end

vim.lsp.handlers["textDocument/signatureHelp"] = function(...)
  local bufnr, winnr = vim.lsp.handlers.signature_help(...)
  if winnr then
    vim.api.nvim_win_set_config(winnr, { border = border })
  end
end

-- Diagnostic floating windows
vim.diagnostic.config({
  float = {
    border = "rounded",
  },
})

-- Custom highlight for floating windows (slate blue background)
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#3e4c5e", fg = "#c0caf5" })
    vim.api.nvim_set_hl(0, "FloatBorder", { bg = "#3e4c5e", fg = "#7aa2f7" })
  end,
})

-- Apply immediately if colorscheme is already loaded
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#3e4c5e", fg = "#c0caf5" })
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "#3e4c5e", fg = "#7aa2f7" })
