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
        file_history_panel = {
          ["q"] = "<Cmd>DiffviewClose<CR>",
        },
      },
    },
    keys = {
      { "<leader>gg", "<Cmd>DiffviewOpen<CR>",          desc = "diff" },
      { "<leader>gh", "<Cmd>DiffviewFileHistory<CR>",   desc = "history" },
      { "<leader>gH", "<Cmd>DiffviewFileHistory %<CR>", desc = "history file" },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    lazy = false,
    config = true,
  },
}
