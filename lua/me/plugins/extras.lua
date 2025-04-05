local M = {
	{ "nvim-lua/plenary.nvim" },
	{
		-- 🪟 Maximize and restore splits
		"szw/vim-maximizer",
		lazy = false, -- load immediately
		keys = {
			{ "<leader>sm", "<cmd>MaximizerToggle<CR>", mode = { "n", "v", "i" }, desc = "Toggle Maximizer" },
		},
		init = function()
			vim.g.maximizer_set_default_mapping = 0 -- disable plugin's default mappings
		end,
	},

	{
		"declancm/cinnamon.nvim",
		event = "VeryLazy",
		config = function()
			require("cinnamon").setup({
				keymaps = {
					basic = true, -- replaces deprecated 'default_keymaps'
					extra = true, -- replaces 'extra_keymaps' and 'extended_keymaps'
				},
				options = {
					mode = "window",
					max_delta = {
						time = 500, -- replaces 'max_length'
						line = 150, -- replaces 'scroll_limit'
					},
				},
			})
		end,
	},
}

return M
