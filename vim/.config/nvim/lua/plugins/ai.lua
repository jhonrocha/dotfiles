local ai = {
  {
    "Exafunction/windsurf.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("codeium").setup({
        enable_cmp_source = false,
        virtual_text = {
          enabled = true,
          filetypes = {
            lua = true,
            javascript = true,
            typescript = true,
            typescriptreact = true,
            javascriptreact = true,
            html = true,
            css = true,
            scss = true,
            markdown = true,
            json = true,
            yaml = true,
            toml = true,
            go = true,
          },
          default_filetype_enabled = false,
        },
      })
    end,
    -- keys = {
    --   { "<leader>a", "<Cmd>Codeium Chat<CR>", desc = "ai chat" },
    -- },
  },
  {
    "olimorris/codecompanion.nvim",
    lazy = true,
    opts = {
      strategies = {
        chat = {
          adapter = "copilot",
        },
        inline = {
          adapter = "copilot",
        },
        cmd = {
          adapter = "copilot",
        },
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    keys = {
      { "<leader>a", "<Cmd>CodeCompanionChat Toggle<CR>", desc = "ai chat" },
      { "<leader>A", "<Cmd>CodeCompanionActions<CR>",     desc = "ai actions" },
    },
  },
}

return ai
