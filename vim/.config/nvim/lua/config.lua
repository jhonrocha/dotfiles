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
  themeStyle = "dark",
})

-- LSP
local lspconfig = require('lspconfig')
-- Completion
local coq = require "coq"
-- TS-JS
lspconfig.tsserver.setup{
  on_attach = function(client)
    client.resolved_capabilities.document_formatting = false
  end
}

-- diagnosticls
lspconfig.diagnosticls.setup{
  filetypes = {"javascript", "typescript","python"},
  root_dir = function(fname)
    return lspconfig.util.root_pattern("tsconfig.json")(fname) or
    lspconfig.util.root_pattern(".eslintrc")(fname) or
    lspconfig.util.root_pattern(".eslintrc.json")(fname) or
    lspconfig.util.root_pattern(".eslintrc.js")(fname) or
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
lspconfig.rust_analyzer.setup(coq.lsp_ensure_capabilities({
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
}))
-- VIM
lspconfig.vimls.setup{}

-- LUA
lspconfig.sumneko_lua.setup{
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
lspconfig.pylsp.setup{}

-- LSP Config
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
vim.lsp.diagnostic.on_publish_diagnostics, {
  virtual_text = false
})

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
