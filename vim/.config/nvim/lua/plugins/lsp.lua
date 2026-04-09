local lsp = {
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {},
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        lua = { lsp_format = "first" },
        -- python = { "isort", "black", lsp_format = "last" },
        go = { "gofmt", lsp_format = "fallback" },
        json = { "prettier", lsp_format = "never" },
        javascript = { "prettier", stop_after_first = false, lsp_format = "never" },
        javascriptreact = { "prettier", stop_after_first = false, lsp_format = "never" },
        typescript = { "prettier", stop_after_first = false, lsp_format = "never" },
        typescriptreact = { "prettier", stop_after_first = false, lsp_format = "never" },
        rust = { "rustfmt", lsp_format = "fallback" },
        sh = { "shfmt", lsp_format = "first" },
        sql = { "sqfluff", lsp_format = "never" },
      },
      -- format_on_save = { timeout_ms = 500, lsp_format = "fallback", },
    },
    keys = {
      {
        "<leader>cf",
        function()
          require("conform").format({ lsp_format = "fallback" })
        end,
        desc = "code format",
      },
    },
  },
}
return lsp
