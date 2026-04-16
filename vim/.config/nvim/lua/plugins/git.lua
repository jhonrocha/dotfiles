local git = {
  {
    "sindrets/diffview.nvim",
    opts = {
      enhanced_diff_hl = true,
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
      -- { "<leader>gg", "<Cmd>DiffviewOpen<CR>",          desc = "diff" },
      { "<leader>gh", "<Cmd>DiffviewFileHistory<CR>",   desc = "history" },
      { "<leader>gH", "<Cmd>DiffviewFileHistory %<CR>", desc = "history file" },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    lazy = false,
    config = true,
    keys = {
      { "<leader>n", "<Cmd>Gitsigns next_hunk<CR>",    desc = "next_hunk" },
      { "<leader>m", "<Cmd>Gitsigns prev_hunk<CR>",    desc = "prev_hunk" },
      { "<leader>gp", "<Cmd>Gitsigns preview_hunk<CR>", desc = "prev_hunk" },
    },
  },
  {
    "esmuellert/codediff.nvim",
    cmd = "CodeDiff",
    opts = {
      keymaps = {
        view = {
          next_hunk = "<leader>n",    -- Jump to next change
          prev_hunk = "<leader>m",    -- Jump to previous change
          next_file = "<TAB>", -- Next file in explorer/history mode
          prev_file = "<S-TAB>",
        },
      },
    },
    keys = {
      { "<leader>gg", "<Cmd>CodeDiff<CR>", desc = "diff" },
    },
  }
}
return git
