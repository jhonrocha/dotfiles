-- Supported Language Servers
local lsp_installed = {
  "bashls",
  "gopls",
  "jedi_language_server",
  "jsonls",
  "lua_ls",
  "tsserver",
  "yamlls",
  "terraformls",
  "groovyls",
  "rust_analyzer",
  "clangd",
}

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      dependencies = { "williamboman/mason.nvim", config = true },
      opts = { ensure_installed = lsp_installed, automatic_installation = true },
    },
    config = function()
      for _, server_name in pairs(lsp_installed) do
        local opts = {}
        opts.capabilities = require("cmp_nvim_lsp").default_capabilities()
        if server_name == "lua_ls" then
          opts.settings = {
            Lua = { diagnostics = { globals = { "vim" } }, hint = { enable = true } },
          }
        elseif server_name == "tsserver" then
          opts.on_attach = function(client)
            client.server_capabilities.document_formatting = false
          end
        elseif server_name == "gopls" then
          opts.init_options = { buildFlags = { "-tags=integration" } }
        elseif server_name == "clangd" then
          opts.capabilities.offsetEncoding = "utf-8"
        end
        require("lspconfig")[server_name].setup(opts)
      end
    end,
    keys = {
      { "<leader>cD", vim.lsp.buf.declaration, { desc = "lsp declaration" } },
      { "<leader>cd", vim.lsp.buf.definition, { desc = "lsp definition" } },
      { "K", vim.lsp.buf.hover, { desc = "lsp hover" } },
      { "<leader>ci", vim.lsp.buf.implementation, { desc = "lsp implementation" } },
      { "<C-k>", vim.lsp.buf.signature_help, { desc = "lsp signature_help" } },
      { "<leader>D", vim.lsp.buf.type_definition, { desc = "lsp type" } },
      { "<leader>cw", vim.lsp.buf.rename, { desc = "lsp rename" } },
      { "<leader>cr", vim.lsp.buf.references, { desc = "lsp references" } },
      { "<leader>ca", vim.lsp.buf.code_action, { desc = "code action" } },
      { "<leader>cf", vim.lsp.buf.format, { desc = "code format" } },
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
        sources = {
          null_ls.builtins.diagnostics.eslint.with({
            condition = function(utils)
              return utils.root_has_file({
                ".eslintrc.js",
                ".eslintrc.cjs",
                ".eslintrc.yaml",
                ".eslintrc.yml",
                ".eslintrc.json",
              })
            end,
          }),
          null_ls.builtins.formatting.prettier,
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.black.with({ prefer_local = "venv/bin" }),
          null_ls.builtins.diagnostics.pylint.with({ prefer_local = "venv/bin" }),
          null_ls.builtins.diagnostics.staticcheck,
          null_ls.builtins.formatting.shfmt,
          null_ls.builtins.formatting.rustfmt,
          null_ls.builtins.formatting.clang_format,
        },
      })
      local _border = "single"
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = _border })
      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = _border })
      vim.diagnostic.config({ float = { border = _border }, virtual_text = false })
    end,
  },
}