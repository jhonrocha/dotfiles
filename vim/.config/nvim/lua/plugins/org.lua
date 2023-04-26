return {
	{
		"nvim-neorg/neorg",
		build = ":Neorg sync-parsers",
		opts = {
			load = {
				["core.defaults"] = {},
				["core.concealer"] = { config = { folds = false, icon_preset = "diamond" } },
				["core.integrations.nvim-cmp"] = {},
				["core.completion"] = { config = { engine = "nvim-cmp" } },
			},
		},
		dependencies = { { "nvim-lua/plenary.nvim" } },
	},
}
