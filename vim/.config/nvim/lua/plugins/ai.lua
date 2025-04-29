return {
	{
		"Exafunction/windsurf.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("codeium").setup({
				enable_cmp_source = false,
				virtual_text = {
					enabled = true,
				},
			})
		end,
		keys = {
			{ "<leader>a", "<Cmd>Codeium Chat<CR>", desc = "ai chat" },
		},
	},
}
