----------------------------------------
------------ Plugin Manager ------------
----------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then vim.fn.system({
	"git",
	"clone",
	"--filter=blob:none",
	"https://github.com/folke/lazy.nvim.git",
	"--branch=stable",
	lazypath,
}) end
vim.opt.rtp:prepend(lazypath)

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
		border = "single",
	},
})

----------------------------------------
---------------- SETUP -----------------
----------------------------------------

-- Add border to all float windows
vim.o.winborder = "rounded"

-- for type, icon in pairs(signs) do
-- 	local hl = "DiagnosticSign" .. type
-- 	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
-- end
vim.diagnostic.config({
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.HINT] = "",
			[vim.diagnostic.severity.INFO] = "",
		},
		-- linehl = {
		--     [vim.diagnostic.severity.ERROR] = 'ErrorMsg',
		-- },
		-- numhl = {
		--     [vim.diagnostic.severity.WARN] = 'WarningMsg',
		-- },
	},
	float = { border = "single" },
	-- virtual_text = true,
})

vim.cmd.highlight("DiagnosticUnderlineError gui=undercurl")

-- Clipboard
vim.opt.clipboard = "unnamedplus"
-- Make line numbers default
vim.wo.number = true
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
vim.o.updatetime = 250
-- Folding
vim.o.foldcolumn = "1" -- '0' is not bad
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
-- Set colorscheme
vim.o.termguicolors = true
-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"
-- Show signcolumn
-- vim.wo.signcolumn = "yes:1"
vim.wo.signcolumn = "yes:1"

-- Disable cmdline
vim.o.cmdheight = 0

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function() vim.highlight.on_yank() end,
	group = highlight_group,
	pattern = "*",
})

vim.filetype.add({
	pattern = {
		[".*/waybar/config"] = "jsonc",
		[".*/mako/config"] = "dosini",
		[".*/kitty/*.conf"] = "bash",
		[".*/hypr/.*%.conf"] = "hyprlang",
	},
})

----------------------------------------
----------------- MAPS -----------------
----------------------------------------
-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true, desc = "TODO" })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true, desc = "TODO" })

-- My Maps
vim.keymap.set("n", "<leader>fs", "<Cmd>update!<CR>", { desc = "file save" })
vim.keymap.set("n", "<leader>R", "<Cmd>e<CR>", { desc = "file reload" })

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "diagnostic" })
vim.keymap.set("n", "<leader>n", function() vim.diagnostic.goto_prev({ float = true }) end, { desc = "prev diagnostic" })
vim.keymap.set("n", "<leader>m", function() vim.diagnostic.goto_next({ float = true }) end, { desc = "next diagnostic" })
-- vim.keymap.set("n", "<leader>ci", vim.diagnostic.setloclist)

-- Buffer navigation
vim.keymap.set("n", "<leader>j", "<Cmd>bn<CR>", { desc = "next buf" })
vim.keymap.set("n", "<leader>k", "<Cmd>bp<CR>", { desc = "prev buf" })
vim.keymap.set("n", "<leader><TAB>", "<C-^>", { desc = "alt buf" })
vim.keymap.set("n", "<leader>yp", "<Cmd>let @+=expand('%:p:.')<CR>", { desc = "copy path" })
vim.keymap.set("n", "<leader>yP", "<Cmd>let @+=expand('%:t')<CR>", { desc = "copy full" })

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
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "normal mode" })
