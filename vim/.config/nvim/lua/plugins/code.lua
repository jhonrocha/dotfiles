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
  { "windwp/nvim-autopairs",  config = true },
  {
    "saghen/blink.cmp",
    dependencies = "rafamadriz/friendly-snippets",
    version = "*",
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        preset = "super-tab",
        ["<Up>"] = { "select_prev", "fallback" },
        ["<Down>"] = { "select_next", "fallback" },
        ["<CR>"] = { "accept", "fallback" },
        cmdline = {
          preset = "super-tab",
        },
      },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono",
      },
      completion = {
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 500,
        },
      },
      signature = { enabled = true },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
    },
    opts_extend = { "sources.default" },
  },
  { "sindrets/diffview.nvim", config = true },
}
return code
