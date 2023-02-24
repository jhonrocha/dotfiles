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
require("lazy").setup("plugins")

----------------------------------------
---------------- SETUP -----------------
----------------------------------------
local signs = {
  Error = "",
  Warn = "",
  Hint = "",
  Info = "",
}

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end
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
-- Show signcolumn
-- vim.wo.signcolumn = "yes:1"
vim.wo.signcolumn = "yes:1"

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
-- vim.keymap.set("n", "s", '"vs')
-- vim.keymap.set("n", "S", '"vS')
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
