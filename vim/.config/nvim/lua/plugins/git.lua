return {
	{
		"sindrets/diffview.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		opts = {
			keymaps = {
				file_panel = {
					["q"] = "<Cmd>DiffviewClose<CR>",
				},
				view = {
					["q"] = "<Cmd>DiffviewClose<CR>",
				},
			},
		},
		keys = {
			{ "<leader>gg", "<Cmd>DiffviewOpen<CR>", desc = "open in gh" },
			{ "<leader>gh", "<Cmd>DiffviewFileHistory<CR>", desc = "open in gh" },
		},
	},
	{
		"lewis6991/gitsigns.nvim",
		config = true,
	},
	-- {
	-- 	"NeogitOrg/neogit",
	-- 	dependencies = {
	-- 		"nvim-lua/plenary.nvim",
	-- 		"sindrets/diffview.nvim",
	-- 		"nvim-telescope/telescope.nvim",
	-- 	},
	-- 	opts = {
	-- 		disable_signs = true,
	-- 	},
	-- 	keys = {
	-- 		{ "<leader>gg", "<Cmd>Neogit<CR>", desc = "Git" },
	-- 	},
	-- },
	-- {
	-- 	"almo7aya/openingh.nvim",
	-- 	config = true,
	-- 	keys = {
	-- 		{ "<leader>go", "<Cmd>OpenInGHFileLines<CR>", desc = "open in gh" },
	-- 	},
	-- 	lazy = true,
	-- },
}
