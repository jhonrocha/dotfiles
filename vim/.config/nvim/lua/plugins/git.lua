return {
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"sindrets/diffview.nvim",
			"nvim-telescope/telescope.nvim",
		},
		opts = {
			disable_signs = true,
		},
		keys = {
			{ "<leader>gg", "<Cmd>Neogit<CR>", desc = "Git" },
		},
	},
	-- {
	-- 	"almo7aya/openingh.nvim",
	-- 	config = true,
	-- 	keys = {
	-- 		{ "<leader>go", "<Cmd>OpenInGHFileLines<CR>", desc = "open in gh" },
	-- 	},
	-- 	lazy = true,
	-- },
}
