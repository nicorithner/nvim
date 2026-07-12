local map = vim.keymap.set

-- Buffer navigation
map("n", "<Tab>", ":bnext<CR>", { desc = "Next buffer" })
map("n", "<S-Tab>", ":bprevious<CR>", { desc = "Previous buffer" })
map("n", "<leader>bd", function()
	local bufnr = vim.api.nvim_get_current_buf()
	local buftype = vim.bo[bufnr].buftype
	local filetype = vim.bo[bufnr].filetype

	-- For special buffers (Trouble, help, terminal, etc.), just close the window
	if buftype ~= "" or filetype == "Trouble" or filetype == "NvimTree" then
		vim.cmd("close")
		return
	end

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
map("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", { desc = "Find keymaps" })

-- LSP helper keymaps (these work once an LSP attaches)
map("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
map("n", "gr", vim.lsp.buf.references, { desc = "Go to references" })
map("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
map("n", "K", vim.lsp.buf.hover, { desc = "Hover" })
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
map("n", "<leader>fm", function()
	local filetype = vim.bo.filetype
	
	-- For Python, use black directly
	if filetype == "python" then
		local black_path = vim.fn.stdpath("data") .. "/mason/bin/black"
		if vim.fn.executable(black_path) == 1 then
			local file = vim.fn.expand("%:p")
			vim.fn.system(black_path .. " " .. file)
			vim.cmd("edit!") -- Reload the file
			print("Formatted with black")
		else
			print("Black not found")
		end
	else
		-- For other languages, try conform first, then LSP
		local ok, conform = pcall(require, "conform")
		if ok then
			conform.format({ timeout_ms = 3000, lsp_fallback = true })
		else
			vim.lsp.buf.format({ async = true })
		end
	end
end, { desc = "Format buffer" })

-- Diagnostics
map("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show diagnostic" })
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
map("n", "<leader>li", "<cmd>LspInfo<CR>", { desc = "LSP Info" })
map("n", "<leader>lr", function()
	vim.cmd("LspRestart")
	print("LSP restarted")
end, { desc = "Restart LSP" })

-- Nvim-tree keymaps (toggle / reveal)
map("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle file tree (NvimTree)" })
map("n", "<leader>r", ":NvimTreeFindFileToggle<CR>", { desc = "Reveal file in NvimTree" })
map("n", "<leader>tr", ":NvimTreeToggle<CR>:wincmd p<CR>", { desc = "Toggle tree and return" })

-- Visual mode wrapping keymaps (simple surround alternative)
map("v", "<leader>s(", "c()<Esc>P", { desc = "Wrap with ()" })
map("v", "<leader>s[", "c[]<Esc>P", { desc = "Wrap with []" })
map("v", "<leader>s{", "c{}<Esc>P", { desc = "Wrap with {}" })
map("v", '<leader>s"', 'c""<Esc>P', { desc = "Wrap with quotes" })
map("v", "<leader>s'", "c''<Esc>P", { desc = "Wrap with single quotes" })
map("v", "<leader>s`", "c``<Esc>P", { desc = "Wrap with backticks" })
map("v", "<leader>s<", "c<><Esc>P", { desc = "Wrap with <>" })

-- Toggle LSP semantic highlighting
map("n", "<leader>ts", function()
	local bufnr = vim.api.nvim_get_current_buf()
	local clients = vim.lsp.get_clients({ bufnr = bufnr })
	
	-- nil or true means enabled, false means disabled
	if vim.b.semantic_tokens_enabled == false then
		-- Re-enable
		for _, client in ipairs(clients) do
			if client.server_capabilities.semanticTokensProvider then
				vim.lsp.semantic_tokens.start(bufnr, client.id)
			end
		end
		vim.b.semantic_tokens_enabled = true
		print("Semantic highlighting enabled")
	else
		-- Disable (handles both nil and true)
		for _, client in ipairs(clients) do
			if client.server_capabilities.semanticTokensProvider then
				vim.lsp.semantic_tokens.stop(bufnr, client.id)
			end
		end
		vim.b.semantic_tokens_enabled = false
		print("Semantic highlighting disabled")
	end
end, { desc = "Toggle semantic highlighting" })
