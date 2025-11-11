local map = vim.keymap.set

-- Buffer navigation
map("n", "<Tab>", ":bnext<CR>", { desc = "Next buffer" })
map("n", "<S-Tab>", ":bprevious<CR>", { desc = "Previous buffer" })
map("n", "<leader>bd", function()
  local bufnr = vim.api.nvim_get_current_buf()
  local buffers = vim.fn.getbufinfo({ buflisted = 1 })
  
  if #buffers > 1 then
    vim.cmd("bp")
  end
  
  vim.cmd("bd " .. bufnr)
end, { desc = "Close buffer" })

-- Telescope pickers
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Grep project" })
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help" })

-- LSP helper keymaps (these work once an LSP attaches)
map("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
map("n", "K", vim.lsp.buf.hover, { desc = "Hover" })
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename" })
map("n", "<leader>f", function() vim.lsp.buf.format({ async = true }) end, { desc = "Format" })

-- Nvim-tree keymaps (toggle / reveal)
map("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle file tree (NvimTree)" })
map("n", "<leader>r", ":NvimTreeFindFileToggle<CR>", { desc = "Reveal file in NvimTree" })
map("n", "<leader>tr", ":NvimTreeToggle<CR>:wincmd p<CR>", { desc = "Toggle tree and return" })
