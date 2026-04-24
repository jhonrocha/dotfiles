----------------------------------------
------------ Leader Key ----------------
----------------------------------------
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

----------------------------------------
------------ Plugin Manager ------------
----------------------------------------
local gh = function(x) return "https://github.com/" .. x end

vim.pack.add({
  -- Theme
  gh("folke/tokyonight.nvim"),

  -- UI (dependencies first)
  gh("nvim-tree/nvim-web-devicons"),
  gh("nvim-lualine/lualine.nvim"),
  gh("folke/which-key.nvim"),
  gh("nvim-tree/nvim-tree.lua"),
  gh("Bekaboo/dropbar.nvim"),

  -- Snacks
  gh("folke/snacks.nvim"),

  -- Code
  gh("folke/flash.nvim"),
  { src = gh("nvim-treesitter/nvim-treesitter"),             version = "main" },
  { src = gh("nvim-treesitter/nvim-treesitter-textobjects"), version = "main" },
  { src = gh("saghen/blink.cmp"),                            version = vim.version.range("*") },
  gh("rafamadriz/friendly-snippets"),

  -- Git
  gh("sindrets/diffview.nvim"),
  gh("lewis6991/gitsigns.nvim"),
  gh("esmuellert/codediff.nvim"),

  -- LSP
  gh("neovim/nvim-lspconfig"),
  gh("mason-org/mason.nvim"),
  gh("mason-org/mason-lspconfig.nvim"),
  gh("stevearc/conform.nvim"),
})

----------------------------------------
------------ Plugin Config -------------
----------------------------------------

-- Theme
vim.cmd.colorscheme("tokyonight-night")

-- Snacks
require("snacks").setup({
  explorer = { enabled = false },
  bigfile = { enabled = true, line_length = 100000 },
  bufdelete = { enable = true },
  dashboard = { enabled = false },
  git = { enabled = true },
  gitbrowse = { enabled = true },
  indent = { enabled = true, animate = { enabled = false } },
  input = { enabled = true },
  lazygit = {
    enabled = true,
    configure = true,
    config = {
      os = {
        editPreset = "nvim-remote",
        edit = 'nvim --server "$NVIM" --remote-send "q" && nvim --server "$NVIM" --remote {{filename}}',
        editAtLine =
        'nvim --server "$NVIM" --remote-send "q" && nvim --server "$NVIM" --remote {{filename}} && nvim --server "$NVIM" --remote-send ":{{line}}<CR>"',
      },
    },
    win = { width = 0, height = 0, keys = { ["<c-c>"] = { "hide", mode = { "t" } } } },
  },
  notifier = { enabled = true },
  picker = {
    enabled = true,
    win = {
      input = {
        keys = {
          ["<Esc>"] = { "close", mode = "i" },
          ["<c-d>"] = { "bufdelete", mode = { "n", "i" } },
          ["<c-p>"] = { "toggle_preview", mode = { "i", "n" } },
        },
      },
    },
    sources = {
      buffers = {
        hidden = true,
        layout = { preset = "ivy", preview = false },
      },
      files = {
        hidden = true,
        layout = { preset = "ivy", preview = false },
      },
      grep = {
        hidden = true,
        sort = { fields = { "score:desc", "file", "lnum" } },
        matcher = { sort_empty = true },
        layout = { preset = "default", layout = { width = 0.99 } },
      },
    },
    -- layout = { preset = "ivy" },
    layout = { preset = "default", layout = { width = 0.99 } },
  },
  quickfile = { enabled = true },
  scratch = {
    enabled = true,
    filekey = {
      cwd = true,
      branch = false,
      count = false,
    },
  },
  scroll = { enabled = true, animate = { duration = { step = 15, total = 100 } } },
  statuscolumn = { enabled = true, refresh = 50 },
  words = { enabled = false },
})

