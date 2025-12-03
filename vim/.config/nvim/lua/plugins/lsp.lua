local lsp = {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "mason-org/mason-lspconfig.nvim",
        dependencies = {
          { "mason-org/mason.nvim", opts = { ui = { border = "rounded" } } },
        },
        opts = { ensure_installed = {} },
        lazy = true,
      },
    },
    lazy = false,
    config = function()
      -- vim.lsp.inlay_hint.enable()
      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            diagnostics = { globals = { "vim", "Snacks" } },
            hint = { enable = true },
          },
        },
      })
      vim.lsp.config("yamlls", {
        settings = { yaml = { keyOrdering = false } },
      })
      vim.lsp.config("tsgo", {
        cmd = { "tsgo", "--lsp", "--stdio" },
        filetypes = {
          "javascript",
          "javascriptreact",
          "javascript.jsx",
          "typescript",
          "typescriptreact",
          "typescript.tsx",
        },
        root_markers = {
          "tsconfig.json",
          "jsconfig.json",
          "package.json",
          ".git",
          "tsconfig.base.json",
        },
        on_attach = function(client)
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
        end,
      })
      vim.lsp.enable("tsgo")
    end,
    keys = {
      { "<leader>ca", vim.lsp.buf.code_action,     desc = "code action" },
      { "<leader>cD", vim.lsp.buf.declaration,     desc = "lsp declaration" },
      { "<leader>cd", vim.lsp.buf.definition,      desc = "lsp definition" },
      { "K",          vim.lsp.buf.hover,           desc = "lsp hover" },
      { "<leader>ci", vim.lsp.buf.implementation,  desc = "lsp implementation" },
      { "<leader>D",  vim.lsp.buf.type_definition, desc = "lsp type" },
      { "<leader>cw", vim.lsp.buf.rename,          desc = "lsp rename" },
      { "<leader>cr", vim.lsp.buf.references,      desc = "lsp references" },
      {
        "<leader>cf",
        -- function() vim.lsp.buf.format({ timeout_ms = 10000 }) end,
        function() require("conform").format({ lsp_format = "fallback" }) end,
        desc = "code format",
      },
    },
  },
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        -- lua = { "stylua", lsp_format = "first" },
        -- Conform will run multiple formatters sequentially
        python = { "isort", "black", lsp_format = "last" },
        -- You can customize some of the format options for the filetype (:help conform.format)
        rust = { "rustfmt", lsp_format = "fallback" },
        -- Conform will run the first available formatter
        javascript = { "prettierd", "prettier", stop_after_first = true, lsp_format = "never" },
      },
      format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 500,
        lsp_format = "fallback",
      },
    }
  }
  -- {
  --   "nvimtools/none-ls.nvim",
  --   config = function()
  --     local null_ls = require("null-ls")
  --     null_ls.setup({
  --       debug = true,
  --       sources = {
  --         -- null_ls.builtins.diagnostics.eslint.with({
  --         -- 	condition = function(utils)
  --         -- 		return utils.root_has_file({
  --         -- 			".eslintrc",
  --         -- 			".eslintrc.js",
  --         -- 			".eslintrc.cjs",
  --         -- 			".eslintrc.yaml",
  --         -- 			".eslintrc.yml",
  --         -- 			".eslintrc.json",
  --         -- 		})
  --         -- 	end,
  --         -- }),
  --         null_ls.builtins.formatting.prettier,
  --         -- null_ls.builtins.formatting.stylua,
  --         -- null_ls.builtins.diagnostics.pylint.with({ prefer_local = "venv/bin" }),
  --         null_ls.builtins.formatting.sql_formatter,
  --         -- null_ls.builtins.formatting.black,
  --         -- null_ls.builtins.diagnostics.staticcheck,
  --         -- null_ls.builtins.formatting.shfmt,
  --         -- null_ls.builtins.formatting.rustfmt,
  --       },
  --     })
  --     local _border = "single"
  --     vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = _border })
  --   end,
  -- },
}
return lsp
