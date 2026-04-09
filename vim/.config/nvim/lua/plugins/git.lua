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
      hooks = {
        -- Taken from this example: https://github.com/sindrets/diffview.nvim/pull/258#issuecomment-1408689220
        diff_buf_win_enter = function(bufnr, winid, ctx)
          if ctx.layout_name:match("^diff2") then
            if ctx.symbol == "a" then
              vim.opt_local.winhl = table.concat({
                "DiffText:DiffviewDiffAddAsDelete",
                "DiffChange:DiffviewLineChangeDiffDelete",
              }, ",")
            elseif ctx.symbol == "b" then
              vim.opt_local.winhl = table.concat({
                "DiffText:DiffviewDiffAdd",
                "DiffChange:DiffviewLineChangeDiffAdd",
              }, ",")
            end
          end
        end,
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
      { "<leader>gj", "<Cmd>Gitsigns next_hunk<CR>",    desc = "next_hunk" },
      { "<leader>gk", "<Cmd>Gitsigns prev_hunk<CR>",    desc = "prev_hunk" },
      { "<leader>gp", "<Cmd>Gitsigns preview_hunk<CR>", desc = "prev_hunk" },
    },
  },
}
return git
