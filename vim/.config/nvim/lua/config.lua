-- Line
-- require("plug-galaxyline")
require('lualine').setup {
  options = {
    theme = 'github'
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {''},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
}

-- Theme
require("github-theme").setup({
  theme_style = "dark",
  -- transparent = true,
  -- dark_float = true
})

vim.g.nvim_tree_quit_on_open = 1
require'nvim-tree'.setup {
  update_focused_file = {
    enable = true,
  }
}

-- LSP
local lspconfig = require('lspconfig')
-- Setup nvim-cmp.
local cmp = require'cmp'
local lspkind = require('lspkind')
cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },
  documentation = {
    -- border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
  },
  sources = {
    { name = 'nvim_lsp' },
    -- For vsnip user.
    { name = 'vsnip' },
    { name = 'buffer' },
  },
  formatting = {
    format = lspkind.cmp_format(),
  }
});

-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- TS-JS
lspconfig.tsserver.setup {
  capabilities = capabilities,
  on_attach = function(client)
    client.resolved_capabilities.document_formatting = false
  end
}

-- diagnosticls
lspconfig.diagnosticls.setup {
  capabilities = capabilities,
  filetypes = {"javascript", "typescript","python"},
  root_dir = function(fname)
    return lspconfig.util.root_pattern("tsconfig.json")(fname) or
    lspconfig.util.root_pattern(".eslintrc")(fname) or
    lspconfig.util.root_pattern(".eslintrc.json")(fname) or
    lspconfig.util.root_pattern(".eslintrc.js")(fname) or
    lspconfig.util.root_pattern("package.json")(fname) or
    lspconfig.util.root_pattern(".pylintrc")(fname)
  end,
  init_options = {
    linters = {
      eslint = {
        command = "eslint_d",
        rootPatterns = {".eslintrc.json",".eslintrc.js", ".eslintrc", ".git"},
        debounce = 100,
        args = {
          "--stdin",
          "--stdin-filename",
          "%filepath",
          "--format",
          "json"
        },
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
        securities = {
          [2] = "error",
          [1] = "warning"
        },
      },
      pylint = {
        sourceName = 'pylint',
        command = 'pylint',
        args = {
          '--output-format',
          'text',
          '--score',
          'no',
          '--msg-template',
          [['{line}:{column}:{category}:{msg} ({msg_id}:{symbol})']],
          '%file',
        },
        offsetColumn = 1,
        formatLines = 1,
        formatPattern = {
          [[^(\d+?):(\d+?):([a-z]+?):(.*)$]],
          {line = 1, column = 2, security = 3, message = {'[pylint] ', 4}},
        },
        securities = {
          informational = 'hint',
          refactor = 'info',
          convention = 'info',
          warning = 'warning',
          error = 'error',
          fatal = 'error',
        },
        rootPatterns = {'.git', 'pyproject.toml', 'setup.py'},
      }
    },
    formatters = {
      prettier = {command = "prettier", args = {"--stdin-filepath", "%filepath"}},
      eslint_fmt = {command = "eslint_d", args = {"--stdin", "--fix-to-stdout"}},
      rustfmt = {command = "rustfmt", args = {"%filepath"}},
    },
    formatFiletypes = {
      javascript = {"prettier","eslint_fmt"},
      typescript = "prettier",
      typescriptreact = "prettier",
      rust = "rustfmt",
    },
    filetypes = {
      javascript = "eslint",
      typescript = "eslint",
      python = "pylint"
    }
  }
}
-- RUST
lspconfig.rust_analyzer.setup {
  capabilities = capabilities,
  settings = {
    ["rust-analyzer"] = {
      assist = {
        importMergeBehavior = "last",
        importPrefix = "by_self",
      },
      cargo = {
        loadOutDirsFromCheck = true
      },
      procMacro = {
        enable = true
      },
      checkOnSave = {
        command = "clippy"
      },
    }
  }
}

-- VIM
lspconfig.vimls.setup {
  capabilities = capabilities,
}

-- LUA
lspconfig.sumneko_lua.setup {
  capabilities = capabilities,
  cmd = {"/usr/bin/lua-language-server", "-E"};
  settings = {
    Lua = {
      diagnostics = {
        globals = {'vim'},
      },
    },
  },
}

-- Python
lspconfig.pylsp.setup {
  capabilities = capabilities,
}


-- LSP Config
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false
  }
)

-- Treesitter
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true,
  },
}

-- Telescope
local actions = require('telescope.actions')
require("telescope").setup {
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--hidden',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--glob=!.git',
      '--column',
      '--smart-case'
    },
    border = true,
    borderchars = {
      prompt = { "─", " ", " ", " ", "─", "─", " ", " " },
      results = { " " },
      preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    },
    dynamic_preview_title = false,
    file_previewer = require('telescope.previewers').cat.new,
    sorting_strategy = "ascending",
    -- layout_strategy = "horizontal",
    layout_strategy = "bottom_pane",
    layout_config = {
      bottom_pane = {
        height = 0.4,
      },
      horizontal = {
        width = 0.95,
        height = 0.4,
        preview_width = 0.4,
        prompt_position = "top",
        preview_cutoff = 60,
      },
      vertical = {
        mirror = false
      }
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
      mappings = {
        i = {
          ["<c-d>"] = "delete_buffer",
        },
      }
    }
  }
}

function ff()
  require('telescope.builtin').find_files {
    find_command = {'fd','--type','f','--hidden','--follow','--exclude','.git','--exclude','node_modules'}
  }
end
