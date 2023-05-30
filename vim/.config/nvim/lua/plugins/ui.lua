local ui = {
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
				lualine_c = { { "filename", path = 1 }, "diff", "diagnostics" },
				lualine_x = { "encoding", "fileformat", "filetype" },
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
			extensions = { "quickfix", "nvim-tree" },
		},
	},
	{
		-- "nvim-tree/nvim-tree.lua",
		-- dependencies = { "nvim-tree/nvim-web-devicons" },
		-- opts = {
		-- 	actions = { open_file = { quit_on_open = true } },
		-- 	update_focused_file = { enable = true },
		-- 	renderer = { highlight_opened_files = "name" },
		-- 	git = { ignore = false },
		-- },
		-- keys = {
		-- 	{ "<leader>d", "<Cmd>NvimTreeFindFileToggle<CR>", desc = "file drawer" },
		-- },
		-- cmd = "NvimTreeOpen",
		-- lazy = true,
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		opts = {
			default_component_configs = {
				icon = {
					folder_empty = "󰜌",
					folder_empty_open = "󰜌",
				},
				git_status = {
					symbols = {
						renamed = "󰁕",
						unstaged = "✗",
					},
				},
			},
			document_symbols = {
				kinds = {
					File = { icon = "󰈙", hl = "Tag" },
					Namespace = { icon = "󰌗", hl = "Include" },
					Package = { icon = "󰏖", hl = "Label" },
					Class = { icon = "󰌗", hl = "Include" },
					Property = { icon = "󰆧", hl = "@property" },
					Enum = { icon = "󰒻", hl = "@number" },
					Function = { icon = "󰊕", hl = "Function" },
					String = { icon = "󰀬", hl = "String" },
					Number = { icon = "󰎠", hl = "Number" },
					Array = { icon = "󰅪", hl = "Type" },
					Object = { icon = "󰅩", hl = "Type" },
					Key = { icon = "󰌋", hl = "" },
					Struct = { icon = "󰌗", hl = "Type" },
					Operator = { icon = "󰆕", hl = "Operator" },
					TypeParameter = { icon = "󰊄", hl = "Type" },
					StaticMethod = { icon = "󰠄 ", hl = "Function" },
				},
			},
      filesystem = {
        filtered_items = {
          visible = true
        },
        follow_current_file = true
      },
			source_selector = {
				winbar = true,
				sources = {
					{ source = "filesystem", display_name = " 󰉓 Files " },
					{ source = "git_status", display_name = " 󰊢 Git " },
					{ source = "buffers", display_name = " 󰈙 Buffers " },
				},
			},
		},
		keys = {
			{ "<leader>d", "<Cmd>NeoTreeFocusToggle<CR>", desc = "file drawer" },
		},
		cmd = "NeoTreeFocusToggle",
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
				f = { name = "file", g = { name = "git" } },
				g = { name = "git" },
				i = { name = "debug" },
				q = { name = "quicklist" },
				r = { name = "replace" },
			}, { prefix = "<leader>" })
		end,
	},
	{
		"glepnir/dashboard-nvim",
		-- event = "VimEnter",
		theme = "doom",
		lazy = true,
		enable = false,
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
return ui
