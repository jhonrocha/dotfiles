return {
	{
		"tpope/vim-fugitive",
		keys = {
			{ "<leader>gg", "<Cmd>Git<CR>", desc = "Git" },
			{ "<leader>gy", "<Cmd>!gy<CR><CR>", desc = "yank branch" },
			{
				"<leader>gp",
				':Git push origin <c-r>=trim(system("git rev-parse --abbrev-ref HEAD"))<CR>',
				desc = "push",
			},
		},
		lazy = true,
	},
	{
		"sindrets/diffview.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			file_panel = {
				win_config = { position = "left", width = 10, listing_style = "list" },
			},
		},
		keys = {
			{ "<leader>gd", "<Cmd>DiffviewOpen<CR>", desc = "gdiff" },
			{ "<leader>gq", "<Cmd>DiffviewClose<CR>", desc = "close gdiff" },
		},
		lazy = true,
	},
	{
		"lewis6991/gitsigns.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
			current_line_blame_opts = { delay = 300 },
			on_attach = function(bufnr)
				local gs = package.loaded.gitsigns
				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				-- Navigation
				map("n", "]c", function()
					if vim.wo.diff then
						return "]c"
					end
					vim.schedule(function()
						gs.next_hunk()
					end)
					return "<Ignore>"
				end, { expr = true, desc = "next hunk" })
				map("n", "[c", function()
					if vim.wo.diff then
						return "[c"
					end
					vim.schedule(function()
						gs.prev_hunk()
					end)
					return "<Ignore>"
				end, { expr = true, desc = "prev hunk" })
				-- Actions
				map("n", "<leader>gv", gs.preview_hunk, { desc = "preview hunk" })
				map("n", "<leader>gb", function()
					gs.blame_line({ full = true })
				end, { desc = "blame full" })
				map("n", "<leader>gl", gs.toggle_current_line_blame, { desc = "blame line" })
				map("n", "<leader>gt", function()
					gs.diffthis("~")
				end, { desc = "diff this" })
				map("n", "<leader>gs", gs.select_hunk, { desc = "select hunk" })
			end,
		},
	},
	{
		"almo7aya/openingh.nvim",
		config = true,
		keys = {
			{ "<leader>gf", "<Cmd>OpenInGHFileLines<CR>", desc = "open in gh" },
		},
		lazy = true,
	},
}
