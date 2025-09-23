local theme = "catppuccin-mocha"
-- local theme = "eldritch"
-- local theme = "kanagawa-wave"
-- local theme = "tokyonight-night"
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
	-- lazy.nvim
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			messages = {
				view_search = false,
			},
		},
		dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons", lazy = true },
		opts = {
			options = {
				globalstatus = true,
				-- section_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				component_separators = "",
				theme,
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { { "filename", path = 1 } },
				lualine_c = { "diagnostics" },
				lualine_d = {
					{
						require("noice").api.statusline.mode.get,
						cond = require("noice").api.statusline.mode.has,

						color = { fg = "#ff9e64" },
					},
				},
				-- lualine_x = { "encoding", "fileformat", "filetype" },
				lualine_x = { "searchcount", "diff", "filetype" },
				-- lualine_b = { "branch", "diff", "diagnostics" },
				-- lualine_b = {},
				-- lualine_c = { { "buffers", show_filename_only = true } },
				-- lualine_c = { "location" },
				-- lualine_x = { "encoding", "fileformat", "filetype" },
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
			winbar = {
				lualine_a = {},
				-- lualine_b = { { "filetype", icon_only = true } },
				lualine_b = {},
				lualine_c = {
					{ "filetype", icon_only = true, padding = { left = 1, right = 0 } },
					{ "filename", path = 1, padding = { left = 0 }, shorting_target = 10 },
				},
				lualine_x = {},
				lualine_y = {},
				lualine_z = {},
			},
			inactive_winbar = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = {
					{ "filetype", icon_only = true, padding = { left = 1, right = 0 } },
					{ "filename", path = 1, padding = { left = 0 }, shorting_target = 10 },
				},
				lualine_x = {},
				lualine_y = {},
				lualine_z = {},
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
