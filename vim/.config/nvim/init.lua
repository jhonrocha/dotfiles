-- To get this config:
-- curl --create-dirs https://raw.githubusercontent.com/jhonrocha/dotfiles/master/vim/.config/nvim/init.lua -o ~/.config/nvim/init.lua
----------------------------------------
------------ Plugin Manager ------------
----------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Remap space as leader key
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

----------------------------------------
--------------- PLUGINS ----------------
----------------------------------------
-- Supported Language Servers
local ls_installed = {
	"bashls",
	"gopls",
	"jedi_language_server",
	"jsonls",
	"lua_ls",
	"tsserver",
	"yamlls",
	"terraformls",
	"groovyls",
	"rust_analyzer",
}

require("lazy").setup({
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.g.tokyonight_colors = { border = "orange" }
			vim.cmd([[colorscheme tokyonight-night]])
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
	{
		"tpope/vim-fugitive",
		keys = {
			{ "<leader>gg", "<Cmd>Git<CR>", { desc = "Git" } },
			{ "<leader>gy", "<Cmd>!gy<CR><CR>", { desc = "yank branch" } },
			{
				"<leader>gp",
				':Git push origin <c-r>=trim(system("git rev-parse --abbrev-ref HEAD"))<CR>',
				{ desc = "push" },
			},
		},
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
			{ "<leader>gd", "<Cmd>DiffviewOpen<CR>", { desc = "gdiff" } },
			{ "<leader>gq", "<Cmd>DiffviewClose<CR>", { desc = "close gdiff" } },
		},
	},
	{ "numToStr/Comment.nvim", config = true },
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local actions = require("telescope.actions")
			local action_layout = require("telescope.actions.layout")
			require("telescope").setup({
				defaults = {
					vimgrep_arguments = {
						"rg",
						"--hidden",
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--glob=!.git",
						"--column",
						"--smart-case",
					},
					border = true,
					borderchars = {
						prompt = { "─", " ", " ", " ", "─", "─", " ", " " },
						results = { " " },
						preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
					},
					dynamic_preview_title = false,
					preview = { hide_on_startup = true },
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
					},
					find_files = {
						hidden = true,
						file_ignore_patterns = { "node_modules", ".git/" },
						find_command = {
							"fd",
							"--type",
							"f",
							"--hidden",
							"--follow",
							"--no-ignore-vcs",
							"--exclude",
							".git/",
							"--exclude",
							"node_modules",
						},
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
				{ desc = "open bufs" },
			},
			{
				"<leader><space>",
				function()
					require("telescope.builtin").find_files()
				end,
				{ desc = "go to" },
			},
			{
				"<leader>ff",
				function()
					require("telescope.builtin").current_buffer_fuzzy_find()
				end,
				{ desc = "search" },
			},
			{
				"<leader>fW",
				function()
					require("telescope.builtin").grep_string()
				end,
				{ desc = "grep hover" },
			},
			{
				"<leader>fw",
				function()
					require("telescope.builtin").live_grep()
				end,
				{ desc = "grep all" },
			},
			{
				"<leader>fgc",
				function()
					require("telescope.builtin").git_commits()
				end,
				{ desc = "git commits" },
			},
			{
				"<leader>fgb",
				function()
					require("telescope.builtin").git_branches()
				end,
				{ desc = "git branches" },
			},
			{
				"<leader>o",
				function()
					require("telescope.builtin").oldfiles()
				end,
				{ desc = "recent files" },
			},
			{
				"<leader>fr",
				function()
					require("telescope.builtin").lsp_references()
				end,
				{ desc = "lsp_references" },
			},
			{
				"<leader>fi",
				function()
					require("telescope.builtin").lsp_implementations()
				end,
				{ desc = "lsp_implementations" },
			},
		},
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
		dependencies = "nvim-telescope/telescope.nvim",
		config = function()
			require("telescope").load_extension("fzf")
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons", lazy = true },
		opts = {
			options = { globalstatus = true },
			sections = {
				lualine_a = { "mode" },
				lualine_b = { { "filename", path = 1 }, "diff", "diagnostics" },
				lualine_c = { "branch" },
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
			renderer = { highlight_opened_files = "icon" },
		},
		keys = {
			{ "<leader>d", "<Cmd>NvimTreeFindFileToggle<CR>", desc = "file drawer" },
		},
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		opts = { char = "┊", space_char_blankline = " " },
	}, -- Add marks to the left bar
	{ "chentoast/marks.nvim", config = true }, -- Add git related info in the signs columns and popups
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
				end, { expr = true })
				map("n", "[c", function()
					if vim.wo.diff then
						return "[c"
					end
					vim.schedule(function()
						gs.prev_hunk()
					end)
					return "<Ignore>"
				end, { expr = true })
				-- Actions
				map("n", "<leader>gv", gs.preview_hunk)
				map("n", "<leader>gb", function()
					gs.blame_line({ full = true })
				end)
				map("n", "<leader>gl", gs.toggle_current_line_blame)
				map("n", "<leader>gt", function()
					gs.diffthis("~")
				end)
				map("n", "<leader>gs", gs.select_hunk)
			end,
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			-- Treesitter configuration
			-- Parsers must be installed manually via :TSInstall
			require("nvim-treesitter.configs").setup({
				ensure_installed = "all",
				ignore_install = { "norg", "phpdoc" },
				highlight = {
					enable = true, -- false will disable the whole extension
					disable = { "sql" },
				},
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "gnn",
						node_incremental = "grn",
						scope_incremental = "grc",
						node_decremental = "grm",
					},
				},
				indent = { enable = true },
			})
			local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()
			parser_configs.hcl = { filetype = "hcl", "terraform" }
		end,
	},
	{ "windwp/nvim-autopairs", config = true },
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			dependencies = { "williamboman/mason.nvim", config = true },
			opts = { ensure_installed = ls_installed, automatic_installation = true },
		},
		config = function()
			for _, server_name in pairs(ls_installed) do
				local opts = {}
				if server_name == "lua_ls" then
					opts.settings = {
						Lua = { diagnostics = { globals = { "vim" } }, hint = { enable = true } },
					}
				elseif server_name == "tsserver" then
					opts.on_attach = function(client)
						client.server_capabilities.document_formatting = false
					end
				elseif server_name == "gopls" then
					opts.init_options = { buildFlags = { "-tags=integration" } }
				end
				opts.capabilities = require("cmp_nvim_lsp").default_capabilities()
				require("lspconfig")[server_name].setup(opts)
			end
		end,
		keys = {
			{ "<leader>cD", vim.lsp.buf.declaration, { desc = "lsp declaration" } },
			{ "<leader>cd", vim.lsp.buf.definition, { desc = "lsp definition" } },
			{ "K", vim.lsp.buf.hover, { desc = "lsp hover" } },
			{ "<leader>ci", vim.lsp.buf.implementation, { desc = "lsp implementation" } },
			{ "<C-k>", vim.lsp.buf.signature_help, { desc = "lsp signature_help" } },
			{ "<leader>D", vim.lsp.buf.type_definition, { desc = "lsp type" } },
			{ "<leader>cw", vim.lsp.buf.rename, { desc = "lsp rename" } },
			{ "<leader>cr", vim.lsp.buf.references, { desc = "lsp references" } },
			{ "<leader>ca", vim.lsp.buf.code_action, { desc = "code action" } },
			{ "<leader>cf", vim.lsp.buf.format, { desc = "code format" } },
		},
	},
	{
		"lvimuser/lsp-inlayhints.nvim",
		dependencies = "neovim/nvim-lspconfig",
		config = function()
			require("lsp-inlayhints").setup({ inlay_hints = { highlight = "Comment" } })
			vim.api.nvim_create_augroup("LspAttach_inlayhints", {})
			vim.api.nvim_create_autocmd("LspAttach", {
				group = "LspAttach_inlayhints",
				callback = function(args)
					if not (args.data and args.data.client_id) then
						return
					end
					local bufnr = args.buf
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					require("lsp-inlayhints").on_attach(client, bufnr)
				end,
			})
		end,
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		config = function()
			local null_ls = require("null-ls")
			null_ls.setup({
				sources = {
					null_ls.builtins.diagnostics.eslint.with({
						condition = function(utils)
							return utils.root_has_file({
								".eslintrc.js",
								".eslintrc.cjs",
								".eslintrc.yaml",
								".eslintrc.yml",
								".eslintrc.json",
							})
						end,
					}),
					null_ls.builtins.formatting.prettier,
					null_ls.builtins.formatting.stylua,
					null_ls.builtins.formatting.black.with({ prefer_local = "venv/bin" }),
					null_ls.builtins.diagnostics.pylint.with({ prefer_local = "venv/bin" }),
					null_ls.builtins.diagnostics.staticcheck,
					null_ls.builtins.formatting.shfmt,
					null_ls.builtins.formatting.rustfmt,
				},
			})
			local _border = "single"
			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = _border })
			vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = _border })
			vim.diagnostic.config({ float = { border = _border }, virtual_text = false })
		end,
	},
	{
		"L3MON4D3/LuaSnip", -- Snippets plugin
		dependencies = "rafamadriz/friendly-snippets",
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
			"L3MON4D3/LuaSnip",
		},
		config = function()
			local luasnip = require("luasnip")
			require("luasnip.loaders.from_vscode").lazy_load()
			-- nvim-cmp setup
			local cmp = require("cmp")
			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-d>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-j>"] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
						select = true,
					}),
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

			-- LuaSnip
			vim.keymap.set({ "s", "i" }, "<Tab>", function()
				if luasnip.expand_or_jumpable() then
					luasnip.expand_or_jump()
				else
					vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
				end
			end)

			vim.keymap.set({ "s", "i" }, "<S-Tab>", function()
				if luasnip.jumpable(-1) then
					luasnip.jump(-1)
				else
					vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<S-Tab>", true, false, true), "n", false)
				end
			end)
		end,
	},
}, {
	defaults = {
		lazy = true,
	},
})

