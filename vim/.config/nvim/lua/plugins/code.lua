local code = {
  { "numToStr/Comment.nvim", config = true },
  {
    "ggandor/leap.nvim",
    keys = {
      {
        "s",
        function()
          require("leap").leap({ target_windows = { vim.fn.win_getid() } })
        end,
        { desc = "leap" },
      },
    },
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
      indent = {
        char = "┊",
        tab_char = "┊",
      },
      exclude = {
        filetypes = { "dashboard" },
      },
      scope = { enabled = false },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      -- Treesitter configuration
      -- Parsers must be installed manually via :TSInstall
      require("nvim-treesitter.configs").setup({
        ensure_installed = "all",
        ignore_install = { "norg", "phpdoc" },
        highlight = {
          enable = true, -- false will disable the whole extension
          disable = { "sql" },
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
          },
        },
        indent = { enable = true },
      })
      -- local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()
      -- parser_configs.hcl = { filetype = "hcl", "terraform" }
    end,
  },
  { "windwp/nvim-autopairs", config = true },
  {
    "L3MON4D3/LuaSnip", -- Snippets plugin
    dependencies = "rafamadriz/friendly-snippets",
    keys = {
      {
        "<C-J>",
        function()
          require("luasnip").jump(-1)
        end,
        mode = "i",
        desc = "jump",
      },
      {
        "<C-L>",
        function()
          require("luasnip").jump(1)
        end,
        mode = "i",
        desc = "jumpback",
      },
    },
  },
  {
    "folke/trouble.nvim",
    config = true,
    lazy = true,
    keys = {
      { "<leader>t", "<Cmd>TroubleToggle<CR>", desc = "trouble" },
    },
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lua",
      "saadparwaiz1/cmp_luasnip",
      "neovim/nvim-lspconfig",
      "L3MON4D3/LuaSnip",
    },
    config = function()
      local luasnip = require("luasnip")
      require("luasnip.loaders.from_vscode").lazy_load()
      -- nvim-cmp setup
      local cmp = require("cmp")
      cmp.setup({
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "nvim_lua" },
          { name = "path" },
          { name = "buffer" },
          { name = "neorg" },
        },
        experimental = { ghost_text = true },
        formatting = {
          format = function(_, vim_item)
            vim_item.abbr = string.sub(vim_item.abbr, 1, 20)
            return vim_item
          end,
        },
      })
    end,
  },
  {
    "kevinhwang91/nvim-ufo",
    lazy = true,
    dependencies = {
      "kevinhwang91/promise-async",
      "nvim-treesitter/nvim-treesitter",
    },
    config = {
      provider_selector = function(bufnr, filetype, buftype)
        return { "treesitter", "indent" }
      end,
    },
    keys = {
      {
        "zR",
        function()
          require("ufo").openAllFolds()
        end,
        desc = "open all",
      },
      {
        "zM",
        function()
          require("ufo").closeAllFolds()
        end,
        desc = "close all",
      },
    },
  },
  {
    "ray-x/lsp_signature.nvim",
    enabled = false,
    opts = {
      hint_enable = false,
      toggle_key = "<C-k>",
      floating_window = true,
      toggle_key_flip_floatwin_setting = true,
    },
  },
}
return code
