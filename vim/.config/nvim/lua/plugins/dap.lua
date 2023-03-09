return {
	{
		"jay-babu/mason-nvim-dap.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"mfussenegger/nvim-dap",
		},
		config = function()
			require("mason-nvim-dap").setup({
				ensure_installed = { "js" },
				automatic_setup = true,
			})
			require("mason-nvim-dap").setup_handlers({})
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			{
				"mfussenegger/nvim-dap",
				config = function()
					vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "", linehl = "", numhl = "" })
				end,
				keys = {
					{
						"<Leader>il",
						function()
							require("dap").step_into()
						end,
						desc = "DAP step_into",
					},
					{
						"<Leader>ij",
						function()
							require("dap").step_over()
						end,
						desc = "DAP setp_over",
					},
					{
						"<Leader>ik",
						function()
							require("dap").step_out()
						end,
						desc = "DAP step_out",
					},
					{
						"<Leader>ib",
						function()
							require("dap").toggle_breakpoint()
						end,
						desc = "DAP breakpoint",
					},
					{
						"<Leader>ir",
						function()
							require("dap").run_last()
						end,
						desc = "DAP run last",
					},
					{
						"<Leader>ip",
						function()
							require("dap.ui.widgets").preview()
						end,
						desc = "DAP preview",
					},
				},
			},
		},
		config = true,
		keys = {
			{
				"<Leader>ii",
				function()
					require("dap").continue()
					require("dapui").open()
				end,
				desc = "DAP Continue",
			},
			{
				"<Leader>io",
				function()
					require("dapui").toggle()
				end,
				desc = "DAP toggle",
			},
			{
				"<Leader>ic",
				function()
					require("dap").close()
					require("dapui").close()
				end,
				desc = "DAP quit",
			},
			{
				"<Leader>ih",
				function()
					require("dapui").eval()
				end,
				desc = "DAP hover",
			},
		},
	},

	{
		"mxsdev/nvim-dap-vscode-js",
		dependencies = { "mfussenegger/nvim-dap" },
		config = function()
			require("dap-vscode-js").setup({
				debugger_cmd = { "js-debug-adapter" },
				adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
			})

			for _, language in ipairs({ "typescript", "javascript" }) do
				require("dap").configurations[language] = {
					{
						type = "pwa-node",
						request = "launch",
						name = "Launch file",
						program = "${file}",
						cwd = "${workspaceFolder}",
					},
					{
						type = "pwa-node",
						request = "attach",
						name = "Attach",
						processId = require("dap.utils").pick_process,
						cwd = "${workspaceFolder}",
					},
					{
						type = "pwa-node",
						request = "launch",
						name = "Jest Workspace",
						-- trace = true, -- include debugger info
						runtimeExecutable = "node",
						runtimeArgs = {
							"./node_modules/jest/bin/jest.js",
							"--runInBand",
						},
						rootPath = "${workspaceFolder}",
						cwd = "${workspaceFolder}",
						console = "integratedTerminal",
						internalConsoleOptions = "neverOpen",
					},
					{
						type = "pwa-node",
						request = "launch",
						name = "Jest File",
						runtimeExecutable = "node",
						runtimeArgs = {
							"./node_modules/jest/bin/jest.js",
							"--runInBand",
							"${file}",
						},
						rootPath = "${workspaceFolder}",
						cwd = "${workspaceFolder}",
						console = "integratedTerminal",
						internalConsoleOptions = "neverOpen",
					},
				}
			end
		end,
	},
}
