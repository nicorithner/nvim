-- Auto-open nvim-tree when nvim is started with a directory (safe require)
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function(data)
    -- only proceed if the buffer is a directory
    if vim.fn.isdirectory(data.file) ~= 1 then return end
    -- require nvim-tree safely
    local ok, nvim_tree_api = pcall(require, "nvim-tree.api")
    if not ok then return end
    nvim_tree_api.tree.open()
  end,
})
