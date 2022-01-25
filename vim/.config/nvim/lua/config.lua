-- Default theme
local theme = "catppuccin"
-- Using light theme on the morning
local t = os.date("*t")
if t.hour < 10 and t.hour > 6 then
	theme = "github_light"
end

-- Line
require("lualine").setup({
	options = { theme },
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "" },
		lualine_c = { { "filename", path = 1 } },
		lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
})

-- Theme
require("github-theme").setup({
	theme_style = "light",
})

require("catppuccin").setup({
	-- transparent_background = true,
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
vim.g.nvim_tree_quit_on_open = 1
require("nvim-tree").setup({
	git = {
		enable = true,
		ignore = false,
		timeout = 500,
	},
	view = {
		side = "left",
		-- height = "10%"
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
		{ name = "vsnip" },
		{ name = "nvim_lsp" },
		{ name = "nvim_lua" },
		{ name = "path" },
		{ name = "buffer" },
	},
	formatting = { format = lspkind.cmp_format() },
	experimental = { ghost_text = true },
})

-- null-ls
local null_ls = require("null-ls")

-- register any number of sources simultaneously
local sources = {
	null_ls.builtins.diagnostics.eslint_d,
	null_ls.builtins.formatting.eslint_d,
	null_ls.builtins.formatting.prettier_standard.with({
		command = "standard",
		args = { "--fix", "--stdin" },
	}),
	null_ls.builtins.formatting.stylua,
	null_ls.builtins.formatting.black,
	null_ls.builtins.diagnostics.pylint,
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
	highlight = { enable = true },
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
		-- file_previewer = require('telescope.previewers').cat.new,
		file_ignore_patterns = { "node_modules", ".git/" },
		sorting_strategy = "ascending",
		-- layout_strategy = "horizontal",
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
			sort_lastused = true,
			mappings = { i = { ["<c-d>"] = "delete_buffer" } },
		},
		find_files = {
			hidden = true,
			find_command = {
				"fd",
				"--type",
				"f",
				"--hidden",
				"--follow",
				-- "--no-ignore-vcs",
				-- "--exclude",
				-- ".git/",
				-- "--exclude",
				-- "node_modules",
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
