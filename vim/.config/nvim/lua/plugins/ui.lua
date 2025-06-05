-- local theme = "catppuccin-macchiato"
-- local theme = "eldritch"
local theme = "kanagawa-wave"
local ui = {
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		enable = true,
		config = function()
			-- vim.g.gruvbox_material_background = "dark"
			vim.cmd.colorscheme(theme)
		end,
	},
	{
		"catppuccin/nvim",
		lazy = false,
		enable = false,
		name = "catppuccin",
		priority = 1001,
		opts = {
			-- transparent_background = false,
			integrations = {
				leap = true,
				nvimtree = true,
				blink_cmp = true,
				treesitter = true,
				mason = true,
				snacks = true,
			},
		},
	},
	{
		"sainnhe/gruvbox-material",
		lazy = false,
		priority = 1002,
		config = function()
			-- Optionally configure and load the colorscheme
			-- directly inside the plugin declaration.
			vim.g.gruvbox_material_enable_italic = true
			vim.g.gruvbox_material_background = "dark"
			vim.g.gruvbox_material_better_performance = 1
		end,
	},
	{
		"eldritch-theme/eldritch.nvim",
		lazy = false,
		priority = 1005,
		opts = {},
	},
	{
		"rebelot/kanagawa.nvim",
		lazy = false,
		priority = 1006,
		opts = {
			transparent = false, -- do not set background color
		},
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons", lazy = true },
		opts = {
			options = {
				globalstatus = true,
				section_separators = { left = "", right = "" },
				theme,
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
				{ "<leader>g", group = "git" },
				{ "<leader>i", group = "debug" },
				{ "<leader>q", group = "quicklist" },
				{ "<leader>r", group = "replace" },
				{ "<leader>y", group = "yank" },
			})
		end,
	},
	{
		"nvim-tree/nvim-tree.lua",
		opts = {
			sort_by = "case_sensitive",
			view = { width = 30 },
			renderer = {
				group_empty = false,
				highlight_opened_files = "icon",
			},
			-- actions = { open_file = { quit_on_open = true } },
			update_focused_file = { enable = true },
			git = { ignore = false },
		},
		keys = {
			{ "<leader>d", "<Cmd>NvimTreeFindFileToggle<CR>", desc = "file drawer" },
		},
		lazy = true,
	},
}
return ui
