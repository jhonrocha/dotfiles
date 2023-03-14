return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local actions = require("telescope.actions")
			local action_layout = require("telescope.actions.layout")
			require("telescope").setup({
				defaults = {
					vimgrep_arguments = {
						"rg",
						"--hidden",
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--glob=!.git",
						"--glob=!node_modules",
						"--column",
						"--smart-case",
					},
					border = true,
					borderchars = {
						prompt = { "─", " ", " ", " ", "─", "─", " ", " " },
						results = { " " },
						preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
					},
					dynamic_preview_title = false,
					preview = { hide_on_startup = true },
					sorting_strategy = "ascending",
					layout_strategy = "bottom_pane",
					layout_config = {
						bottom_pane = { height = 0.4 },
						horizontal = {
							width = 0.95,
							height = 0.4,
							preview_width = 0.4,
							prompt_position = "top",
							preview_cutoff = 60,
						},
						vertical = { mirror = false },
					},
					mappings = {
						n = { ["<c-c>"] = actions.close },
						i = {
							["<c-h>"] = actions.which_key,
							["<c-j>"] = actions.move_selection_next,
							["<c-k>"] = actions.move_selection_previous,
							["<tab>"] = actions.add_selection + actions.move_selection_next,
							["<s-tab>"] = actions.remove_selection + actions.move_selection_previous,
							["<c-f>"] = action_layout.toggle_preview,
						},
					},
				},
				pickers = {
					buffers = {
						hidden = true,
						sort_lastused = true,
						mappings = { i = { ["<c-d>"] = "delete_buffer" } },
					},
					find_files = {
						hidden = true,
						file_ignore_patterns = { "node_modules", ".git/" },
						find_command = {
							"fd",
							"--type",
							"f",
							"--hidden",
							"--follow",
							"--no-ignore-vcs",
							"--exclude",
							".git/",
							"--exclude",
							"node_modules",
						},
					},
				},
			})
		end,
		keys = {
			{
				"<leader>,",
				function()
					require("telescope.builtin").buffers()
				end,
				desc = "open bufs",
			},
			{
				"<leader><space>",
				function()
					require("telescope.builtin").find_files()
				end,
				desc = "go to",
			},
			{
				"<leader>ff",
				function()
					require("telescope.builtin").current_buffer_fuzzy_find()
				end,
				desc = "search",
			},
			{
				"<leader>fW",
				function()
					require("telescope.builtin").grep_string()
				end,
				desc = "grep hover",
			},
			{
				"<leader>fw",
				function()
					require("telescope.builtin").live_grep()
				end,
				desc = "grep all",
			},
			{
				"<leader>fgc",
				function()
					require("telescope.builtin").git_commits()
				end,
				desc = "git commits",
			},
			{
				"<leader>fgb",
				function()
					require("telescope.builtin").git_branches()
				end,
				desc = "git branches",
			},
			{
				"<leader>o",
				function()
					require("telescope.builtin").oldfiles()
				end,
				desc = "recent files",
			},
			{
				"<leader>fr",
				function()
					require("telescope.builtin").lsp_references()
				end,
				desc = "lsp_references",
			},
			{
				"<leader>fi",
				function()
					require("telescope.builtin").lsp_implementations()
				end,
				desc = "lsp_implementations",
			},
		},
		lazy = true,
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
		dependencies = "nvim-telescope/telescope.nvim",
		config = function()
			require("telescope").load_extension("fzf")
		end,
		lazy = true,
	},
}
