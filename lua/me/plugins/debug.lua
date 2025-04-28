-- 📁 File: lua/plugins/dap-setup.lua
-- ✅ Combines dap-vscode-js, dap-ui, dap config, JS/TS/Python/Java/C debugging into one

local M = {
	"mfussenegger/nvim-dap",
	dependencies = {
		{ "rcarriga/nvim-dap-ui" },
		{ "theHamsta/nvim-dap-virtual-text" },
		{ "nvim-neotest/nvim-nio" },
		{ "mfussenegger/nvim-jdtls" },

		{
			"mxsdev/nvim-dap-vscode-js",
			config = function()
				require("dap-vscode-js").setup({
					debugger_path = vim.fn.stdpath("data") .. "/vscode-js-debug", -- this folder
					node_path = "node",
					adapters = { "pwa-node" }, -- or add others like pwa-chrome
					-- 🚫 NO debugger_cmd or debugger_cmd_fn needed now
				})
			end,
		},
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		-- 🔳 UI Setup
		dapui.setup({
			layouts = {
				{
					elements = {
						{ id = "scopes", size = 0.25 },
						{ id = "breakpoints", size = 0.25 },
						{ id = "stacks", size = 0.25 },
						{ id = "watches", size = 0.25 },
					},
					size = 40,
					position = "left",
				},
				{
					elements = {
						{ id = "repl", size = 0.5 },
						{ id = "console", size = 0.5 },
					},
					size = 10,
					position = "bottom",
				},
			},
			controls = { enabled = true, element = "repl" },
		})

		require("nvim-dap-virtual-text").setup({
			enabled = true,
			highlight_changed_variables = true,
			highlight_new_as_changed = true,
			show_stop_reason = true,
		})

		-- 📦 Auto-open/close UI
		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated["dapui_config"] = function()
			dapui.close()
		end
		dap.listeners.before.event_exited["dapui_config"] = function()
			dapui.close()
		end

		-- 🔧 Configurations

		-- 🐍 Python
		dap.adapters.python = {
			type = "executable",
			command = "python3",
			args = { "-m", "debugpy.adapter" },
		}
		dap.configurations.python = {
			{
				type = "python",
				request = "launch",
				name = "Launch file",
				program = "${file}",
				pythonPath = function()
					return "python3"
				end,
			},
		}

		-- 💻 C/C++ (lldb)
		dap.adapters.lldb = {
			type = "executable",
			command = "/usr/bin/lldb-vscode",
			name = "lldb",
		}
		dap.configurations.cpp = {
			{
				name = "Launch file",
				type = "lldb",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
				args = {},
			},
		}
		dap.configurations.c = dap.configurations.cpp

		-- 🔷 JavaScript / TypeScript
		dap.configurations.javascript = {
			{
				type = "pwa-node",
				request = "launch",
				name = "Launch Current File (Node)",
				program = "${file}",
				cwd = "${workspaceFolder}",
				sourceMaps = true,
				protocol = "inspector",
				console = "integratedTerminal",
			},
		}
		dap.configurations.typescript = dap.configurations.javascript

		-- ☕ Java
		dap.configurations.java = {
			{
				type = "java",
				request = "launch",
				name = "Launch Main Class",
				mainClass = function()
					return vim.fn.input("Main class: ")
				end,
				projectName = function()
					return vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
				end,
				cwd = vim.fn.getcwd(),
				console = "integratedTerminal",
			},
		}
	end,
}

return M
