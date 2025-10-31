local snacks = {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		dependencies = {},
		---@type snacks.Config
		opts = {
			explorer = { enabled = false },
			bigfile = { enabled = true, line_length = 100000 },
			bufdelete = { enable = true },
			dashboard = {
				enabled = true,
				sections = {
					{ section = "header" },
					{ section = "keys", gap = 1, padding = 1 },
					{ section = "startup" },
				},
			},
			git = { enabled = true },
			gitbrowse = { enabled = true },
			indent = { enabled = true, animate = { enabled = false } },
			input = { enabled = true },
			lazygit = { enabled = true },
			notifier = { enabled = true },
			picker = {
				enabled = true,
				win = {
					input = {
						keys = {
							["<Esc>"] = { "close", mode = "i" },
							["<c-d>"] = { "bufdelete", mode = { "n", "i" } },
							["<c-p>"] = { "toggle_preview", mode = { "i", "n" } },
						},
					},
				},
				sources = {
					explorer = {
						cmd = "fd",
						diagnostics = false,
						diagnostics_open = false,
						hidden = true,
						follow_file = true,
						git_status = false,
						git_status_open = false,
						git_untracked = false,
						jump = { close = false },
						-- matcher = { sort_empty = false, fuzzy = true },
						win = { input = { keys = { ["<Esc>"] = "cancel" } } },
						layout = {
							hidden = { "input" },
							layout = {
								-- width = 30,
								min_width = 30,
							},
						},
					},
				},
				layout = { preset = "ivy" },
			},
			quickfile = { enabled = true },
			scratch = {
				enabled = true,
				filekey = {
					cwd = true,
					branch = false,
					count = false,
				},
			},
			scroll = { enabled = true, animate = { duration = { step = 15, total = 100 } } },
			statuscolumn = { enabled = true },
			words = { enabled = false },
		},
		keys = {
			-- { "<leader>d",       function() Snacks.explorer() end,                                                                    desc = "File Explorer" },
			{ "<leader>fk", function() Snacks.bufdelete() end, desc = "file kill" },
			{ "<leader>fm", function() Snacks.notifier.show_history() end, desc = "list messages" },
			-- Fuzzy Find
			{ "<leader>,", function() Snacks.picker.buffers({ layout = { preview = false } }) end, desc = "Buffers" },
			{ "<leader>:", function() Snacks.picker.command_history() end, desc = "Command History" },
			{ "<leader><space>", function() Snacks.picker.files({ hidden = true, layout = { preview = false } }) end, desc = "Find Files" },
			{ "<leader>fr", function() Snacks.picker.resume() end, desc = "Resume" },
			-- find
			{ "<leader>ff", function() Snacks.picker.files({ hidden = true, ignored = true, layout = { preview = false } }) end, desc = "Find Files+" },
			{ "<leader>fg", function() Snacks.picker.git_files() end, desc = "Find Git Files" },
			{ "<leader>fR", function() Snacks.picker.recent() end, desc = "Recent" },
			-- git
			{ "<leader>go", function() Snacks.gitbrowse({ branch = "development" }) end, desc = "browser" },
			{ "<leader>gO", function() Snacks.gitbrowse() end, desc = "browser" },
			{ "<leader>gc", function() Snacks.lazygit() end, desc = "to lazygit" },
			{ "<leader>gl", function() Snacks.lazygit.log() end, desc = "log" },
			{ "<leader>gL", function() Snacks.lazygit.log() end, desc = "log file" },
			{ "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
			-- Grep
			{ "<leader>fl", function() Snacks.picker.lines() end, desc = "Search Lines" },
			{
				"<leader>fw",
				function() Snacks.picker.grep({ hidden = true, exclude = { "test" }, layout = { preset = "default", layout = { width = 0.99 } } }) end,
				desc = "Grep",
			},
			{ "<leader>fW", function() Snacks.picker.grep({ hidden = true, layout = { preset = "default", layout = { width = 0.99 } } }) end, desc = "Grep" },
			-- search
			{ "<leader>f.", function() Snacks.picker.registers() end, desc = "Registers" },
			{ "<leader>fa", function() Snacks.picker.autocmds() end, desc = "Autocmds" },
			{ "<leader>fc", function() Snacks.picker.command_history() end, desc = "Command History" },
			{ "<leader>fC", function() Snacks.picker.commands() end, desc = "Commands" },
			{ "<leader>fd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
			{ "<leader>fh", function() Snacks.picker.help() end, desc = "Help Pages" },
			{ "<leader>fH", function() Snacks.picker.highlights() end, desc = "Highlights" },
			{ "<leader>fj", function() Snacks.picker.jumps() end, desc = "Jumps" },
			{ "<leader>fK", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
			{ "<leader>fL", function() Snacks.picker.loclist() end, desc = "Location List" },
			{ "<leader>fb", function() Snacks.picker.marks({ global = false }) end, desc = "Bookmarks" },
			{ "<leader>fB", function() Snacks.picker.marks() end, desc = "Bookmarks" },
			{ "<leader>fq", function() Snacks.picker.qflist() end, desc = "Quickfix List" },
			{ "<leader>ft", function() Snacks.picker.colorschemes() end, desc = "Themes" },
			{ "<leader>fp", function() Snacks.picker.projects() end, desc = "Projects" },
			-- LSP
			{ "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
			{ "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
			{ "gI", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
			{ "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto Type Definition" },
			{ "<leader>fS", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },
			-- scracth
			{ "<leader>.", function() Snacks.scratch() end, desc = "Scratch" },
			{ "<leader>S", function() Snacks.scratch.select() end, desc = "Scratch List" },
		},
	},
}
return snacks
-- return {}
