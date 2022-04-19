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
  vim.keymap.set("n", "<leader>cf", vim.lsp.buf.formatting, opts)
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
vim.keymap.set("v", "J", "<Cmd>m '>+1<CR>gv=gv<Cr>")
vim.keymap.set("v", "K", "<Cmd>m '<-2<CR>gv=gv<Cr>")
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
