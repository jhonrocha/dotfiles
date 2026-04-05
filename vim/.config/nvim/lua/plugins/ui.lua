-- local theme = "catppuccin-mocha"
-- local theme = "eldritch"
-- local theme = "kanagawa-wave"
local theme = "tokyonight-night"
local ui = {
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		enabled = true,
		config = function()
			-- vim.g.gruvbox_material_background = "dark"
			vim.cmd.colorscheme(theme)
		end,
	},
	{
		"catppuccin/nvim",
		lazy = false,
		enabled = false,
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
		dependencies = {
			"folke/noice.nvim",
			"nvim-tree/nvim-web-devicons",
		},
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
				lualine_x = { "searchcount", "diff", "filetype" },
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
			winbar = {},
			inactive_winbar = {},
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
	{
		"Bekaboo/dropbar.nvim",
		config = function()
			-- require("dropbar").setup();
			-- local dropbar_api = require("dropbar.api")
			-- vim.keymap.set("n", "<Leader>;", dropbar_api.pick, { desc = "Pick symbols in winbar" })
			-- vim.keymap.set("n", "[;", dropbar_api.goto_context_start, { desc = "Go to start of current context" })
			-- vim.keymap.set("n", "];", dropbar_api.select_next_context, { desc = "Select next context" })
		end,
	},
}
return ui
