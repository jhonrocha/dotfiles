return {
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
					-- preview = { hide_on_startup = true },
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
						no_ignore = true,
						previewer = false,
					},
					find_files = {
						hidden = true,
						previewer = false,
						find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
					},
					live_grep = {
						hidden = true,
						no_ignore = true,
						previewer = false,
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
				desc = "buffers",
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
				desc = "buffer search",
			},
			{
				"<leader>fW",
				function()
					require("telescope.builtin").grep_string()
				end,
				desc = "hover grep",
			},
			{
				"<leader>fw",
				function()
					require("telescope.builtin").live_grep()
				end,
				desc = "word(grep)",
			},
			{
				"<leader>fgc",
				function()
					require("telescope.builtin").git_commits()
				end,
				desc = "commits",
			},
			{
				"<leader>fgh",
				function()
					require("telescope.builtin").git_bcommits()
				end,
				desc = "file commits",
			},
			{
				"<leader>fgb",
				function()
					require("telescope.builtin").git_branches()
				end,
				desc = "branches",
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
			{
				"<leader>fc",
				function()
					require("telescope.builtin").resume()
				end,
				desc = "current find",
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
