----------------------------------------
------------ Plugin Manager ------------
----------------------------------------
vim.pack.add({ "https://github.com/folke/lazy.nvim" })
-- Remap space as leader key
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

----------------------------------------
--------------- PLUGINS ----------------
----------------------------------------
require("lazy").setup("plugins", {
  change_detection = { enabled = false },
  ui = {
    border = "rounded",
  },
})

----------------------------------------
---------------- SETUP -----------------
----------------------------------------

-- Add border to all float windows
vim.o.winborder = "rounded"

vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.HINT] = "",
      [vim.diagnostic.severity.INFO] = "",
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
-- Decrease update time
-- vim.o.updatetime = 250
-- Folding
-- vim.o.foldcolumn = "1" -- '0' is not bad
-- vim.o.foldlevel = 99
-- vim.o.foldlevelstart = 99
-- vim.o.foldenable = true
-- vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
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
        -- Put format options here
        -- NOTE: the value should be String!
        defaultConfig = {
          quote_style = "double",
          max_line_length = "200",
        }
      },
    },
  },
})

vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = 0, desc = "code action" })
vim.keymap.set("n", "<leader>cD", vim.lsp.buf.declaration, { buffer = 0, desc = "lsp declaration" })
vim.keymap.set("n", "<leader>cd", vim.lsp.buf.definition, { buffer = 0, desc = "lsp definition" })
vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0, desc = "lsp hover" })
vim.keymap.set("n", "<leader>ci", vim.lsp.buf.implementation, { buffer = 0, desc = "lsp implementation" })
vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, { buffer = 0, desc = "lsp type" })
vim.keymap.set("n", "<leader>cw", vim.lsp.buf.rename, { buffer = 0, desc = "lsp rename" })
vim.keymap.set("n", "<leader>cr", vim.lsp.buf.references, { buffer = 0, desc = "lsp references" })
vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0, desc = "lsp hover" })

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
vim.keymap.set("n", "<leader>n", function()
  vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "prev diagnostic" })
vim.keymap.set("n", "<leader>m", function()
  vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "next diagnostic" })
-- vim.keymap.set("n", "<leader>ci", vim.diagnostic.setloclist)

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

-- vim.keymap.set("n", "s", '"vs')
-- vim.keymap.set("n", "S", '"vS')
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
--
-- Terminal
vim.keymap.set("t", "<C-x>", "<C-\\><C-n>", { desc = "normal mode" })

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

-- vim.o.statusline = " %#ModeMsg#%{v:lua.Mode()}%#StatusLine#  %f%m %=  %{&filetype}  %l:%c  %p%% "

-- Experimental UI2: floating cmdline and messages
-- Disable cmdline
vim.o.cmdheight = 0
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
    cmd = {
      height = 0.5,
    },
    dialog = {
      height = 0.5,
    },
    msg = {
      height = 0.3,
      timeout = 5000,
    },
    pager = {
      height = 0.5,
    },
  },
})