----------------------------------------
---------------- SETUP -----------------
----------------------------------------
-- Clipboard
vim.opt.clipboard = "unnamedplus"
-- Make line numbers default
vim.wo.number = true
-- Enable mouse mode
vim.o.mouse = "a"
-- Enable break indent
vim.o.breakindent = true
-- Save undo history
vim.opt.undofile = true
-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true
-- Tab size
vim.o.expandtab = 2
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
-- Split right
vim.o.splitright = true
-- Decrease update time
vim.o.updatetime = 250
-- Folding
vim.o.foldmethod = "expr"
-- Set colorscheme
vim.o.termguicolors = true
-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})
-- A Jenkinsfile is a Groovy file
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
	pattern = { "Jenkinsfile*" },
	command = "setf groovy",
})

----------------------------------------
----------------- MAPS -----------------
----------------------------------------
-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true, desc = "TODO" })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true, desc = "TODO" })

-- My Maps
vim.keymap.set("n", "<leader>fs", "<Cmd>update!<CR>")
vim.keymap.set("n", "<leader>fk", "<Cmd>bd<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
vim.keymap.set("n", "]k", function()
	vim.diagnostic.goto_prev({ float = true })
end)
vim.keymap.set("n", "]j", function()
	vim.diagnostic.goto_next({ float = true })
end)
vim.keymap.set("n", "<leader>cq", vim.diagnostic.setloclist)

-- Buffer navigation
vim.keymap.set("n", "<leader>j", "<Cmd>bn<CR>", { desc = "next buf" })
vim.keymap.set("n", "<leader>k", "<Cmd>bp<CR>", { desc = "prev buf" })
vim.keymap.set("n", "<leader><TAB>", "<C-^>", { desc = "alt buf" })
vim.keymap.set("n", "<leader>cp", "<Cmd>let @+=@%<CR>", { desc = "alt buf" })
vim.keymap.set("n", "<leader>cP", "<Cmd>let @+=expand('%:t')<CR>", { desc = "alt buf" })

-- Replacers
vim.keymap.set("n", "<leader>rr", ":%s//gc<left><left><left>", { desc = "replace all" })
vim.keymap.set("n", "<leader>rb", ":.,$s//gc<left><left><left>", { desc = "replace bellow" })

-- Utilities
vim.keymap.set("v", "<", "<gv", { desc = "indent right" })
vim.keymap.set("v", ">", ">gv", { desc = "indent left" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv")
vim.keymap.set("n", "d", '"vd')
vim.keymap.set("n", "D", '"vD')
vim.keymap.set("n", "x", '"vx')
vim.keymap.set("n", "X", '"vX')
vim.keymap.set("n", "c", '"vc')
vim.keymap.set("n", "C", '"vC')
vim.keymap.set("n", "s", '"vs')
vim.keymap.set("n", "S", '"vS')
-- Original copy paste
vim.keymap.set("n", "<leader>p", '"vp')
vim.keymap.set("n", "<leader>P", '"vP')

-- Clear search
vim.keymap.set("n", "<leader><Esc>", "<Cmd>noh<CR>", { desc = "clear highlight" })

-- Quicklist
vim.keymap.set("n", "<leader>qq", "<Cmd>copen<CR>", { desc = "quick open" })
vim.keymap.set("n", "<leader>qc", "<Cmd>cclose<CR>", { desc = "quick close" })
vim.keymap.set("n", "<leader>qj", "<Cmd>cn<CR>", { desc = "quick next" })
vim.keymap.set("n", "<leader>qk", "<Cmd>cp<CR>", { desc = "quick previous" })
