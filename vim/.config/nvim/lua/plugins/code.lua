return {
    { "numToStr/Comment.nvim", config = true },
    {
        "ggandor/leap.nvim",
        config = function()
            require("leap").add_default_mappings(true)
        end,
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        opts = { char = "┊", space_char_blankline = " " },
    }, -- Add marks to the left bar
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
    },
    { "ray-x/lsp_signature.nvim", opts = { hint_enable = false, toggle_key = "<C-k>" } },
    {
        "folke/trouble.nvim",
        config = true,
        keys = {
            { "<leader>t", "<Cmd>TroubleToggle<CR>", { desc = "trouble" } },
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
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-j>"] = cmp.mapping.confirm({
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = true,
                    }),
                }),
                sources = {
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "nvim_lua" },
                    { name = "path" },
                    { name = "buffer" },
                },
                experimental = { ghost_text = true },
                formatting = {
                    format = function(_, vim_item)
                        vim_item.abbr = string.sub(vim_item.abbr, 1, 20)
                        return vim_item
                    end,
                },
            })

            -- LuaSnip
            vim.keymap.set({ "s", "i" }, "<Tab>", function()
                if luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                else
                    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
                end
            end)

            vim.keymap.set({ "s", "i" }, "<S-Tab>", function()
                if luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                else
                    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<S-Tab>", true, false, true), "n", false)
                end
            end)
        end,
    },
}
