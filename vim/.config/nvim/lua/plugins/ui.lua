local ui = {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    enable = true,
    config = function()
      -- load the colorscheme here
      -- vim.cmd.colorscheme('tokyonight')
      vim.cmd.colorscheme('catppuccin-macchiato')
      vim.g.gruvbox_material_background = "dark"
      -- vim.cmd.colorscheme('gruvbox-material')
    end,
  },
  {
    "catppuccin/nvim",
    lazy = false,
    enable = false,
    name = "catppuccin",
    priority = 1001,
    opts = {
      -- transparent_background = false,
      integrations = {
        leap = true,
        nvimtree = true,
        blink_cmp = true,
        treesitter = true,
        mason = true,
        snacks = true,
      },
    },
  },
  {
    "sainnhe/gruvbox-material",
    lazy = false,
    priority = 1002,
    config = function()
      -- Optionally configure and load the colorscheme
      -- directly inside the plugin declaration.
      vim.g.gruvbox_material_enable_italic = true
      vim.g.gruvbox_material_background = "dark"
      vim.g.gruvbox_material_better_performance = 1
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", lazy = true },
    opts = {
      options = {
        globalstatus = true,
        section_separators = { left = "", right = "" },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { { "buffers", show_filename_only = true } },
        lualine_c = {},
        lualine_x = { "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
      extensions = { "quickfix", "nvim-tree" },
    },
  },
  {
    "folke/which-key.nvim",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require("which-key").setup({
        delay = 500,
      })
      local wk = require("which-key")
      wk.add({
        { "<leader>c", group = "code" },
        { "<leader>f", group = "finder" },
        { "<leader>g", group = "git" },
        { "<leader>i", group = "debug" },
        { "<leader>q", group = "quicklist" },
        { "<leader>r", group = "replace" },
        { "<leader>y", group = "yank" },
      })
    end,
  },
}
return ui
