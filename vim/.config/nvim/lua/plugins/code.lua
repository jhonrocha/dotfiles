local code = {
	{ "numToStr/Comment.nvim", config = true },
	{
		"ggandor/leap.nvim",
		keys = {
			{
				"s",
				function()
					require("leap").leap({ target_windows = { vim.fn.win_getid() } })
				end,
				{ desc = "leap" },
			},
		},
	},
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local harpoon = require("harpoon")
			-- REQUIRED
			harpoon:setup()
			-- REQUIRED

			vim.keymap.set("n", "<leader>a", function()
				harpoon:list():append()
			end, { desc = "harpoon add" })
			vim.keymap.set("n", "<leader>ll", function()
				harpoon.ui:toggle_quick_menu(harpoon:list())
			end, { desc = "harpoon list" })

			vim.keymap.set("n", "<leader>la", function()
				harpoon:list():select(1)
			end, { desc = "harpoon 1" })
			vim.keymap.set("n", "<leader>ls", function()
				harpoon:list():select(2)
			end, { desc = "harpoon 2" })
			vim.keymap.set("n", "<leader>ld", function()
				harpoon:list():select(3)
			end, { desc = "harpoon 3" })
			vim.keymap.set("n", "<leader>lf", function()
				harpoon:list():select(4)
			end, { desc = "harpoon 4" })
			vim.keymap.set("n", "<leader>lg", function()
				harpoon:list():select(5)
			end, { desc = "harpoon 5" })
			vim.keymap.set("n", "<leader>lh", function()
				harpoon:list():select(6)
			end, { desc = "harpoon 6" })
			vim.keymap.set("n", "<leader>lj", function()
				harpoon:list():select(7)
			end, { desc = "harpoon 7" })
			vim.keymap.set("n", "<leader>lk", function()
				harpoon:list():select(8)
			end, { desc = "harpoon 8" })

			-- Toggle previous & next buffers stored within Harpoon list
			vim.keymap.set("n", "<leader>lj", function()
				harpoon:list():prev()
			end, { desc = "harpoon prev" })
			vim.keymap.set("n", "<leader>lk", function()
				harpoon:list():next()
			end, { desc = "harpoon next" })
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			-- Treesitter configuration
			-- Parsers must be installed manually via :TSInstall
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"bash",
					"c",
					"cpp",
					"css",
					"go",
					"gomod",
					"html",
					"java",
					"javascript",
					"jsdoc",
					"json",
					"lua",
					"python",
					"query",
					"rust",
					"tsx",
					"typescript",
					"vim",
					"vimdoc",
				},
				highlight = {
					enable = true, -- false will disable the whole extension
				},
				indent = { enable = true },
			})
			-- local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()
			-- parser_configs.hcl = { filetype = "hcl", "terraform" }
		end,
	},
	{ "windwp/nvim-autopairs", config = true },
	{
		"L3MON4D3/LuaSnip",
		-- follow latest release.
		version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
		-- install jsregexp (optional!).
		build = "make install_jsregexp",
		dependencies = "rafamadriz/friendly-snippets",
		keys = {
			{
				"<C-J>",
				function()
					require("luasnip").jump(-1)
				end,
				mode = "i",
				desc = "jump",
			},
			{
				"<C-L>",
				function()
					require("luasnip").jump(1)
				end,
				mode = "i",
				desc = "jumpback",
			},
		},
	},
	{
		"folke/trouble.nvim",
		config = true,
		lazy = true,
		keys = {
			{ "<leader>t", "<Cmd>TroubleToggle<CR>", desc = "trouble" },
		},
	},
	{
		"saadparwaiz1/cmp_luasnip",
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lua",
			"saadparwaiz1/cmp_luasnip",
			"neovim/nvim-lspconfig",
		},
		config = function()
			-- nvim-cmp setup
			local cmp = require("cmp")
			cmp.setup({
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-d>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
				}),
				sources = {
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "nvim_lua" },
					{ name = "path" },
					{ name = "buffer" },
				},
				experimental = { ghost_text = true },
				formatting = {
					format = function(_, vim_item)
						vim_item.abbr = string.sub(vim_item.abbr, 1, 20)
						return vim_item
					end,
				},
			})
		end,
	},
	{
		-- Folding!
		"kevinhwang91/nvim-ufo",
		lazy = true,
		dependencies = {
			"kevinhwang91/promise-async",
			"nvim-treesitter/nvim-treesitter",
		},
		config = {
			provider_selector = function()
				return { "treesitter", "indent" }
			end,
		},
		keys = {
			{
				"zR",
				function()
					require("ufo").openAllFolds()
				end,
				desc = "open all",
			},
			{
				"zM",
				function()
					require("ufo").closeAllFolds()
				end,
				desc = "close all",
			},
		},
	},
	{
		"mrcjkb/rustaceanvim",
		version = "^4", -- Recommended
		ft = { "rust" },
	},
}
return code
