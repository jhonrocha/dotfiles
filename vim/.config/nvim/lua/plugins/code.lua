local code = {
  {
    "ggandor/leap.nvim",
    keys = {
      {
        "s",
        function()
          require("leap").leap({ target_windows = { vim.fn.win_getid() } })
        end,
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
    -- optional: provides snippets for the snippet source
    dependencies = "rafamadriz/friendly-snippets",

    -- use a release tag to download pre-built binaries
    version = "*",
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- 'default' for mappings similar to built-in completion
      -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
      -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
      -- See the full "keymap" documentation for information on defining your own keymap.
      keymap = { preset = "enter" },

      appearance = {
        -- Sets the fallback highlight groups to nvim-cmp's highlight groups
        -- Useful for when your theme doesn't support blink.cmp
        -- Will be removed in a future release
        use_nvim_cmp_as_default = true,
        -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = "mono",
      },
      completion = {
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 500,
        }
      },

      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
    },
    opts_extend = { "sources.default" },
  },
}
return code
