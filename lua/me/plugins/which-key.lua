-- File: lua/me/plugins/which-key.lu
-- File: lua/me/plugins/which-key.lua
-- Description: Complete which-key configuration with all keymaps registered (including all modes and plugins)

return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	config = function()
		local wk = require("which-key")

		wk.setup({
			plugins = {
				marks = true,
				registers = true,
				spelling = { enabled = true, suggestions = 20 },
				presets = {
					operators = true,
					motions = true,
					text_objects = true,
					windows = true,
					nav = true,
					z = true,
					g = true,
				},
			},
		})

		wk.register({
			{ "<leader>e", group = "Explorer" },
			{ "<leader>e", "<cmd>NvimTreeToggle<CR>", desc = "Toggle Explorer", mode = "n" },
			{ "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", desc = "Find Current File", mode = "n" },
			{ "<leader>er", "<cmd>NvimTreeRefresh<CR>", desc = "Refresh Explorer", mode = "n" },
			{ "<leader>ec", "<cmd>NvimTreeCollapse<CR>", desc = "Collapse Explorer", mode = "n" },
		})

		wk.register({
			{ "<leader>t", group = "Tabs and Toggle Terminal" },
			{ "<leader>to", "<cmd>tabnew<CR>", desc = "Open new tab", mode = "n" },
			{ "<leader>tx", "<cmd>tabclose<CR>", desc = "Close current tab", mode = "n" },
			{ "<leader>tn", "<cmd>tabn<CR>", desc = "Go to next tab", mode = "n" },
			{ "<leader>tp", "<cmd>tabp<CR>", desc = "Go to previous tab", mode = "n" },
			{ "<leader>tf", "<cmd>tabnew %<CR>", desc = "Open current buffer in new tab", mode = "m" },
			{ "<leader>tt", "<cmd>ToggleTerm<CR>", desc = "Toggle terminal (float)", mode = "n" },
			{ "<leader>tv", "<cmd>ToggleTerm direction=vertical<CR>", desc = "Toggle vertical terminal", mode = "n" },
			{
				"<leader>th",
				"<cmd>ToggleTerm direction=horizontal<CR>",
				desc = "Toggle horizontal terminal",
				mode = "n",
			},
			{ "<leader>tg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", desc = "Toggle Lazygit", mode = "n" },
			{ "<leader>tn", "<cmd>lua _NODE_TOGGLE()<CR>", desc = "Toggle Node REPL", mode = "n" },
		})


        -- None leader key maps
wk.register({{
            			{ "<Esc>", [[<C-\><C-n>]], desc = "Terminal mode to normal mode", mode = "t" },

        }})
	end,
}
