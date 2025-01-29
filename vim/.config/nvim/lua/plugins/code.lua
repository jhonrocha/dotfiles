local ufo_handle = function(virtText, lnum, endLnum, width, truncate)
  local newVirtText = {}
  local suffix = (" 󰁂 %d "):format(endLnum - lnum)
  local sufWidth = vim.fn.strdisplaywidth(suffix)
  local targetWidth = width - sufWidth
  local curWidth = 0
  for _, chunk in ipairs(virtText) do
    local chunkText = chunk[1]
    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
    if targetWidth > curWidth + chunkWidth then
      table.insert(newVirtText, chunk)
    else
      chunkText = truncate(chunkText, targetWidth - curWidth)
      local hlGroup = chunk[2]
      table.insert(newVirtText, { chunkText, hlGroup })
      chunkWidth = vim.fn.strdisplaywidth(chunkText)
      -- str width returned from truncate() may less than 2nd argument, need padding
      if curWidth + chunkWidth < targetWidth then suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth) end
      break
    end
    curWidth = curWidth + chunkWidth
  end
  table.insert(newVirtText, { suffix, "MoreMsg" })
  return newVirtText
end

local code = {
  {
    "ggandor/leap.nvim",
    keys = {
      {
        "s",
        function() require("leap").leap({ target_windows = { vim.fn.win_getid() } }) end,
        { desc = "leap" },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      -- Treesitter configuration
      -- Parsers must be installed manually via :TSInstall
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "bash",
          "c",
          "cpp",
          "css",
          "go",
          "gomod",
          "html",
          "hurl",
          "java",
          "javascript",
          "jsdoc",
          "json",
          "lua",
          "python",
          "query",
          "rust",
          "tsx",
          "typescript",
          "vim",
          "vimdoc",
        },
        highlight = {
          enable = true, -- false will disable the whole extension
        },
        indent = { enable = true },
      })
      -- local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()
      -- parser_configs.hcl = { filetype = "hcl", "terraform" }
    end,
  },
  { "windwp/nvim-autopairs", config = true },
  {
    "saghen/blink.cmp",
    dependencies = "rafamadriz/friendly-snippets",
    version = "*",
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        preset = "super-tab",
        ["<Up>"] = { "select_prev", "fallback" },
        ["<Down>"] = { "select_next", "fallback" },
        ["<CR>"] = { "accept", "fallback" },
        cmdline = {
          preset = "super-tab",
        },
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
        default = { "lsp", "snippets", "path", "buffer" },
      },
    },
    opts_extend = { "sources.default" },
  },
  {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    opts = {
      close_fold_kinds_for_ft = {
        default = { "imports" },
      },
      provider_selector = function(bufnr, filetype, buftype) return { "lsp", "indent" } end,
      fold_virt_text_handler = ufo_handle,
    },
  },
  {
    "kawre/leetcode.nvim",
    build = ":TSUpdate html", -- if you have `nvim-treesitter` installed
    dependencies = {
      "nvim-telescope/telescope.nvim",
      -- "ibhagwan/fzf-lua",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    opts = {
      lang = "python3", -- configuration goes here
      picker = { provider = "telescope" },
    },
    keys = {
      { "<leader>ll", "<Cmd>Leet<CR>",                                    desc = "leet" },
      { "<leader>le", "<Cmd>Leet list difficulty=easy status=todo<CR>",   desc = "easy" },
      { "<leader>lm", "<Cmd>Leet list difficulty=medium status=todo<CR>", desc = "medium" },
      { "<leader>lh", "<Cmd>Leet list difficulty=hard status=todo<CR>",   desc = "hard" },
      { "<leader>lr", "<Cmd>Leet run<CR>",                                desc = "run" },
      { "<leader>ls", "<Cmd>Leet submit<CR>",                             desc = "submit" },
      { "<leader>lo", "<Cmd>Leet open<CR>",                               desc = "open" },
    },
  },
}
return code
