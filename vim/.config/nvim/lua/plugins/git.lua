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
				file_history_panel = {
					["q"] = "<Cmd>DiffviewClose<CR>",
				},
			},
		},
		keys = {
			{ "<leader>gg", "<Cmd>DiffviewOpen<CR>", desc = "diff" },
			{ "<leader>gh", "<Cmd>DiffviewFileHistory<CR>", desc = "history" },
			{ "<leader>gH", "<Cmd>DiffviewFileHistory %<CR>", desc = "history file" },
		},
	},
	-- {
	-- 	"tanvirtin/vgit.nvim",
	-- 	dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" },
	-- 	-- Lazy loading on 'VimEnter' event is necessary.
	-- 	event = "VimEnter",
	-- 	opts = {
	-- 		keymaps = {
	-- 			{ mode = "n", key = "<C-k>", handler = "hunk_up", desc = "hunk_up" },
	-- 			{ mode = "n", key = "<C-j>", handler = "hunk_down", desc = "hunk_down" },
	-- 			{ mode = "n", key = "<leader>gb", handler = "buffer_blame_preview", desc = "buffer_blame_preview" },
	-- 			{ mode = "n", key = "<leader>gs", handler = "buffer_hunk_stage", desc = "buffer_hunk_stage" },
	-- 			{ mode = "n", key = "<leader>gr", handler = "buffer_hunk_reset", desc = "buffer_hunk_reset" },
	-- 			{ mode = "n", key = "<leader>gp", handler = "buffer_hunk_preview", desc = "buffer_hunk_preview" },
	-- 			{ mode = "n", key = "<leader>gf", handler = "buffer_diff_preview", desc = "buffer_diff_preview" },
	-- 			{ mode = "n", key = "<leader>gh", handler = "buffer_history_preview", desc = "buffer_history_preview" },
	-- 			{ mode = "n", key = "<leader>gu", handler = "buffer_reset", desc = "buffer_reset" },
	-- 			{ mode = "n", key = "<leader>gg", handler = "project_diff_preview", desc = "project_diff_preview" },
	-- 			{ mode = "n", key = "<leader>gx", handler = "toggle_diff_preference", desc = "toggle_diff_preference" },
	-- 		},
	-- 	},
	-- },
	{
		"lewis6991/gitsigns.nvim",
		lazy = false,
		config = true,
		keys = {
			{ "<leader>gn", "<Cmd>Gitsigns next_hunk<CR>", desc = "next_hunk" },
			{ "<leader>gp", "<Cmd>Gitsigns prev_hunk<CR>", desc = "prev_hunk" },
		},
	},
}