-- Snacks keymaps
vim.keymap.set("n", "<leader><space>", function() Snacks.picker.files() end, { desc = "Find Files" })
vim.keymap.set("n", "<leader>,", function() Snacks.picker.buffers() end, { desc = "Buffers" })
vim.keymap.set("n", "<leader>:", function() Snacks.picker.command_history() end, { desc = "Command History" })
vim.keymap.set("n", "<leader>fk", function() Snacks.bufdelete() end, { desc = "file kill" })
vim.keymap.set("n", "<leader>fm", function() Snacks.notifier.show_history() end, { desc = "list messages" })
vim.keymap.set("n", "<leader>fr", function()
  Snacks.picker.resume({ exclude = { "lsp_definitions", "lsp_references", "lsp_implementations", "lsp_type_definitions", "lsp_symbols" } })
end, { desc = "Resume" })
vim.keymap.set("n", "<leader>ff", function() Snacks.picker.files({ ignored = true }) end, { desc = "Find Files+" })
vim.keymap.set("n", "<leader>fg", function() Snacks.picker.git_files() end, { desc = "Find Git Files" })
vim.keymap.set("n", "<leader>fR", function() Snacks.picker.recent() end, { desc = "Recent" })
-- git
vim.keymap.set("n", "<leader>go", function() Snacks.gitbrowse({ branch = "development" }) end, { desc = "browser" })
vim.keymap.set("n", "<leader>gO", function() Snacks.gitbrowse() end, { desc = "browser" })
vim.keymap.set("n", "<leader>gc", function() Snacks.lazygit() end, { desc = "to lazygit" })
vim.keymap.set("n", "<leader>gl", function() Snacks.lazygit.log() end, { desc = "log" })
vim.keymap.set("n", "<leader>gL", function() Snacks.lazygit.log_file() end, { desc = "log file" })
vim.keymap.set("n", "<leader>gs", function() Snacks.picker.git_status() end, { desc = "Git Status" })
-- search
vim.keymap.set("n", "<leader>fl", function() Snacks.picker.lines() end, { desc = "Search Lines" })
vim.keymap.set("n", "<leader>fw", function() Snacks.picker.grep() end, { desc = "Grep" })
vim.keymap.set("n", "<leader>f.", function() Snacks.picker.registers() end, { desc = "Registers" })
vim.keymap.set("n", "<leader>fa", function() Snacks.picker.autocmds() end, { desc = "Autocmds" })
vim.keymap.set("n", "<leader>fc", function() Snacks.picker.command_history() end, { desc = "Command History" })
vim.keymap.set("n", "<leader>fC", function() Snacks.picker.commands() end, { desc = "Commands" })
vim.keymap.set("n", "<leader>fd", function() Snacks.picker.diagnostics() end, { desc = "Diagnostics" })
vim.keymap.set("n", "<leader>fh", function() Snacks.picker.help() end, { desc = "Help Pages" })
vim.keymap.set("n", "<leader>fH", function() Snacks.picker.highlights() end, { desc = "Highlights" })
vim.keymap.set("n", "<leader>fj", function() Snacks.picker.jumps() end, { desc = "Jumps" })
vim.keymap.set("n", "<leader>fK", function() Snacks.picker.keymaps() end, { desc = "Keymaps" })
vim.keymap.set("n", "<leader>fL", function() Snacks.picker.loclist() end, { desc = "Location List" })
vim.keymap.set("n", "<leader>fb", function() Snacks.picker.marks({ global = false }) end, { desc = "Bookmarks" })
vim.keymap.set("n", "<leader>fB", function() Snacks.picker.marks() end, { desc = "Bookmarks" })
vim.keymap.set("n", "<leader>fq", function() Snacks.picker.qflist() end, { desc = "Quickfix List" })
vim.keymap.set("n", "<leader>ft", function() Snacks.picker.colorschemes() end, { desc = "Themes" })
vim.keymap.set("n", "<leader>fp", function() Snacks.picker.projects() end, { desc = "Projects" })
-- lsp
vim.keymap.set("n", "gd", function() Snacks.picker.lsp_definitions() end, { desc = "Goto Definition" })
vim.keymap.set("n", "gr", function() Snacks.picker.lsp_references() end, { nowait = true, desc = "References" })
vim.keymap.set("n", "gI", function() Snacks.picker.lsp_implementations() end, { desc = "Goto Implementation" })
vim.keymap.set("n", "gy", function() Snacks.picker.lsp_type_definitions() end, { desc = "Goto Type Definition" })
vim.keymap.set("n", "<leader>fS", function() Snacks.picker.lsp_symbols() end, { desc = "LSP Symbols" })
-- scratch
vim.keymap.set("n", "<leader>.", function() Snacks.scratch() end, { desc = "Scratch" })
vim.keymap.set("n", "<leader>S", function() Snacks.scratch.select() end, { desc = "Scratch List" })

