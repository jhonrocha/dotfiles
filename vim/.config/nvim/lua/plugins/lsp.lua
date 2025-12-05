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
			vim.lsp.inlay_hint.enable()
			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						diagnostics = { globals = { "vim", "Snacks" } },
						hint = { enable = true },
					},
				},
			})
			vim.lsp.enable("tsgo")
		end,
		keys = {
			{ "<leader>ca", vim.lsp.buf.code_action, desc = "code action" },
			{ "<leader>cD", vim.lsp.buf.declaration, desc = "lsp declaration" },
			{ "<leader>cd", vim.lsp.buf.definition, desc = "lsp definition" },
			{ "K", vim.lsp.buf.hover, desc = "lsp hover" },
			{ "<leader>ci", vim.lsp.buf.implementation, desc = "lsp implementation" },
			{ "<leader>D", vim.lsp.buf.type_definition, desc = "lsp type" },
			{ "<leader>cw", vim.lsp.buf.rename, desc = "lsp rename" },
			{ "<leader>cr", vim.lsp.buf.references, desc = "lsp references" },
		},
	},
	{
		"stevearc/conform.nvim",
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
			-- format_on_save = {
			--   -- These options will be passed to conform.format()
			--   timeout_ms = 500,
			--   lsp_format = "fallback",
			-- },
		},
		keys = {

			{
				"<leader>cf",
				-- function() vim.lsp.buf.format({ timeout_ms = 10000 }) end,
				function()
					require("conform").format({ lsp_format = "fallback" })
				end,
				desc = "code format",
			},
		},
	},
}
return lsp
