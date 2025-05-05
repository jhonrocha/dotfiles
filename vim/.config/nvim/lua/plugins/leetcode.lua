local leetcode = {
	{
		"kawre/leetcode.nvim",
		build = ":TSUpdate html", -- if you have `nvim-treesitter` installed
		lazy = true,
		dependencies = {
			"nvim-telescope/telescope.nvim",
			-- "ibhagwan/fzf-lua",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
		},
		opts = {
			lang = "python3", -- configuration goes here
			picker = { provider = "telescope" },
			injector = { ---@type table<lc.lang, lc.inject>
				["python"] = {
					before = "from typing import List",
				},
				["python3"] = {
					before = "from typing import List",
				},
			},
		},
		keys = {
			{ "<leader>ll", "<Cmd>Leet<CR>", desc = "leet" },
			{ "<leader>le", "<Cmd>Leet random difficulty=easy status=todo<CR>", desc = "easy" },
			{ "<leader>lm", "<Cmd>Leet random difficulty=medium status=todo<CR>", desc = "medium" },
			{ "<leader>lh", "<Cmd>Leet random difficulty=hard status=todo<CR>", desc = "hard" },
			{ "<leader>lE", "<Cmd>Leet list difficulty=easy status=todo<CR>", desc = "easy" },
			{ "<leader>lM", "<Cmd>Leet list difficulty=medium status=todo<CR>", desc = "medium" },
			{ "<leader>lH", "<Cmd>Leet list difficulty=hard status=todo<CR>", desc = "hard" },
			{ "<leader>lr", "<Cmd>Leet run<CR>", desc = "run" },
			{ "<leader>ls", "<Cmd>Leet submit<CR>", desc = "submit" },
			{ "<leader>lo", "<Cmd>Leet open<CR>", desc = "open" },
		},
	},
}

return {}