-- Lualine
local theme = "tokyonight-night"
require("lualine").setup({
  options = {
    globalstatus = true,
    section_separators = { left = "", right = "" },
    component_separators = "",
    theme,
    refresh = { statusline = 100 },
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { { "filename", path = 1 } },
    lualine_c = { "diagnostics" },
    lualine_x = {
      {
        function()
          local reg = vim.fn.reg_recording()
          return reg ~= "" and "recording @" .. reg or ""
        end,
        color = { fg = "#f7768e" },
      },
      "searchcount",
      "diff",
      "filetype",
    },
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
})

-- Which-key
vim.o.timeout = true
vim.o.timeoutlen = 300
require("which-key").setup({ delay = 500 })
require("which-key").add({
  { "<leader>c", group = "code" },
  { "<leader>f", group = "finder" },
  { "<leader>g", group = "git" },
  { "<leader>i", group = "debug" },
  { "<leader>q", group = "quicklist" },
  { "<leader>r", group = "replace" },
  { "<leader>y", group = "yank" },
})

-- Nvim-tree
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = { width = 30 },
  renderer = {
    group_empty = false,
    highlight_opened_files = "icon",
  },
  update_focused_file = { enable = true },
  git = { ignore = false },
})
vim.keymap.set("n", "<leader>d", "<Cmd>NvimTreeFindFileToggle<CR>", { desc = "file drawer" })

-- Dropbar
require("dropbar").setup()
local dropbar_api = require("dropbar.api")
vim.keymap.set("n", "<Leader>cp", dropbar_api.pick, { desc = "Pick symbols in winbar" })
vim.keymap.set("n", "<Leader>ck", dropbar_api.goto_context_start, { desc = "Go to start of current context" })
vim.keymap.set("n", "<Leader>cj", dropbar_api.select_next_context, { desc = "Select next context" })

-- Flash
require("flash").setup({})
-- stylua: ignore start
vim.keymap.set({ "n", "x", "o" }, "s", function() require("flash").jump() end, { desc = "Flash" })
vim.keymap.set({ "n", "x", "o" }, "S", function() require("flash").treesitter() end, { desc = "Flash Treesitter" })
vim.keymap.set("o", "r", function() require("flash").remote() end, { desc = "Remote Flash" })
vim.keymap.set({ "o", "x" }, "R", function() require("flash").treesitter_search() end, { desc = "Treesitter Search" })
vim.keymap.set("c", "<c-s>", function() require("flash").toggle() end, { desc = "Toggle Flash Search" })
-- stylua: ignore end

-- Treesitter
local parsers = {
  "bash", "c", "diff", "html", "lua", "luadoc",
  "markdown", "markdown_inline", "query", "vim",
  "javascript", "jsx", "typescript", "tsx", "rust", "go",
}
require("nvim-treesitter").install(parsers)
vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    local buf, filetype = args.buf, args.match

    local language = vim.treesitter.language.get_lang(filetype)
    if not language then
      return
    end

    if not vim.treesitter.language.add(language) then
      return
    end

    vim.treesitter.start(buf, language)
    vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    vim.wo.foldmethod = "expr"
    vim.opt.foldenable = false
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})
require("nvim-treesitter-textobjects").setup({
  select = {
    lookahead = true,
    keymaps = {
      ["af"] = "@function.outer",
      ["if"] = "@function.inner",
      ["ac"] = "@class.outer",
      ["ic"] = "@class.inner",
      ["as"] = { query = "@local.scope", query_group = "locals", desc = "Select language scope" },
    },
    selection_modes = {
      ["@parameter.outer"] = "v",
      ["@function.outer"] = "V",
    },
    include_surrounding_whitespace = false,
  },
  move = {
    set_jumps = true,
  },
})

-- Blink.cmp
require("blink.cmp").setup({
  keymap = {
    preset = "default",
    ["<CR>"] = { "accept", "fallback" },
  },
  cmdline = {
    keymap = {
      preset = "super-tab",
      ["<ESC>"] = {
        function(cmp)
          if cmp.is_visible() then
            cmp.cancel()
          else
            vim.api.nvim_feedkeys(
              vim.api.nvim_replace_termcodes("<C-c>", true, true, true),
              "n",
              true
            )
          end
        end,
      },
    },
    completion = { menu = { auto_show = true } },
  },
  appearance = {
    use_nvim_cmp_as_default = true,
    nerd_font_variant = "mono",
  },
  completion = {
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 200,
    },
  },
  signature = {
    enabled = true,
    window = { show_documentation = false
    }
  },
  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
    per_filetype = {
      codecompanion = { "codecompanion" },
    },
    providers = {
      lsp = { fallbacks = {} },
    },
  },
  fuzzy = { implementation = "prefer_rust_with_warning" },
})

