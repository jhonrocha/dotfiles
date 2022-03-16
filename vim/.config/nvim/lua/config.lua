-- Default theme
local theme = "catppuccin"
local line_theme = "catppuccin"

-- Line
require("lualine").setup({
	options = { theme = line_theme },
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "" },
		lualine_c = { { "filename", path = 1 } },
		lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
})

require("catppuccin").setup({
	styles = {
		comments = "italic",
		functions = "NONE",
		keywords = "NONE",
		strings = "NONE",
		variables = "NONE",
	},
	integration = {
		nvimtree = {
			enabled = true,
			show_root = true, -- makes the root folder not transparent
		},
	},
})

vim.cmd("colorscheme " .. theme)

-- Git integration
require("gitsigns").setup()

-- TREE
require("nvim-tree").setup({
	auto_close = true,
	git = {
		enable = true,
		ignore = false,
		timeout = 500,
	},
	view = {
		side = "left",
		-- height = "10%"
	},
	actions = {
		open_file = {
			quit_on_open = true,
		},
	},
})

-- Pairs
require("nvim-autopairs").setup({})

-- HTTP
require("rest-nvim").setup({})

-- LSP
local nvim_lsp = require("lspconfig")

-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

-- TS-JS
nvim_lsp.tsserver.setup({
	capabilities = capabilities,
	on_attach = function(client)
		client.resolved_capabilities.document_formatting = false
	end,
})

-- VIM
nvim_lsp.vimls.setup({ capabilities = capabilities })

-- LUA
nvim_lsp.sumneko_lua.setup({
	capabilities = capabilities,
	cmd = { "/usr/bin/lua-language-server", "-E" },
	settings = { Lua = { diagnostics = { globals = { "vim" } } } },
})

-- Python
nvim_lsp.pylsp.setup({ capabilities = capabilities })

-- GOLANG
nvim_lsp.gopls.setup({ capabilities = capabilities })

-- LSP Config
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
	vim.lsp.diagnostic.on_publish_diagnostics,
	{ virtual_text = false }
)

-- COMPLETION
local cmp = require("cmp")
local lspkind = require("lspkind")
cmp.setup({
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)
		end,
	},
	mapping = {
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.close(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
	},
	documentation = {
		-- border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
	},
	sources = {
		{ name = "nvim_lsp" },
		{ name = "nvim_lsp_signature_help" },
		{ name = "nvim_lua" },
		{ name = "path" },
		{ name = "vsnip" },
		{ name = "buffer" },
	},
	formatting = { format = lspkind.cmp_format({ maxwidth = 30 }) },
	experimental = { ghost_text = true },
})

-- null-ls
local null_ls = require("null-ls")

-- register any number of sources simultaneously
local sources = {
	null_ls.builtins.diagnostics.eslint_d,
	null_ls.builtins.formatting.eslint_d,
	null_ls.builtins.formatting.stylua,
	null_ls.builtins.formatting.black,
	null_ls.builtins.diagnostics.pylint,
	null_ls.builtins.diagnostics.staticcheck,
}

null_ls.setup({ sources = sources })
-- RUST
-- rust-tools options
local opts = {
	tools = {
		autoSetHints = true,
		hover_with_actions = true,
	},
	server = {
		settings = { ["rust-analyzer"] = { checkOnSave = { command = "clippy" } } },
	},
}
require("rust-tools").setup(opts)

-- Treesitter
require("nvim-treesitter.configs").setup({
	ensure_installed = "maintained",
	ignore_install = { "norg" },
	highlight = { enable = true },
	tree_docs = {
		enable = true,
		spec_config = {
			jsdoc = {
				slots = {
					["function"] = {
						returns = true,
						export = false,
					},
				},
			},
		},
	},
})

-- Telescope
local actions = require("telescope.actions")
local fb_actions = require("telescope").extensions.file_browser.actions
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
			i = {
				["<c-h>"] = actions.which_key,
				["<c-j>"] = actions.move_selection_next,
				["<c-k>"] = actions.move_selection_previous,
				["<tab>"] = actions.add_selection + actions.move_selection_next,
				["<s-tab>"] = actions.remove_selection + actions.move_selection_previous,
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
	extensions = {
		file_browser = {
			-- theme = "ivy",
			hidden = true,
			mappings = {
				["i"] = {
					-- your custom insert mode mappings
				},
				["n"] = {
					-- your custom normal mode mappings
				},
			},
		},
	},
})

require("telescope").load_extension("file_browser")
