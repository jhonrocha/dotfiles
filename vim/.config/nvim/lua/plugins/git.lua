return {
  {
    "sindrets/diffview.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      keymaps = {
        file_panel = {
          ["q"] = "<Cmd>DiffviewClose<CR>",
        },
        view = {
          ["q"] = "<Cmd>DiffviewClose<CR>",
        },
      },
    },
    keys = {
      { "<leader>gg", "<Cmd>DiffviewOpen<CR>",        desc = "open in gh" },
      { "<leader>gh", "<Cmd>DiffviewFileHistory<CR>", desc = "open in gh" },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    config = true,
  },
}