-- Diffview
require("diffview").setup({
  enhanced_diff_hl = true,
  keymaps = {
    file_panel = { ["q"] = "<Cmd>DiffviewClose<CR>" },
    view = { ["q"] = "<Cmd>DiffviewClose<CR>" },
    file_history_panel = { ["q"] = "<Cmd>DiffviewClose<CR>" },
  },
})
vim.keymap.set("n", "<leader>gh", "<Cmd>DiffviewFileHistory<CR>", { desc = "history" })
vim.keymap.set("n", "<leader>gH", "<Cmd>DiffviewFileHistory %<CR>", { desc = "history file" })

-- Gitsigns
require("gitsigns").setup()
vim.keymap.set("n", "<leader>n", "<Cmd>Gitsigns prev_hunk<CR>", { desc = "prev_hunk" })
vim.keymap.set("n", "<leader>m", "<Cmd>Gitsigns next_hunk<CR>", { desc = "next_hunk" })
vim.keymap.set("n", "<leader>gp", "<Cmd>Gitsigns preview_hunk<CR>", { desc = "prev_hunk" })

-- Codediff
require("codediff").setup({
  keymaps = {
    view = {
      next_hunk = "<leader>m",
      prev_hunk = "<leader>n",
      next_file = "<TAB>",
      prev_file = "<S-TAB>",
    },
  },
})
vim.keymap.set("n", "<leader>gg", "<Cmd>CodeDiff<CR>", { desc = "diff" })

-- Mason (must be before mason-lspconfig)
require("mason").setup()
require("mason-lspconfig").setup()

-- Conform
require("conform").setup({
  formatters_by_ft = {
    lua = { lsp_format = "first" },
    go = { "gofmt", lsp_format = "fallback" },
    json = { "prettier", lsp_format = "never" },
    javascript = { "prettier", stop_after_first = false, lsp_format = "never" },
    javascriptreact = { "prettier", stop_after_first = false, lsp_format = "never" },
    typescript = { "prettier", stop_after_first = false, lsp_format = "never" },
    typescriptreact = { "prettier", stop_after_first = false, lsp_format = "never" },
    rust = { "rustfmt", lsp_format = "fallback" },
    sh = { "shfmt", lsp_format = "first" },
    sql = { "sqfluff", lsp_format = "never" },
  },
})
vim.keymap.set("n", "<leader>cf", function()
  require("conform").format({ lsp_format = "fallback" })
end, { desc = "code format" })

----------------------------------------
---------------- SETUP -----------------
----------------------------------------

-- Add border to all float windows
vim.o.winborder = "rounded"

vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.HINT] = "",
      [vim.diagnostic.severity.INFO] = "",
    },
  },
})

vim.cmd.highlight("DiagnosticUnderlineError gui=undercurl")

-- Clipboard
vim.opt.clipboard = "unnamedplus"
-- Make line numbers default
vim.o.number = true
-- Enable mouse mode
vim.o.mouse = "a"
-- Keep the view when switching buffers
vim.o.jumpoptions = "view"
-- Enable break indent
vim.o.breakindent = true
-- Save undo history
vim.opt.undofile = true
-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true
-- Tab size
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
-- Split right
vim.o.splitright = true
-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

vim.filetype.add({
  pattern = {
    [".*/waybar/config"] = "jsonc",
    [".*/mako/config"] = "dosini",
    [".*/kitty/*.conf"] = "bash",
    [".*/hypr/.*%.conf"] = "hyprlang",
  },
})

----------------------------------------
----------------- LSP ------------------
----------------------------------------

-- LSP Configuration (native Neovim 0.12 API)
vim.lsp.inlay_hint.enable()
vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      diagnostics = { globals = { "vim", "Snacks" } },
      hint = { enable = true },
      format = {
        enable = true,
        defaultConfig = {
          quote_style = "double",
          max_line_length = "200",
        }
      },
    },
  },
})

vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "code action" })
vim.keymap.set("n", "<leader>cD", vim.lsp.buf.declaration, { desc = "lsp declaration" })
vim.keymap.set("n", "<leader>cd", vim.lsp.buf.definition, { desc = "lsp definition" })
vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0, desc = "lsp hover" })
vim.keymap.set("n", "<leader>ci", vim.lsp.buf.implementation, { desc = "lsp implementation" })
vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, { desc = "lsp type" })
vim.keymap.set("n", "<leader>cw", vim.lsp.buf.rename, { desc = "lsp rename" })
vim.keymap.set("n", "<leader>cr", vim.lsp.buf.references, { desc = "lsp references" })

----------------------------------------
------------------ UI ------------------
----------------------------------------
vim.o.laststatus = 3

