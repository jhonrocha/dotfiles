-- Line
require('lualine').setup {
  options = {theme = 'catppuccin'},
  sections = {
    lualine_a = {'mode'},
    lualine_b = {''},
    lualine_c = {{'filename', path = 1}},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  }
}

-- Theme
require("catppuccin").setup({
  -- transparent_background = true,
  integration = {
    nvimtree = {
      enabled = true,
      show_root = true -- makes the root folder not transparent
    }
  }
})
vim.cmd [[colorscheme catppuccin]]

-- TREE
vim.g.nvim_tree_quit_on_open = 1
require'nvim-tree'.setup {git = {enable = true, ignore = false, timeout = 500}}

-- Pairs
require('nvim-autopairs').setup {}

-- LSP
local nvim_lsp = require('lspconfig')
-- Setup nvim-cmp.
local cmp = require 'cmp'
local lspkind = require('lspkind')
cmp.setup({
  snippet = {expand = function(args) vim.fn["vsnip#anonymous"](args.body) end},
  mapping = {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({select = true})
  },
  documentation = {
    -- border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
  },
  sources = {
    {name = 'vsnip'}, {name = 'nvim_lsp'}, {name = 'nvim_lua'}, {name = 'path'},
    {name = 'buffer'}
  },
  formatting = {format = lspkind.cmp_format()},
  experimental = {ghost_text = true}
});

-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- TS-JS
nvim_lsp.tsserver.setup {
  capabilities = capabilities,
  on_attach = function(client)
    client.resolved_capabilities.document_formatting = false
  end
}

-- diagnosticls
nvim_lsp.diagnosticls.setup {
  capabilities = capabilities,
  filetypes = {"javascript", "typescript", "typescriptreact", "python", "json"},
  root_dir = function(fname)
    return nvim_lsp.util.root_pattern("tsconfig.json")(fname) or
            nvim_lsp.util.root_pattern(".eslintrc")(fname) or
            nvim_lsp.util.root_pattern(".eslintrc.json")(fname) or
            nvim_lsp.util.root_pattern(".eslintrc.js")(fname) or
            nvim_lsp.util.root_pattern("package.json")(fname) or
            nvim_lsp.util.root_pattern(".pylintrc")(fname)
  end,
  init_options = {
    linters = {
      eslint = {
        command = "eslint_d",
        rootPatterns = {".eslintrc.json", ".eslintrc.js", ".eslintrc", ".git"},
        debounce = 100,
        args = {"--stdin", "--stdin-filename", "%filepath", "--format", "json"},
        sourceName = "eslint",
        parseJson = {
          errorsRoot = "[0].messages",
          line = "line",
          column = "column",
          endLine = "endLine",
          endColumn = "endColumn",
          message = "[eslint] ${message} [${ruleId}]",
          security = "severity"
        },
        securities = {[2] = "error", [1] = "warning"}
      },
      pylint = {
        sourceName = 'pylint',
        command = 'pylint',
        args = {
          '--output-format', 'text', '--score', 'no', '--msg-template',
          [['{line}:{column}:{category}:{msg} ({msg_id}:{symbol})']], '%file'
        },
        offsetColumn = 1,
        formatLines = 1,
        formatPattern = {
          [[^(\d+?):(\d+?):([a-z]+?):(.*)$]],
          {line = 1, column = 2, security = 3, message = {'[pylint] ', 4}}
        },
        securities = {
          informational = 'hint',
          refactor = 'info',
          convention = 'info',
          warning = 'warning',
          error = 'error',
          fatal = 'error'
        },
        rootPatterns = {'.git', 'pyproject.toml', 'setup.py'}
      }
    },
    formatters = {
      prettier = {
        command = "prettier",
        args = {"--stdin-filepath", "%filepath"}
      },
      eslint_fmt = {command = "eslint_d", args = {"--stdin", "--fix-to-stdout"}},
      rustfmt = {command = "rustfmt", args = {"%filepath"}}
    },
    formatFiletypes = {
      javascript = {"prettier", "eslint_fmt"},
      json = {"prettier"},
      typescript = {"prettier"},
      typescriptreact = "prettier",
      rust = "rustfmt"
    },
    filetypes = {
      javascript = "eslint",
      typescript = "eslint",
      python = "pylint"
    }
  }
}

-- Using EFM
nvim_lsp.efm.setup {
  init_options = {documentFormatting = true},
  filetypes = {"lua"},
  settings = {
    rootMarkers = {".git/"},
    languages = {lua = {{formatCommand = "lua-format -i", formatStdin = true}}}
  }
}

-- RUST
-- rust-tools options
local opts = {
  tools = {
    autoSetHints = true,
    hover_with_actions = true,
    inlay_hints = {
      show_parameter_hints = false,
      parameter_hints_prefix = "",
      other_hints_prefix = ""
    }
  },
  server = {
    settings = {["rust-analyzer"] = {checkOnSave = {command = "clippy"}}}
  }
}

require('rust-tools').setup(opts)
-- VIM
nvim_lsp.vimls.setup {capabilities = capabilities}

-- LUA
nvim_lsp.sumneko_lua.setup {
  capabilities = capabilities,
  cmd = {"/usr/bin/lua-language-server", "-E"},
  settings = {Lua = {diagnostics = {globals = {'vim'}}}}
}

-- Python
nvim_lsp.pylsp.setup {capabilities = capabilities}

-- LSP Config
vim.lsp.handlers["textDocument/publishDiagnostics"] =
 vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {virtual_text = false})

-- Treesitter
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  highlight = {enable = true}
}

-- Telescope
local actions = require('telescope.actions')
require("telescope").setup {
  defaults = {
    vimgrep_arguments = {
      'rg', '--hidden', '--color=never', '--no-heading', '--with-filename',
      '--line-number', '--glob=!.git', '--column', '--smart-case'
    },
    border = true,
    borderchars = {
      prompt = {"─", " ", " ", " ", "─", "─", " ", " "},
      results = {" "},
      preview = {"─", "│", "─", "│", "╭", "╮", "╯", "╰"}
    },
    dynamic_preview_title = false,
    -- file_previewer = require('telescope.previewers').cat.new,
    file_ignore_patterns = {"node_modules", ".git"},
    sorting_strategy = "ascending",
    -- layout_strategy = "horizontal",
    layout_strategy = "bottom_pane",
    layout_config = {
      bottom_pane = {height = 0.4},
      horizontal = {
        width = 0.95,
        height = 0.4,
        preview_width = 0.4,
        prompt_position = "top",
        preview_cutoff = 60
      },
      vertical = {mirror = false}
    },
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<c-j>"] = actions.move_selection_next,
        ["<c-k>"] = actions.move_selection_previous,
        ["<tab>"] = actions.add_selection + actions.move_selection_next,
        ["<s-tab>"] = actions.remove_selection + actions.move_selection_previous
      }
    }
  },
  pickers = {
    buffers = {
      sort_lastused = true,
      mappings = {i = {["<c-d>"] = "delete_buffer"}}
    },
    find_files = {hidden = true}
  }
}

function ff()
  require('telescope.builtin').find_files {
    -- find_command = {'fd','--type','f','--hidden','--follow','--exclude','.git','--exclude','node_modules', '--no-ignore'}
  }
end
