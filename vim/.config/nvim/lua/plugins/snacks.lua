return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    dependencies = {
      "lewis6991/gitsigns.nvim",
    },
    ---@type snacks.Config
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      bigfile = { enabled = true },
      bufdelete = { enable = true },
      dashboard = {
        enabled = true,
        sections = {
          { section = "header" },
          { section = "keys",   gap = 1, padding = 1 },
          { section = "startup" },
          -- {
          --   section = "terminal",
          --   -- cmd = "pokemon-colorscripts -r 1-4 --no-title; sleep .1",
          --   cmd = "~/.cache/pokemon-icat/pokemon-icat --height 5 --quiet",
          --   random = 10,
          --   pane = 2,
          --   indent = 4,
          --   height = 30,
          -- },
        },
      },
      git = { enabled = true },
      gitbrowse = { enabled = true },
      indent = { enabled = true, animate = { enabled = false } },
      input = { enabled = true },
      lazygit = { enabled = true },
      notifier = { enabled = true },
      picker = {
        enabled = true,
        win = {
          input = {
            keys = {
              ["<Esc>"] = { "close", mode = "i" },
              ["<c-d>"] = { "bufdelete", mode = { "n", "i" } },
              ["<c-p>"] = { "toggle_preview", mode = { "i", "n" } },
            },
          },
        },
        layout = { preset = "ivy" },
      },
      quickfile = { enabled = true },
      scratch = {
        enabled = true,
        filekey = {
          cwd = true,
          branch = false,
          count = false,
        },
      },
      scroll = { enabled = true, animate = { duration = { step = 15, total = 100 } } },
      statuscolumn = { enabled = true },
      terminal = { enabled = true },
      words = { enabled = true },
    },
    keys = {
      { "<leader>fk",      function() Snacks.bufdelete() end,                                                                   desc = "file kill" },
      { "<leader>go",      function() Snacks.gitbrowse() end,                                                                   desc = "browser" },
      -- Fuzzy Find
      { "<leader>,",       function() Snacks.picker.buffers({ layout = { preview = false } }) end,                              desc = "Buffers" },
      { "<leader>:",       function() Snacks.picker.command_history() end,                                                      desc = "Command History" },
      { "<leader><space>", function() Snacks.picker.files({ hidden = true, layout = { preview = false } }) end,                 desc = "Find Files" },
      { "<leader>fr",      function() Snacks.picker.resume() end,                                                               desc = "Resume" },
      -- find
      { "<leader>ff",      function() Snacks.picker.files({ hidden = true, ignored = true, layout = { preview = false } }) end, desc = "Find Files+" },
      { "<leader>fc",      function() Snacks.picker.files({ cwd = vim.fn.stdpath("config"), hidden = true }) end,               desc = "Find Config File" },
      { "<leader>fg",      function() Snacks.picker.git_files() end,                                                            desc = "Find Git Files" },
      { "<leader>fR",      function() Snacks.picker.recent() end,                                                               desc = "Recent" },
      -- git
      { "<leader>gc",      function() Snacks.lazygit() end,                                                                     desc = "to lazygit" },
      { "<leader>gl",      function() Snacks.lazygit.log() end,                                                                 desc = "log" },
      { "<leader>gL",      function() Snacks.lazygit.log() end,                                                                 desc = "log file" },
      { "<leader>gs",      function() Snacks.picker.git_status() end,                                                           desc = "Git Status" },
      -- Grep
      { "<leader>sb",      function() Snacks.picker.lines() end,                                                                desc = "Buffer Lines" },
      { "<leader>sB",      function() Snacks.picker.grep_buffers({ hidden = true }) end,                                        desc = "Grep Open Buffers" },
      { "<leader>fw",      function() Snacks.picker.grep({ hidden = true }) end,                                                desc = "Grep" },
      { "<leader>sw",      function() Snacks.picker.grep_word({ hidden = true }) end,                                           desc = "Visual selection or word",  mode = { "n", "x" } },
      -- search
      { "<leader>s.",      function() Snacks.picker.registers() end,                                                            desc = "Registers" },
      { "<leader>sa",      function() Snacks.picker.autocmds() end,                                                             desc = "Autocmds" },
      { "<leader>sc",      function() Snacks.picker.command_history() end,                                                      desc = "Command History" },
      { "<leader>sC",      function() Snacks.picker.commands() end,                                                             desc = "Commands" },
      { "<leader>sd",      function() Snacks.picker.diagnostics() end,                                                          desc = "Diagnostics" },
      { "<leader>sh",      function() Snacks.picker.help() end,                                                                 desc = "Help Pages" },
      { "<leader>sH",      function() Snacks.picker.highlights() end,                                                           desc = "Highlights" },
      { "<leader>sj",      function() Snacks.picker.jumps() end,                                                                desc = "Jumps" },
      { "<leader>sk",      function() Snacks.picker.keymaps() end,                                                              desc = "Keymaps" },
      { "<leader>sl",      function() Snacks.picker.loclist() end,                                                              desc = "Location List" },
      { "<leader>sM",      function() Snacks.picker.man() end,                                                                  desc = "Man Pages" },
      { "<leader>sm",      function() Snacks.picker.marks() end,                                                                desc = "Marks" },
      { "<leader>sq",      function() Snacks.picker.qflist() end,                                                               desc = "Quickfix List" },
      { "<leader>st",      function() Snacks.picker.colorschemes() end,                                                         desc = "Themes" },
      { "<leader>sp",      function() Snacks.picker.projects() end,                                                             desc = "Projects" },
      -- LSP
      { "gd",              function() Snacks.picker.lsp_definitions() end,                                                      desc = "Goto Definition" },
      { "gr",              function() Snacks.picker.lsp_references() end,                                                       nowait = true,                      desc = "References" },
      { "gI",              function() Snacks.picker.lsp_implementations() end,                                                  desc = "Goto Implementation" },
      { "gy",              function() Snacks.picker.lsp_type_definitions() end,                                                 desc = "Goto T[y]pe Definition" },
      { "<leader>ss",      function() Snacks.picker.lsp_symbols() end,                                                          desc = "LSP Symbols" },
      -- scracth
      { "<leader>.",       function() Snacks.scratch() end,                                                                     desc = "Toggle Scratch Buffer" },
      { "<leader>S",       function() Snacks.scratch.select() end,                                                              desc = "Select Scratch Buffer" },
      -- terminal
      { "<A-g>",           function() Snacks.terminal.toggle() end,                                                             mode = { "n", "i", "v", "t", "x" }, desc = "terminal" },
    },
  },
}