local modes = {
  n = "NORMAL",
  i = "INSERT",
  v = "VISUAL",
  V = "V-LINE",
  ["\22"] = "V-BLOCK",
  c = "COMMAND",
  R = "REPLACE",
  t = "TERM",
}

function Mode()
  local m = vim.api.nvim_get_mode().mode
  return modes[m] or modes[m:sub(1, 1)] or m:upper()
end

-- Experimental UI2: floating cmdline and messages
vim.o.cmdheight = 1
require("vim._core.ui2").enable({
  enable = true,
  msg = {
    targets = {
      [""] = "msg",
      empty = "cmd",
      bufwrite = "msg",
      confirm = "cmd",
      emsg = "pager",
      echo = "msg",
      echomsg = "msg",
      echoerr = "pager",
      completion = "cmd",
      list_cmd = "pager",
      lua_error = "pager",
      lua_print = "msg",
      progress = "pager",
      rpc_error = "pager",
      quickfix = "msg",
      search_cmd = "cmd",
      search_count = "cmd",
      shell_cmd = "pager",
      shell_err = "pager",
      shell_out = "pager",
      shell_ret = "msg",
      undo = "msg",
      verbose = "pager",
      wildlist = "cmd",
      wmsg = "msg",
      typed_cmd = "cmd",
    },
    cmd = { height = 0.5 },
    dialog = { height = 0.5 },
    msg = { height = 0.5, timeout = 5000 },
    pager = { height = 0.5 },
  },
})

vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
})

----------------------------------------
----------------- MAPS -----------------
----------------------------------------
-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true, desc = "move up (wrap)" })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true, desc = "move down (wrap)" })

-- My Maps
vim.keymap.set("n", "<leader>fs", "<Cmd>update!<CR>", { desc = "file save" })
vim.keymap.set("n", "<leader>R", "<Cmd>e<CR>", { desc = "file reload" })

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "diagnostic" })
vim.keymap.set("n", "<leader>cj", function()
  vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "prev diagnostic" })
vim.keymap.set("n", "<leader>ck", function()
  vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "next diagnostic" })

-- Buffer navigation
vim.keymap.set("n", "<leader>j", "<Cmd>bn<CR>", { desc = "next buf" })
vim.keymap.set("n", "<leader>k", "<Cmd>bp<CR>", { desc = "prev buf" })
vim.keymap.set("n", "<leader><TAB>", "<C-^>", { desc = "alt buf" })
vim.keymap.set("n", "<leader>yp", "<Cmd>let @+=expand('%:p:.')<CR>", { desc = "copy path" })
vim.keymap.set("n", "<leader>yP", "<Cmd>let @+=expand('%:t')<CR>", { desc = "copy filename" })

-- Replacers
vim.keymap.set("n", "<leader>rr", ":%s//gc<left><left><left>", { desc = "replace all" })
vim.keymap.set("n", "<leader>rb", ":.,$s//gc<left><left><left>", { desc = "replace bellow" })

-- Utilities
vim.keymap.set("v", "<", "<gv", { desc = "indent right" })
vim.keymap.set("v", ">", ">gv", { desc = "indent left" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv")

-- Delete, not cut
vim.keymap.set({ "n", "v" }, "d", '"vd')
vim.keymap.set({ "n", "v" }, "D", '"vD')
vim.keymap.set({ "n", "v" }, "x", '"vx')
vim.keymap.set({ "n", "v" }, "X", '"vX')
vim.keymap.set({ "n", "v" }, "c", '"vc')
vim.keymap.set({ "n", "v" }, "C", '"vC')

-- Original copy paste
vim.keymap.set("n", "<leader>p", '"vp', { desc = "paste" })
vim.keymap.set("n", "<leader>P", '"vP', { desc = "paste above" })

-- Clear search
vim.keymap.set("n", "<leader><Esc>", "<Cmd>noh<CR>", { desc = "clear highlight" })

-- Quicklist
vim.keymap.set("n", "<leader>qq", "<Cmd>copen<CR>", { desc = "quick open" })
vim.keymap.set("n", "<leader>qc", "<Cmd>cclose<CR>", { desc = "quick close" })
vim.keymap.set("n", "<leader>qj", "<Cmd>cn<CR>", { desc = "quick next" })
vim.keymap.set("n", "<leader>qk", "<Cmd>cp<CR>", { desc = "quick previous" })

-- Terminal
vim.keymap.set("t", "<C-x>", "<C-\\><C-n>", { desc = "normal mode" })
