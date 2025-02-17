-- Supported Language Servers
local lsp_installed = {
  "bashls",
  "gopls",
  "pyright",
  "jsonls",
  "lua_ls",
  "ts_ls",
  "yamlls",
}

local lsp = {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
          { "williamboman/mason.nvim", opts = { ui = { border = "rounded" } } },
        },
        opts = { ensure_installed = lsp_installed },
      },
      "saghen/blink.cmp",
    },
    lazy = false,
    config = function()
      vim.lsp.inlay_hint.enable()
      require("lspconfig.ui.windows").default_options.border = "single"
      local capabilities = require("blink.cmp").get_lsp_capabilities()
      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      }
      require("mason-lspconfig").setup_handlers({
        -- The first entry (without a key) will be the default handler
        -- and will be called for each installed server that doesn't have
        -- a dedicated handler.
        function(server_name) -- default handler (optional)
          require("lspconfig")[server_name].setup({ capabilities })
        end,
        -- Next, you can provide a dedicated handler for specific servers.
        -- For example, a handler override for the `rust_analyzer`:
        ["lua_ls"] = function()
          require("lspconfig")["lua_ls"].setup({
            capabilities = capabilities,
            settings = {
              Lua = {
                diagnostics = { globals = { "vim", "Snacks" } },
                hint = { enable = true },
              },
            },
          })
        end,
        ["ts_ls"] = function()
          require("lspconfig")["ts_ls"].setup({
            capabilities = capabilities,
            on_attach = function(client, bufnr) client.server_capabilities.documentFormattingProvider = false end,
            settings = {
              implicitProjectConfiguration = {
                checkJs = true,
              },
              inlayHints = { enable = true },
              typescript = {
                inlayHints = {
                  -- You can set this to 'all' or 'literals' to enable more hints
                  includeInlayParameterNameHints = "none", -- 'none' | 'literals' | 'all'
                  includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                  includeInlayFunctionParameterTypeHints = false,
                  includeInlayVariableTypeHints = false,
                  includeInlayVariableTypeHintsWhenTypeMatchesName = false,
                  includeInlayPropertyDeclarationTypeHints = false,
                  includeInlayFunctionLikeReturnTypeHints = true,
                  includeInlayEnumMemberValueHints = true,
                },
              },
              -- javascript = {
              -- 	inlayHints = {
              -- 		-- You can set this to 'all' or 'literals' to enable more hints
              -- 		includeInlayParameterNameHints = "none", -- 'none' | 'literals' | 'all'
              -- 		includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              -- 		includeInlayVariableTypeHints = false,
              -- 		includeInlayFunctionParameterTypeHints = false,
              -- 		includeInlayVariableTypeHintsWhenTypeMatchesName = false,
              -- 		includeInlayPropertyDeclarationTypeHints = false,
              -- 		includeInlayFunctionLikeReturnTypeHints = true,
              -- 		includeInlayEnumMemberValueHints = true,
              -- 	},
              -- },
            },
          })
        end,
        ["yamlls"] = function()
          require("lspconfig")["yamlls"].setup({
            capabilities = capabilities,
            settings = { yaml = { keyOrdering = false } },
          })
        end,
      })
    end,
    keys = {
      { "<leader>cD", vim.lsp.buf.declaration,     desc = "lsp declaration" },
      { "<leader>cd", vim.lsp.buf.definition,      desc = "lsp definition" },
      { "K",          vim.lsp.buf.hover,           desc = "lsp hover" },
      { "<leader>ci", vim.lsp.buf.implementation,  desc = "lsp implementation" },
      { "<leader>D",  vim.lsp.buf.type_definition, desc = "lsp type" },
      { "<leader>cw", vim.lsp.buf.rename,          desc = "lsp rename" },
      { "<leader>cr", vim.lsp.buf.references,      desc = "lsp references" },
      { "<leader>ca", vim.lsp.buf.code_action,     desc = "code action" },
      {
        "<leader>cf",
        function() vim.lsp.buf.format({ timeout_ms = 10000 }) end,
        desc = "code format",
      },
    },
  },
  {
    "nvimtools/none-ls.nvim",
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        debug = true,
        sources = {
          -- null_ls.builtins.diagnostics.eslint.with({
          -- 	condition = function(utils)
          -- 		return utils.root_has_file({
          -- 			".eslintrc",
          -- 			".eslintrc.js",
          -- 			".eslintrc.cjs",
          -- 			".eslintrc.yaml",
          -- 			".eslintrc.yml",
          -- 			".eslintrc.json",
          -- 		})
          -- 	end,
          -- }),
          null_ls.builtins.formatting.prettier,
          null_ls.builtins.formatting.stylua,
          -- null_ls.builtins.diagnostics.pylint.with({ prefer_local = "venv/bin" }),
          -- null_ls.builtins.diagnostics.ruff,
          -- null_ls.builtins.formatting.black,
          -- null_ls.builtins.diagnostics.staticcheck,
          -- null_ls.builtins.formatting.shfmt,
          -- null_ls.builtins.formatting.rustfmt,
        },
      })
      local _border = "single"
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = _border })
      vim.diagnostic.config({ float = { border = _border }, virtual_text = false })
    end,
  },
}
return lsp
