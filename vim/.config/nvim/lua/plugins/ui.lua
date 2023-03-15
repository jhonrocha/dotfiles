return {
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.g.tokyonight_colors = { border = "orange" }
			-- vim.cmd.colorscheme("tokyonight-night")
			-- vim.api.nvim_set_hl(0, "@neorg.tags.ranged_verbatim.code_block", { bg = "#002244" })
		end,
	},
	{
		"catppuccin/nvim",
		lazy = false,
		priority = 1000,
		name = "catppuccin",
		config = function()
			require("catppuccin").setup({
				integrations = {
					leap = true,
				},
			})
			vim.cmd.colorscheme("catppuccin-mocha")
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons", lazy = true },
		opts = {
			options = {
				globalstatus = true,
				theme = "catppuccin",
				section_separators = { left = "", right = "" },
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = {},
				lualine_c = { { "filename", path = 1 }, "diff", "diagnostics", "branch" },
				lualine_x = { "encoding", "fileformat", "filetype" },
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
			extensions = { "quickfix", "nvim-tree" },
		},
	},
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			actions = { open_file = { quit_on_open = true } },
			update_focused_file = { enable = true },
			renderer = { highlight_opened_files = "name" },
			git = { ignore = false },
		},
		keys = {
			{ "<leader>d", "<Cmd>NvimTreeFindFileToggle<CR>", desc = "file drawer" },
		},
		cmd = "NvimTreeOpen",
		lazy = true,
	},
	{
		"folke/which-key.nvim",
		config = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
			require("which-key").setup({})
			local wk = require("which-key")
			wk.register({
				c = { name = "code" },
				f = { name = "file" },
				g = { name = "git" },
				i = { name = "debug" },
				q = { name = "quicklist" },
				r = { name = "replace" },
			}, { prefix = "<leader>" })
		end,
	},
	{
		"glepnir/dashboard-nvim",
		event = "VimEnter",
		opts = {
			config = {
				week_header = {
					enable = true,
				},
			},
		},
		dependencies = { { "nvim-tree/nvim-web-devicons" } },
	},
	{ "chentoast/marks.nvim", config = true },
	{ "NvChad/nvim-colorizer.lua", config = true, cmd = "ColorizerToggle" },
}
