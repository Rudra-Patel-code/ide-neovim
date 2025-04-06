-- File: lua/me/plugins/zen-mode.lua

local M = {
	"folke/zen-mode.nvim",
	cmd = "ZenMode",
	keys = {
		{ "<leader>z", "<cmd>ZenMode<cr>", desc = "Toggle Zen Mode" },
	},
}

function M.config()
	require("zen-mode").setup({
		window = {
			backdrop = 0.95,
			width = 120,
			height = 1,
			options = {
				-- signcolumn = "no",
				-- number = false,
				-- relativenumber = false,
				-- cursorline = false,
				-- cursorcolumn = false,
				-- foldcolumn = "0",
				-- list = false,
			},
		},
		plugins = {
			options = {
				enabled = true,
				ruler = false,
				showcmd = false,
				laststatus = 0,
			},
			twilight = { enabled = true },
			gitsigns = { enabled = false },
			tmux = { enabled = false },
			kitty = { enabled = false },
			alacritty = { enabled = false },
			wezterm = { enabled = false },
			neovide = {
				enabled = false,
				scale = 1.2,
				disable_animations = {
					neovide_animation_length = 0,
					neovide_cursor_animate_command_line = false,
					neovide_scroll_animation_length = 0,
					neovide_position_animation_length = 0,
					neovide_cursor_animation_length = 0,
					neovide_cursor_vfx_mode = "",
				},
			},
		},
		on_open = function(win) end,
		on_close = function() end,
	})

	-- Register key with which-key
	-- local wk = require("which-key")
	-- wk.register({
	-- 	["<leader>z"] = { "<cmd>ZenMode<cr>", "Toggle Zen Mode" },
	-- }, { mode = "n" })
end

return M
