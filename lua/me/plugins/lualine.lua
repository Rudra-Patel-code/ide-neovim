local M = {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons", -- icons
		"AndreM222/copilot-lualine", -- Copilot status
	},
}

function M.config()
	local lazy_status = require("lazy.status")

	-- Tokyonight-inspired custom colors (transparent friendly)
	local colors = {
		bg = "none",
		fg = "#c0caf5",
		yellow = "#e0af68",
		cyan = "#7dcfff",
		darkblue = "#1a1b26",
		green = "#9ece6a",
		orange = "#ff9e64",
		violet = "#bb9af7",
		magenta = "#c678dd",
		blue = "#7aa2f7",
		red = "#f7768e",
	}

	local theme = {
		normal = {
			a = { fg = colors.bg, bg = colors.blue, gui = "bold" },
			b = { fg = colors.fg, bg = colors.darkblue },
			c = { fg = colors.fg, bg = colors.bg },
		},
		insert = {
			a = { fg = colors.bg, bg = colors.green, gui = "bold" },
			b = { fg = colors.fg, bg = colors.darkblue },
			c = { fg = colors.fg, bg = colors.bg },
		},
		visual = {
			a = { fg = colors.bg, bg = colors.magenta, gui = "bold" },
			b = { fg = colors.fg, bg = colors.darkblue },
			c = { fg = colors.fg, bg = colors.bg },
		},
		replace = {
			a = { fg = colors.bg, bg = colors.red, gui = "bold" },
			b = { fg = colors.fg, bg = colors.darkblue },
			c = { fg = colors.fg, bg = colors.bg },
		},
		command = {
			a = { fg = colors.bg, bg = colors.yellow, gui = "bold" },
			b = { fg = colors.fg, bg = colors.darkblue },
			c = { fg = colors.fg, bg = colors.bg },
		},
		inactive = {
			a = { fg = colors.fg, bg = colors.bg, gui = "bold" },
			b = { fg = colors.fg, bg = colors.bg },
			c = { fg = colors.fg, bg = colors.bg },
		},
	}

	require("lualine").setup({
		options = {
			theme = theme,
			icons_enabled = true,
			component_separators = { left = "", right = "" },
			section_separators = { left = "", right = "" },
			disabled_filetypes = { statusline = { "alpha", "dashboard", "starter" } },
			ignore_focus = { "NvimTree" },
			always_divide_middle = true,
			globalstatus = true,
		},
		sections = {
			lualine_a = { { "mode", icon = "" } },
			lualine_b = { { "branch", icon = "" }, "diff" },
			lualine_c = {
				{
					"diagnostics",
					sources = { "nvim_diagnostic" },
					symbols = { error = " ", warn = " ", info = " ", hint = " " },
				},
				{
					"filename",
					path = 1,
					symbols = {
						modified = " [+]",
						readonly = " [-]",
						unnamed = "[No Name]",
						newfile = "[New]",
					},
				},
			},
			lualine_x = {
				{
					"copilot",
					show_running = true,
					symbols = {
						status = { enabled = "", disabled = "" },
						spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
					},
				},
				{
					lazy_status.updates,
					cond = lazy_status.has_updates,
					color = { fg = colors.orange },
				},
				{ "encoding" },
				{ "fileformat", symbols = { unix = "", dos = "", mac = "" } },
				{ "filetype", icon_only = false },
			},
			lualine_y = { "progress" },
			lualine_z = { { "location", icon = "" } },
		},
		extensions = { "quickfix", "fugitive", "man", "nvim-tree", "toggleterm" },
	})
end

return M
