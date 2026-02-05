local git = {
  {
    "sindrets/diffview.nvim",
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
    keys = {
      { "<leader>gj", "<Cmd>Gitsigns next_hunk<CR>", desc = "next_hunk" },
      { "<leader>gk", "<Cmd>Gitsigns prev_hunk<CR>", desc = "prev_hunk" },
      { "<leader>gp", "<Cmd>Gitsigns preview_hunk<CR>", desc = "prev_hunk" },
    },
  },
}
return git
