local ui = {
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
    enable = true,
		config = function()
			require("tokyonight").setup()
			vim.cmd.colorscheme("tokyonight-moon")
		end,
	},
	-- {
	-- 	"catppuccin/nvim",
	-- 	lazy = false,
	-- 	enable = false,
	-- 	priority = 1000,
	-- 	name = "catppuccin",
	-- 	config = function()
	-- 		require("catppuccin").setup({
	-- 			transparent_background = false,
	-- 			integrations = {
	-- 				leap = true,
	-- 				nvimtree = true,
	-- 				blink_cmp = true,
	-- 				treesitter = true,
	-- 				mason = true,
	-- 				snacks = true,
	-- 			},
	-- 		})
	-- 		vim.cmd.colorscheme("catppuccin-mocha")
	-- 	end,
	-- },
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons", lazy = true },
		opts = {
			options = {
				globalstatus = true,
				section_separators = { left = "", right = "" },
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { { "buffers", show_filename_only = true } },
				lualine_c = {},
				lualine_x = { "filetype" },
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
			extensions = { "quickfix", "nvim-tree" },
		},
	},
	-- {
	-- 	"nvim-tree/nvim-tree.lua",
	-- 	opts = {
	-- 		sort_by = "case_sensitive",
	-- 		view = { width = 30 },
	-- 		renderer = {
	-- 			group_empty = false,
	-- 			highlight_opened_files = "icon",
	-- 		},
	-- 		-- actions = { open_file = { quit_on_open = true } },
	-- 		update_focused_file = { enable = true },
	-- 		git = { ignore = false },
	-- 	},
	-- 	keys = {
	-- 		{ "<leader>b", "<Cmd>NvimTreeFindFileToggle<CR>", desc = "file drawer" },
	-- 	},
	-- 	lazy = true,
	-- },
	{
		"folke/which-key.nvim",
		config = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
			require("which-key").setup({
				delay = 500,
			})
			local wk = require("which-key")
			wk.add({
				{ "<leader>c", group = "code" },
				{ "<leader>f", group = "finder" },
				{ "<leader>s", group = "search" },
				{ "<leader>g", group = "git" },
				{ "<leader>i", group = "debug" },
				{ "<leader>q", group = "quicklist" },
				{ "<leader>r", group = "replace" },
				{ "<leader>l", group = "leetcode" },
			})
		end,
	},
}
return ui
