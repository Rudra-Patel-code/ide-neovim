local M = {
	"rmagatti/session-lens",
	dependencies = {
		"rmagatti/auto-session",
		"nvim-telescope/telescope.nvim",
	},
	config = function()
		require("session-lens").setup({
			path_display = { "shorten" },
			previewer = true,
		})

		-- Load telescope extension
		pcall(function()
			require("telescope").load_extension("session-lens")
		end)
	end,
}

return M
