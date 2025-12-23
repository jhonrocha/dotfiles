local code = {
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {},
    -- stylua: ignore
    keys = {
      { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
      { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
      { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
      { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function(_, opts)
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "*",
        callback = function(args)
          local ft = vim.bo[args.buf].filetype
          local ok, lang = pcall(vim.treesitter.language.get_lang, ft)
          if ok and lang then
            pcall(vim.treesitter.start, args.buf, lang)
          end
        end,
      })
    end
  },
  {
    "saghen/blink.cmp",
    dependencies = { "rafamadriz/friendly-snippets" },
    version = "*",
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        preset = "default",
        -- ["<Up>"] = { "select_prev", "fallback" },
        -- ["<Down>"] = { "select_next", "fallback" },
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
        per_filetype = {
          codecompanion = { "codecompanion" },
        },
        providers = {
          lsp = { fallbacks = {} },
        },
      },
      fuzzy = { implementation = "prefer_rust_with_warning" },
    },
    opts_extend = { "sources.default" },
  },
}
return code
