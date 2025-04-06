-- notify.lua
local M = {
	"rcarriga/nvim-notify",
	event = "VeryLazy",
	config = function()
		local notify = require("notify")

		vim.notify = notify

		notify.setup({
			background_colour = "#1a1b26",
			fps = 60,
			icons = {
				ERROR = "",
				WARN = "",
				INFO = "",
				DEBUG = "",
				TRACE = "✎",
			},
			level = vim.log.levels.INFO,
			minimum_width = 40,
			max_width = 80,
			render = "wrapped-compact",
			stages = "fade_in_slide_out",
			timeout = 3000,
			top_down = true,
		})

		local has_telescope, telescope = pcall(require, "telescope")
		if has_telescope then
			telescope.load_extension("notify")
		end
	end,
}

return M
