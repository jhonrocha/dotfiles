-- Supported Language Servers
local lsp_installed = {
  "bashls",
  "gopls",
  "pyright",
  "jsonls",
  "lua_ls",
  "tsserver",
  "yamlls",
  "rust_analyzer",
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
        opts = { ensure_installed = lsp_installed, automatic_installation = true },
      },
    },
    config = function()
      require('lspconfig.ui.windows').default_options.border = 'single'
      require("mason-lspconfig").setup_handlers({
        -- The first entry (without a key) will be the default handler
        -- and will be called for each installed server that doesn't have
        -- a dedicated handler.
        function(server_name) -- default handler (optional)
          local opts = {}
          opts.capabilities = require("cmp_nvim_lsp").default_capabilities()
          require("lspconfig")[server_name].setup(opts)
        end,
        -- Next, you can provide a dedicated handler for specific servers.
        -- For example, a handler override for the `rust_analyzer`:
        ["lua_ls"] = function()
          local opts = {}
          opts.capabilities = require("cmp_nvim_lsp").default_capabilities()
          opts.settings = { Lua = { diagnostics = { globals = { "vim" } }, hint = { enable = true } } }
          require("lspconfig")["lua_ls"].setup(opts)
        end,
        ["tsserver"] = function()
          local opts = {}
          opts.capabilities = require("cmp_nvim_lsp").default_capabilities()
          opts.on_attach = function(client)
            client.server_capabilities.documentFormattingProvider = false
          end
          opts.settings = {
            implicitProjectConfiguration = {
              checkJs = true,
            },
          }
          require("lspconfig")["tsserver"].setup(opts)
        end,
        ["gopls"] = function()
          local opts = {}
          opts.capabilities = require("cmp_nvim_lsp").default_capabilities()
          opts.init_options = { buildFlags = { "-tags=integration" } }
          require("lspconfig")["gopls"].setup(opts)
        end,
        ["rust_analyzer"] = function()
          local opts = {}
          opts.capabilities = require("cmp_nvim_lsp").default_capabilities()
          opts.settings = { ["rust-analyzer"] = { check = { command = { "clippy" } } } }
          require("lspconfig")["rust_analyzer"].setup(opts)
        end,
        ["yamlls"] = function()
          local opts = {}
          opts.capabilities = require("cmp_nvim_lsp").default_capabilities()
          opts.settings = { yaml = { keyOrdering = false } }
          require("lspconfig")["rust_analyzer"].setup(opts)
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
        function()
          vim.lsp.buf.format({ timeout_ms = 10000 })
        end,
        desc = "code format",
      },
    },
  },
  {
    "lvimuser/lsp-inlayhints.nvim",
    dependencies = "neovim/nvim-lspconfig",
    config = function()
      require("lsp-inlayhints").setup({ inlay_hints = { highlight = "Comment" } })
      vim.api.nvim_create_augroup("LspAttach_inlayhints", {})
      vim.api.nvim_create_autocmd("LspAttach", {
        group = "LspAttach_inlayhints",
        callback = function(args)
          if not (args.data and args.data.client_id) then
            return
          end
          local bufnr = args.buf
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          require("lsp-inlayhints").on_attach(client, bufnr)
        end,
      })
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        debug = true,
        sources = {
          null_ls.builtins.diagnostics.eslint.with({
            condition = function(utils)
              return utils.root_has_file({
                ".eslintrc",
                ".eslintrc.js",
                ".eslintrc.cjs",
                ".eslintrc.yaml",
                ".eslintrc.yml",
                ".eslintrc.json",
              })
            end,
          }),
          -- null_ls.builtins.formatting.eslint.with({
          --   condition = function(utils)
          --     return utils.root_has_file({
          --       ".eslintrc",
          --       ".eslintrc.js",
          --       ".eslintrc.cjs",
          --       ".eslintrc.yaml",
          --       ".eslintrc.yml",
          --       ".eslintrc.json",
          --     })
          --   end,
          -- }),
          null_ls.builtins.formatting.prettier.with({
            condition = function(utils)
              return utils.root_has_file({ ".prettierrc" })
            end,
          }),
          null_ls.builtins.formatting.stylua,
          -- null_ls.builtins.diagnostics.pylint.with({ prefer_local = "venv/bin" }),
          null_ls.builtins.diagnostics.ruff,
          null_ls.builtins.diagnostics.staticcheck,
          null_ls.builtins.formatting.shfmt,
          null_ls.builtins.formatting.rustfmt,
        },
      })
      local _border = "single"
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = _border })
      vim.diagnostic.config({ float = { border = _border }, virtual_text = false })
    end,
  },
}
return lsp
