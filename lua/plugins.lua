-- plugins.lua (lazy.nvim plugin list)
require("lazy").setup({
  -- utilities
  { "nvim-lua/plenary.nvim" },

  -- colorscheme
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },

  -- icons
  { "nvim-tree/nvim-web-devicons" },

  -- telescope
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" },
    lazy = false,
    config = function()
      require("telescope").setup({
        defaults = { file_ignore_patterns = { "node_modules", ".git/" } },
      })
    end,
  },

  -- treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "javascript", "typescript", "tsx", "css", "scss", "html", "json", "bash", "lua" },
        highlight = { enable = true },
      })
    end,
  },
  {
    "HiPhish/rainbow-delimiters.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },

  -- LSP + Mason
  { 
    "williamboman/mason.nvim",
    lazy = false,
    config = true,
  },
  { 
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "cssls", "ts_ls" },
        automatic_enable = true, -- Uses vim.lsp.enable() instead of lspconfig
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    dependencies = { "williamboman/mason-lspconfig.nvim", "hrsh7th/cmp-nvim-lsp" },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      
      -- Configure servers using the new vim.lsp.config API
      vim.lsp.config("ts_ls", {
        capabilities = capabilities,
        filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
      })
      
      vim.lsp.config("cssls", {
        capabilities = capabilities,
        filetypes = { "css", "scss", "less" },
      })
      
      -- Enable the servers (mason-lspconfig's automatic_enable will also handle this)
      vim.lsp.enable("ts_ls")
      vim.lsp.enable("cssls")
    end,
  },

  -- none-ls (null-ls replacement)
  {
    "nvimtools/none-ls.nvim",
    lazy = false,
    dependencies = { 
      "nvim-lua/plenary.nvim",
      "neovim/nvim-lspconfig",
      "nvimtools/none-ls-extras.nvim",
    },
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.prettier,
          require("none-ls.diagnostics.eslint_d"),
        },
        on_attach = function(client, bufnr)
          if client.supports_method("textDocument/formatting") then
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = vim.api.nvim_create_augroup("LspFormat", { clear = true }),
              buffer = bufnr,
              callback = function() vim.lsp.buf.format({ bufnr = bufnr }) end,
            })
          end
        end,
      })
    end,
  },

  -- completion
  {
    "hrsh7th/nvim-cmp",
    lazy = false,
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        snippet = { expand = function(args) require("luasnip").lsp_expand(args.body) end },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = { { name = "nvim_lsp" }, { name = "buffer" }, { name = "path" }, { name = "luasnip" } },
      })
    end,
  },

  -- autopairs & surround
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup({})
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },
  { "kylechui/nvim-surround", version = "*", config = function() require("nvim-surround").setup({}) end },

  -- bufferline
  {
    "akinsho/bufferline.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function() require("bufferline").setup({ options = { show_buffer_close_icons = false, show_close_icon = false } }) end,
  },

  -- gitsigns
  { "lewis6991/gitsigns.nvim", config = function() require("gitsigns").setup() end },

  -- fzf native
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make", cond = vim.fn.executable("make") == 1 },

  -- nvim-tree (file explorer)
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    -- load when the user runs these commands (so the command becomes available on first use)
    cmd = { "NvimTreeToggle", "NvimTreeOpen", "NvimTreeFindFile" },
    config = function() require("plugins.configs.nvim-tree") end,
  },
}, {
  defaults = { lazy = true },
})
