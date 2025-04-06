local M = {
	"sudormrfbin/cheatsheet.nvim",
	dependencies = {
		{ "nvim-telescope/telescope.nvim" },
		{ "nvim-lua/popup.nvim" },
		{ "nvim-lua/plenary.nvim" },
	},
}

function M.config()
	require("cheatsheet").setup({
		bundled_cheatsheets = {
			enabled = { "default", "lua", "markdown", "regex", "bash", "python" },
		},
		bundled_plugin_cheatsheets = {
			enabled = { "telescope.nvim", "gitsigns.nvim", "nvim-cmp" },
		},
	})
end

return M
