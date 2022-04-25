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
  -- Git
  use("tpope/vim-fugitive") -- Git commands in nvim
  use({
    "sindrets/diffview.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
    },
  })
  use("numToStr/Comment.nvim") -- "gc" to comment visual regions/lines
  -- UI to select things (files, grep results, open buffers...)
  use({ "nvim-telescope/telescope.nvim", requires = { "nvim-lua/plenary.nvim" } })
  use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
  -- Themes
  use("folke/tokyonight.nvim")
  -- Fancier statusline
  use({
    "nvim-lualine/lualine.nvim",
    requires = { "kyazdani42/nvim-web-devicons", opt = true },
  })
  -- Tree/File Browser
  use({
    "kyazdani42/nvim-tree.lua",
    requires = {
      "kyazdani42/nvim-web-devicons",
    },
  })
  -- Add indentation guides even on blank lines
  use("lukas-reineke/indent-blankline.nvim")
  -- Add marks to the left bar
  use("chentau/marks.nvim")
  -- Add git related info in the signs columns and popups
  use({ "lewis6991/gitsigns.nvim", requires = { "nvim-lua/plenary.nvim" } })
  -- Highlight, edit, and navigate code using a fast incremental parsing library
  use({
    "nvim-treesitter/nvim-treesitter",
    -- Additional textobjects for treesitter
    "nvim-treesitter/nvim-treesitter-textobjects",
  })
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

-- Split right
vim.o.splitright = true

--Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = "yes"

--Folding
vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.foldenable = false
vim.o.foldtext = [[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').'...'.trim(getline(v:foldend)) . ' (' . (v:foldend - v:foldstart + 1) . ' lines)']]
vim.o.fillchars = "fold: ,diff: "

--Set colorscheme
vim.o.termguicolors = true
vim.g.tokyonight_style = "night"
vim.cmd([[colorscheme tokyonight]])

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

--Set statusbar
require("lualine").setup({
  options = {
    globalstatus = true,
    icons_enabled = true,
    theme = "tokyonight",
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
  extensions = { "quickfix", "nvim-tree" },
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
vim.cmd([[highlight IndentBlanklineContextStart guisp=#ffffff gui=underdot cterm=underdot]])
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
  current_line_blame_opts = {
    delay = 300,
  },
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
    keymaps = {},
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
})

-- LSP settings
vim.keymap.set("n", "<leader>cD", vim.lsp.buf.declaration, { desc = "TODO" })
vim.keymap.set("n", "<leader>cd", vim.lsp.buf.definition, { desc = "TODO" })
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "TODO" })

vim.keymap.set("n", "<leader>ci", vim.lsp.buf.implementation, { desc = "TODO" })
vim.keymap.set({ "n", "i" }, "<C-k>", vim.lsp.buf.signature_help, { desc = "TODO" })
vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, { desc = "TODO" })
vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, { desc = "TODO" })
vim.keymap.set("n", "<leader>wl", function()
  vim.inspect(vim.lsp.buf.list_workspace_folders())
end, { desc = "TODO" })
vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, { desc = "TODO" })
vim.keymap.set("n", "<leader>cw", vim.lsp.buf.rename, { desc = "rename" })
vim.keymap.set("n", "<leader>cr", vim.lsp.buf.references, { desc = "TODO" })
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "TODO" })
vim.keymap.set("n", "<leader>fl", require("telescope.builtin").lsp_document_symbols, { desc = "TODO" })
vim.keymap.set("n", "<leader>cf", vim.lsp.buf.formatting_seq_sync, { desc = "TODO" })

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

-- Marks
require("marks").setup({})

-- GIT
require("diffview").setup({
  file_panel = {
    position = "left",
    width = 20,
    listing_style = "list",
  },
})

--Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true, desc = "TODO" })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true, desc = "TODO" })

--Add leader shortcuts
vim.keymap.set("n", "<leader>,", require("telescope.builtin").buffers, { desc = "TODO" })
vim.keymap.set("n", "<leader><space>", require("telescope.builtin").find_files, { desc = "TODO" })
vim.keymap.set("n", "<leader>ff", require("telescope.builtin").current_buffer_fuzzy_find, { desc = "TODO" })
vim.keymap.set("n", "<leader>fW", require("telescope.builtin").grep_string, { desc = "TODO" })
vim.keymap.set("n", "<leader>fw", require("telescope.builtin").live_grep, { desc = "TODO" })
vim.keymap.set("n", "<leader>fgc", require("telescope.builtin").git_commits, { desc = "TODO" })
vim.keymap.set("n", "<leader>fgb", require("telescope.builtin").git_branches, { desc = "TODO" })
vim.keymap.set("n", "<leader>o", require("telescope.builtin").oldfiles, { desc = "TODO" })

-- My Maps
vim.keymap.set("n", "<leader>fs", "<Cmd>update<CR>")
vim.keymap.set("n", "<leader>fk", "<Cmd>bd<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
vim.keymap.set("n", "]k", function()
  vim.diagnostic.goto_prev({ float = true })
end)
vim.keymap.set("n", "]j", function()
  vim.diagnostic.goto_next({ float = true })
end)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)

-- Tree
vim.keymap.set("n", "<leader>d", "<Cmd>NvimTreeFindFileToggle<CR>")

-- Git
vim.keymap.set("n", "<leader>gg", "<Cmd>Git<CR>", { desc = "Git" })
vim.keymap.set("n", "<leader>gd", "<Cmd>DiffviewOpen<CR>", { desc = "gdiff" })
vim.keymap.set("n", "<leader>gq", "<Cmd>DiffviewClose<CR>", { desc = "close gdiff" })
vim.keymap.set("n", "<leader>gy", "<Cmd>!gy<CR><CR>", { desc = "yank branch" })
vim.keymap.set(
  "n",
  "<leader>gp",
  ':Git push origin <c-r>=trim(system("git rev-parse --abbrev-ref HEAD"))<CR>',
  { desc = "push" }
)

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

vim.keymap.set("n", "<leader>p", '"vp')
vim.keymap.set("n", "<leader>P", '"vP')

-- Clear search
vim.keymap.set("n", "<leader><Esc>", "<Cmd>noh<CR>", { desc = "clear highlight" })

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
