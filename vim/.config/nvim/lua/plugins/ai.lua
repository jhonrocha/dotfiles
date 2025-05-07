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
            ['snacks.picker'] = false,
            ['snacks_picker_list'] = false,
          },
          default_filetype_enabled = true,
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
          adapter = "gemini",
        },
        inline = {
          adapter = "gemini",
        },
        cmd = {
          adapter = "gemini",
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
