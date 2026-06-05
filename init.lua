-- init.lua (minimal launcher)
-- Bootstraps lazy.nvim and loads plugins first, then core modules.

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Load plugins (lazy will install them)
-- This must happen before we attempt to apply a colorscheme provided by a plugin.
require("plugins")

-- Load configuration modules (options after plugins so colorscheme is available)
require("core.options")
require("core.keymaps")
require("core.autocmds")
