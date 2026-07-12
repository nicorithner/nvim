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

-- Suppress transient LSP errors during initialization
local original_notify = vim.notify
vim.notify = function(msg, level, opts)
  -- Suppress "No client with id" errors during startup
  if type(msg) == "string" and msg:match("No client with id") then
    return
  end
  original_notify(msg, level, opts)
end
