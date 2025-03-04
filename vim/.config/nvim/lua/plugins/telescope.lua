local telescope = {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local actions = require("telescope.actions")
			local action_layout = require("telescope.actions.layout")
			local telescopeConfig = require("telescope.config")
			-- Clone the default Telescope configuration
			local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }
			-- I want to search in hidden/dot files.
			table.insert(vimgrep_arguments, "--hidden")
			-- I don't want to search in the `.git` directory.
			table.insert(vimgrep_arguments, "--glob")
			table.insert(vimgrep_arguments, "!**/.git/*")
			require("telescope").setup({
				defaults = {
					vimgrep_arguments = vimgrep_arguments,
					border = true,
					borderchars = {
						prompt = { "─", " ", " ", " ", "─", "─", " ", " " },
						results = { " " },
						preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
					},
					dynamic_preview_title = false,
					sorting_strategy = "ascending",
					layout_strategy = "horizontal",
					layout_config = {
						prompt_position = "top",
						horizontal = {
							width = 0.95,
							height = 0.95,
							preview_cutoff = 0,
						},
						bottom_pane = {
							height = 0.4,
							preview_cutoff = 0,
						},
						vertical = {
							mirror = false,
							preview_cutoff = 0,
							width = 0.95,
							height = 0.95,
						},
					},
					mappings = {
						i = {
							["<esc>"] = actions.close,
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
						layout_strategy = "bottom_pane",
						hidden = true,
						sort_lastused = true,
						mappings = { i = { ["<c-d>"] = "delete_buffer" } },
						no_ignore = true,
						previewer = false,
					},
					find_files = {
						layout_strategy = "bottom_pane",
						hidden = true,
						previewer = false,
						find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
					},
					live_grep = {
						layout_strategy = "vertical",
						hidden = true,
						no_ignore = true,
					},
					current_buffer_fuzzy_find = {
						previewer = false,
					},
				},
			})
		end,
		keys = {
			{ "<leader>,", "<cmd>Telescope buffers<CR>", desc = "buffers" },
			{ "<leader><space>", "<cmd>Telescope find_files<cr>", desc = "go to" },
			{ "<leader>ff", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "buffer search" },
			{ "<leader>fW", "<cmd>Telescope grep_string<cr>", desc = "hover grep" },
			{ "<leader>fw", "<cmd>Telescope live_grep<cr>", desc = "word(grep)" },
			{ "<leader>fgc", "<cmd>Telescope git_commits<cr>", desc = "commits" },
			{ "<leader>fgh", "<cmd>Telescope git_bcommits<cr>", desc = "file commits" },
			{ "<leader>fgb", "<cmd>Telescope git_branches<cr>", desc = "branches" },
			{ "<leader>fr", "<cmd>Telescope lsp_references<cr>", desc = "lsp_references" },
			{ "<leader>fi", "<cmd>Telescope lsp_implementations<cr>", desc = "lsp_implementations" },
			{ "<leader>fc", "<cmd>Telescope resume<cr>", desc = "current find" },
		},
		lazy = true,
	},
}

return {}
