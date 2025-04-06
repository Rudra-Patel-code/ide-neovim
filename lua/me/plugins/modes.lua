-- File: lua/me/plugins/modes.lua

local M = {
	"mvllow/modes.nvim",
	version = "v0.2.1",
	event = "VeryLazy",
}

function M.config()
	require("modes").setup({
		colors = {
			copy = "#f5c359",
			delete = "#c75c6a",
			insert = "#78ccc5",
			visual = "#9745be",
		},
		line_opacity = 0.15,
		set_cursor = true,
		set_cursorline = true,
		set_number = true,
		ignore_filetypes = { "NvimTree", "TelescopePrompt" },
	})
end

return M
