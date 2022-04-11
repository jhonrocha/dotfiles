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

require("catppuccin").setup({})

vim.cmd("colorscheme " .. theme)

-- Git integration
require("gitsigns").setup()

-- TREE
require("nvim-tree").setup({
  git = {
    enable = true,
    ignore = false,
    timeout = 500,
  },
  view = {
    side = "left",
    width = 40,
  },
  actions = {
    open_file = {
      quit_on_open = true,
    },
  },
  update_focused_file = {
    enable = true,
  },
})

-- Pairs
require("nvim-autopairs").setup({})

local lsp_installer = require("nvim-lsp-installer")

lsp_installer.on_server_ready(function(server)
  local opts = {}
  opts.capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
  server:setup(opts)
end)

-- -- LSP Config
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
    ["<C-y>"] = cmp.mapping.confirm({ select = true }),
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
  null_ls.builtins.diagnostics.eslint_d.with({
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
  ensure_installed = "all",
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
    preview = {
      hide_on_startup = true,
    },
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
      n = {
        ["<c-c>"] = actions.close,
      },
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
