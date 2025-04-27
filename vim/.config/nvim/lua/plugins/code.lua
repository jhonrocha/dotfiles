local code = {
  {
    "ggandor/leap.nvim",
    keys = {
      {
        "s",
        function() require("leap").leap({ target_windows = { vim.fn.win_getid() } }) end,
        { desc = "leap" },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      -- Treesitter configuration
      -- Parsers must be installed manually via :TSInstall
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "bash",
          "c",
          "cpp",
          "css",
          "go",
          "gomod",
          "html",
          "hurl",
          "java",
          "javascript",
          "jsdoc",
          "json",
          "lua",
          "python",
          "query",
          "rust",
          "tsx",
          "typescript",
          "vim",
          "vimdoc",
        },
        highlight = {
          enable = true, -- false will disable the whole extension
        },
        indent = { enable = true },
      })
      -- local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()
      -- parser_configs.hcl = { filetype = "hcl", "terraform" }
    end,
  },
  { "windwp/nvim-autopairs", config = true },
  {
    "saghen/blink.cmp",
    dependencies = { "rafamadriz/friendly-snippets" },
    version = "*",
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        preset = "default",
        ["<Up>"] = { "select_prev", "fallback" },
        ["<Down>"] = { "select_next", "fallback" },
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
                vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-c>", true, true, true), "n", true)
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
      signature = { enabled = true },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
      fuzzy = { implementation = "prefer_rust_with_warning" },
    },
    opts_extend = { "sources.default" },
  },
  {
    "kawre/leetcode.nvim",
    build = ":TSUpdate html", -- if you have `nvim-treesitter` installed
    lazy = true,
    dependencies = {
      "nvim-telescope/telescope.nvim",
      -- "ibhagwan/fzf-lua",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    opts = {
      lang = "python3", -- configuration goes here
      picker = { provider = "telescope" },
      injector = { ---@type table<lc.lang, lc.inject>
        ["python"] = {
          before = "from typing import List",
        },
        ["python3"] = {
          before = "from typing import List",
        },
      },
    },
    keys = {
      { "<leader>ll", "<Cmd>Leet<CR>",                                      desc = "leet" },
      { "<leader>le", "<Cmd>Leet random difficulty=easy status=todo<CR>",   desc = "easy" },
      { "<leader>lm", "<Cmd>Leet random difficulty=medium status=todo<CR>", desc = "medium" },
      { "<leader>lh", "<Cmd>Leet random difficulty=hard status=todo<CR>",   desc = "hard" },
      { "<leader>lE", "<Cmd>Leet list difficulty=easy status=todo<CR>",     desc = "easy" },
      { "<leader>lM", "<Cmd>Leet list difficulty=medium status=todo<CR>",   desc = "medium" },
      { "<leader>lH", "<Cmd>Leet list difficulty=hard status=todo<CR>",     desc = "hard" },
      { "<leader>lr", "<Cmd>Leet run<CR>",                                  desc = "run" },
      { "<leader>ls", "<Cmd>Leet submit<CR>",                               desc = "submit" },
      { "<leader>lo", "<Cmd>Leet open<CR>",                                 desc = "open" },
    },
  },
}
return code
