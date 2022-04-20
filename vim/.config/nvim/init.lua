-- Install packer
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
end

local packer_group = vim.api.nvim_create_augroup("Packer", { clear = true })
vim.api.nvim_create_autocmd(
  "BufWritePost",
  { command = "source <afile> | PackerCompile", group = packer_group, pattern = "init.lua" }
)

require("packer").startup(function(use)
  use("wbthomason/packer.nvim") -- Package manager
  use("tpope/vim-fugitive") -- Git commands in nvim
  use("tpope/vim-rhubarb") -- Fugitive-companion to interact with github
  use("numToStr/Comment.nvim") -- "gc" to comment visual regions/lines
  -- UI to select things (files, grep results, open buffers...)
  use({ "nvim-telescope/telescope.nvim", requires = { "nvim-lua/plenary.nvim" } })
  use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
  use("mjlbach/onedark.nvim") -- Theme inspired by Atom
  use({
    "catppuccin/nvim",
    as = "catppuccin",
  })
  -- Fancier statusline
  use({
    "nvim-lualine/lualine.nvim",
    requires = { "kyazdani42/nvim-web-devicons", opt = true },
  })
  use({
    "kyazdani42/nvim-tree.lua",
    requires = {
      "kyazdani42/nvim-web-devicons", -- optional, for file icon
    },
  })
  -- Add indentation guides even on blank lines
  use("lukas-reineke/indent-blankline.nvim")
  -- Add git related info in the signs columns and popups
  use({ "lewis6991/gitsigns.nvim", requires = { "nvim-lua/plenary.nvim" } })
  -- Highlight, edit, and navigate code using a fast incremental parsing library
  use("nvim-treesitter/nvim-treesitter")
  -- Additional textobjects for treesitter
  use("nvim-treesitter/nvim-treesitter-textobjects")
  use({
    "neovim/nvim-lspconfig",
    "williamboman/nvim-lsp-installer",
    "jose-elias-alvarez/null-ls.nvim",
  })
  -- Autocompletion plugin
  use({
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-nvim-lua",
    "saadparwaiz1/cmp_luasnip",
  })
  use("L3MON4D3/LuaSnip") -- Snippets plugin
  use("rafamadriz/friendly-snippets")
end)

-- Clipboard
vim.cmd([[set clipboard+=unnamedplus]])

--Make line numbers default
vim.wo.number = true

--Enable mouse mode
vim.o.mouse = "a"

--Enable break indent
vim.o.breakindent = true

--Save undo history
vim.opt.undofile = true

--Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Tab size
vim.o.expandtab = 2
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2

--Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = "yes"

--Set colorscheme
vim.o.termguicolors = true
require("catppuccin").setup()
vim.cmd([[colorscheme catppuccin]])

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

--Set statusbar
require("lualine").setup({
  options = {
    icons_enabled = true,
    theme = "catppuccin",
    -- component_separators = "|",
    -- section_separators = "",
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { { "filename", path = 1 }, "diff", "diagnostics" },
    lualine_c = { "branch" },
    lualine_x = { "encoding", "fileformat", "filetype" },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
})

--Enable Comment.nvim
require("Comment").setup()

--Remap space as leader key
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})

--Map blankline
require("indent_blankline").setup({
  char = "┊",
  space_char_blankline = " ",
  show_current_context = true,
  show_current_context_start = true,
})

-- Gitsigns
require("gitsigns").setup({
  signs = {
    add = { text = "+" },
    change = { text = "~" },
    delete = { text = "_" },
    topdelete = { text = "‾" },
    changedelete = { text = "~" },
  },
})

-- Treesitter configuration
-- Parsers must be installed manually via :TSInstall
require("nvim-treesitter.configs").setup({
  ensure_installed = "all",
  ignore_install = { "norg", "phpdoc" },
  highlight = {
    enable = true, -- false will disable the whole extension
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
  indent = {
    enable = true,
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
    },
  },
})

-- luasnip setup
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
    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "nvim_lua" },
    { name = "path" },
    { name = "buffer" },
  },
  experimental = { ghost_text = true },
})

-- LSP settings
local on_attach = function(_, bufnr)
  local opts = { buffer = bufnr }
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
  vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
  vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, opts)
  vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
  vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
  vim.keymap.set("n", "<leader>wl", function()
    vim.inspect(vim.lsp.buf.list_workspace_folders())
  end, opts)
  vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "<leader>fl", require("telescope.builtin").lsp_document_symbols, opts)
  vim.keymap.set("n", "<leader>cf", vim.lsp.buf.formatting_seq_sync, opts)
end
-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

-- Enable the following language servers
require("nvim-lsp-installer").on_server_ready(function(server)
  local opts = {}
  if server.name == "sumneko_lua" then
    opts.settings = {
      Lua = {
        diagnostics = { globals = { "vim" } },
      },
    }
  end
  opts.on_attach = on_attach
  opts.capabilities = capabilities
  server:setup(opts)
end)

-- Diagnostic config
local null_ls = require("null-ls")
local sources = {
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
  null_ls.builtins.formatting.black,
  null_ls.builtins.diagnostics.pylint,
  null_ls.builtins.diagnostics.staticcheck,
}

null_ls.setup({ sources = sources })

vim.diagnostic.config({ virtual_text = false })

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

-- Enable telescope fzf native
require("telescope").load_extension("fzf")

-- File Browser Tree
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

--Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

--Add leader shortcuts
vim.keymap.set("n", "<leader>,", require("telescope.builtin").buffers)
vim.keymap.set("n", "<leader><space>", require("telescope.builtin").find_files)
vim.keymap.set("n", "<leader>ff", require("telescope.builtin").current_buffer_fuzzy_find)
vim.keymap.set("n", "<leader>fW", require("telescope.builtin").grep_string)
vim.keymap.set("n", "<leader>fw", require("telescope.builtin").live_grep)
vim.keymap.set("n", "<leader>fgc", require("telescope.builtin").git_commits)
vim.keymap.set("n", "<leader>fgb", require("telescope.builtin").git_branches)
vim.keymap.set("n", "<leader>o", require("telescope.builtin").oldfiles)

-- My Maps
vim.keymap.set("n", "<leader>fs", "<Cmd>update<CR>")
vim.keymap.set("n", "<leader>fk", "<Cmd>bd<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
vim.keymap.set("n", "]k", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]j", vim.diagnostic.goto_next)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)

-- Tree
vim.keymap.set("n", "<leader>d", "<Cmd>NvimTreeFindFileToggle<CR>")

-- Git
vim.keymap.set("n", "<leader>gg", "<Cmd>Git<CR>")
vim.keymap.set("n", "<leader>gy", "<Cmd>!gy<CR><CR>")
vim.keymap.set("n", "<leader>gp", ':Git push origin <c-r>=trim(system("git rev-parse --abbrev-ref HEAD"))<CR>')

-- Buffer navigation
vim.keymap.set("n", "<leader>j", "<Cmd>bn<CR>")
vim.keymap.set("n", "<leader>k", "<Cmd>bp<CR>")
vim.keymap.set("n", "<leader><TAB>", "<C-^>")

-- Replacers
vim.keymap.set("n", "<leader>rr", ":%s//gc<left><left><left>")
vim.keymap.set("n", "<leader>rb", ":.,$s//gc<left><left><left>")

-- Utilities
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")
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

vim.keymap.set("n", "<leader>p", '"vp')
vim.keymap.set("n", "<leader>P", '"vP')
-- vim: ts=2 sts=2 sw=2 et
