return {
	{
		"nvim-neorg/neorg",
		build = ":Neorg sync-parsers",
		opts = {
			load = {
				["core.defaults"] = {},
				["core.norg.concealer"] = { config = { folds = false, icon_preset = "diamond" } },
				["core.integrations.nvim-cmp"] = {},
				["core.norg.completion"] = { config = { engine = "nvim-cmp" } },
			},
		},
		dependencies = { { "nvim-lua/plenary.nvim" } },
	},
}
