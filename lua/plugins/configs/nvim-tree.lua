-- plugins/configs/nvim-tree.lua
-- nvim-tree configuration extracted to its own module
local ok, nvim_tree = pcall(require, "nvim-tree")
if not ok then return end

nvim_tree.setup({
  disable_netrw = true,
  hijack_netrw = true,
  update_cwd = true,
  respect_buf_cwd = true,
  hijack_directories = { enable = true },
  view = {
    side = "left",
    width = 30,
    preserve_window_proportions = false,
  },
  renderer = {
    highlight_git = true,
    icons = {
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
      },
    },
  },
  git = { enable = true, ignore = false, timeout = 400 },
  actions = {
    open_file = { resize_window = true },
  },
  filters = { dotfiles = false, custom = { "node_modules" } },
})
