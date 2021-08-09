-- Line
-- require("plug-galaxyline")
require('lualine').setup {
  options = {
    theme = 'github',
    -- section_separators = {"", ""},
    -- component_separators = {"", ""},
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
  themeStyle = "light",
})

-- LSP
local lspconfig = require('lspconfig')

-- TS-JS
lspconfig.tsserver.setup{}

-- diagnosticls
lspconfig.diagnosticls.setup{
  filetypes = {"javascript", "typescript"},
  root_dir = function(fname)
    return lspconfig.util.root_pattern("tsconfig.json")(fname) or
    lspconfig.util.root_pattern(".eslintrc")(fname) or
    lspconfig.util.root_pattern(".eslintrc.js")(fname);
  end,
  init_options = {
    linters = {
      eslint = {
        command = "./node_modules/.bin/eslint",
        rootPatterns = {".eslintrc.js", ".eslintrc", ".git"},
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
        }
      },
    },
    filetypes = {
      javascript = "eslint",
      typescript = "eslint"
    }
  }
}
-- RUST
lspconfig.rust_analyzer.setup({
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
    }
  }
})
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
}
)

-- Treesitter
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true,
  },
}

-- COMPE
require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    buffer = true;
    calc = true;
    nvim_lsp = true;
    nvim_lua = true;
    vsnip = true;
  };
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
    sorting_strategy = "ascending",
    layout_strategy = "horizontal",
    file_previewer = require('telescope.previewers').cat.new,
    layout_config = {
      horizontal = {
        width = 0.95,
        height = 0.6,
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
          ["<c-d>"] = require("telescope.actions").delete_buffer,
        },
      }
    }
  }
}
function ff()
  require('telescope.builtin').find_files {
    find_command = {'fd','--type','f','--hidden','--follow','--exclude','.git'}
  }
end
