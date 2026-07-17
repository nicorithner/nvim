-- plugin-specs.lua (lazy.nvim plugin list)
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
    lazy = false,
    build = ":TSUpdate",
    config = function()
      -- Modern nvim-treesitter setup (v0.12+)
      require('nvim-treesitter').setup {
        install_dir = vim.fn.stdpath('data') .. '/site'
      }
      
      -- Install parsers
      require('nvim-treesitter').install({
        'javascript', 'typescript', 'tsx', 'css', 'scss', 
        'html', 'json', 'bash', 'lua', 'java', 'cpp', 'python'
      })
    end,
  },
  {
    "HiPhish/rainbow-delimiters.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },

  -- Mason tool installer (for formatters/linters)
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-tool-installer").setup({
        ensure_installed = {
          "prettier",
          "google-java-format",
          "clang-format",
          "black",
        },
        auto_update = false,
        run_on_start = true,
      })
    end,
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
    dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig", "hrsh7th/cmp-nvim-lsp" },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      
      -- Enhanced capabilities
      capabilities.textDocument.completion.completionItem.snippetSupport = true
      capabilities.textDocument.completion.completionItem.resolveSupport = {
        properties = { "documentation", "detail", "additionalTextEdits" },
      }
      
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "cssls", "ts_ls", "html", "emmet_ls", "jdtls", "clangd", "pyright" },
        automatic_installation = true,
      })
      
      -- Setup handlers for automatic server configuration
      local mason_lspconfig = require("mason-lspconfig")
      if mason_lspconfig.setup_handlers then
        mason_lspconfig.setup_handlers({
          -- Default handler for all servers
          function(server_name)
            require("lspconfig")[server_name].setup({
              capabilities = capabilities,
            })
          end,
          
          -- Custom handler for lua_ls
          ["lua_ls"] = function()
            require("lspconfig").lua_ls.setup({
              capabilities = capabilities,
              settings = {
                Lua = {
                  runtime = { version = "LuaJIT" },
                  diagnostics = { globals = { "vim" } },
                  workspace = {
                    library = { vim.env.VIMRUNTIME, "${3rd}/luv/library" },
                    checkThirdParty = false,
                  },
                  telemetry = { enable = false },
                },
              },
            })
          end,
          
          -- Custom handler for emmet_ls
          ["emmet_ls"] = function()
            require("lspconfig").emmet_ls.setup({
              capabilities = capabilities,
              filetypes = { "html", "css", "scss", "javascriptreact", "typescriptreact" },
            })
          end,
          
          -- Custom handler for ts_ls
          ["ts_ls"] = function()
            require("lspconfig").ts_ls.setup({
              capabilities = capabilities,
              single_file_support = true,
              root_dir = function(fname)
                local util = require("lspconfig.util")
                return util.root_pattern("tsconfig.json", "package.json", "jsconfig.json", ".git")(fname)
                  or util.path.dirname(fname)
              end,
            })
          end,
          
          -- Disable ESLint LSP server (it requires a config file)
          ["eslint"] = function()
            -- Don't setup eslint server - it requires eslint.config.js
          end,
          
          -- Custom handler for clangd with better settings
          ["clangd"] = function()
            require("lspconfig").clangd.setup({
              capabilities = capabilities,
              cmd = {
                "clangd",
                "--background-index",
                "--clang-tidy",
                "--completion-style=detailed",
                "--header-insertion=iwyu",
              },
            })
          end,
          
          -- Skip jdtls - handled by ftplugin/java.lua
          ["jdtls"] = function()
            -- jdtls is configured in ftplugin/java.lua
          end,
        })
      end
    end,
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
  },
  {
    "mfussenegger/nvim-jdtls",
    ft = "java",
  },

  -- none-ls (null-ls replacement)
  {
    "nvimtools/none-ls.nvim",
    lazy = false,
    dependencies = { 
      "nvim-lua/plenary.nvim",
      "neovim/nvim-lspconfig",
    },
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.prettier.with({
            filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "css", "scss", "html", "json" },
            extra_args = { "--tab-width", "2", "--no-tabs" },
          }),
          null_ls.builtins.formatting.google_java_format,
          null_ls.builtins.formatting.clang_format.with({
            filetypes = { "c", "cpp" },
          }),
        },
        -- Auto-format on save DISABLED - use <Space>fm to format manually
      })
    end,
  },

  -- conform.nvim (for Python formatting)
  {
    "stevearc/conform.nvim",
    lazy = false,
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          python = { "black" },
        },
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
      "rafamadriz/friendly-snippets",
    },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
      
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      
      cmp.setup({
        performance = {
          max_view_entries = 20,
        },
        completion = {
          completeopt = "menu,menuone,noinsert",
          keyword_length = 2,
        },
        window = {
          completion = cmp.config.window.bordered({
            max_height = 10,
            max_width = 60,
          }),
          documentation = cmp.config.window.bordered({
            max_height = 12,
            max_width = 60,
          }),
        },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp", priority = 1000, max_item_count = 15 },
          { name = "luasnip", priority = 750, max_item_count = 8 },
          { name = "path", priority = 500, max_item_count = 5 },
        }),
        formatting = {
          format = function(entry, vim_item)
            vim_item.menu = ({
              nvim_lsp = "[LSP]",
              luasnip = "[Snip]",
              buffer = "[Buf]",
              path = "[Path]",
            })[entry.source.name]
            return vim_item
          end,
        },
        sorting = {
          priority_weight = 2,
          comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            cmp.config.compare.recently_used,
            cmp.config.compare.locality,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
          },
        },
        experimental = {
          ghost_text = true,
        },
      })
    end,
  },

  -- autopairs & surround
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    dependencies = { "hrsh7th/nvim-cmp" },
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
    lazy = false,
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("bufferline").setup({
        options = {
          mode = "buffers",
          show_buffer_close_icons = false,
          show_close_icon = false,
          always_show_bufferline = false,
          offsets = {
            {
              filetype = "NvimTree",
              text = "File Explorer",
              text_align = "left",
              separator = true,
            },
          },
        },
      })
    end,
  },

  -- gitsigns
  { "lewis6991/gitsigns.nvim", config = function() require("gitsigns").setup() end },

  -- fzf native
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make", cond = vim.fn.executable("make") == 1 },

  -- nvim-tree (file explorer)
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { "NvimTreeToggle", "NvimTreeOpen", "NvimTreeFindFile" },
    config = function() require("plugins.configs.nvim-tree") end,
  },

  -- lualine (statusline)
  {
    "nvim-lualine/lualine.nvim",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons", "catppuccin/nvim" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "auto",
          component_separators = "|",
          section_separators = { left = "", right = "" },
        },
        sections = {
          lualine_a = {'mode'},
          lualine_b = {'branch', 'diff', 'diagnostics'},
          lualine_c = {'filename'},
          lualine_x = {'encoding', 'fileformat', 'filetype'},
          lualine_y = {'progress'},
          lualine_z = {'location'}
        },
      })
    end,
  },

  -- trouble.nvim (diagnostics panel)
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { "Trouble" },
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
      { "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
      { "<leader>xl", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
      { "<leader>xq", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
    },
    config = function()
      require("trouble").setup({})
    end,
  },

  -- which-key (keymap popup)
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      local wk = require("which-key")
      wk.setup({
        preset = "modern",
        delay = 300,
      })
      wk.add({
        { "<leader>f", group = "Find" },
        { "<leader>x", group = "Diagnostics" },
        { "<leader>b", group = "Buffer" },
        { "<leader>t", group = "Toggle" },
        { "<leader>c", group = "Code" },
        { "<leader>r", group = "Rename" },
        { "<leader>l", group = "LSP" },
      })
    end,
  },
})
-- Removed lazy defaults - let individual plugin settings control loading
