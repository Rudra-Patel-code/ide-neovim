-- File: lua/me/plugins/toggleterm.lua

local M = {
	"akinsho/toggleterm.nvim",
	version = "*",
	event = "VeryLazy",
}

function M.config()
	require("toggleterm").setup({
		size = function(term)
			if term.direction == "horizontal" then
				return 12
			elseif term.direction == "vertical" then
				return vim.o.columns * 0.4
			end
		end,
		open_mapping = [[<C-\>]],
		hide_numbers = true,
		shade_filetypes = {},
		shade_terminals = true,
		shading_factor = 1,
		start_in_insert = true,
		insert_mappings = true,
		persist_size = true,
		direction = "float", -- Default direction
		close_on_exit = true,
		shell = vim.o.shell,
		float_opts = {
			border = "rounded",
			winblend = 3,
			highlights = {
				border = "FloatBorder",
				background = "NormalFloat",
			},
		},
	})

	local Terminal = require("toggleterm.terminal").Terminal

	-- Lazygit terminal
	local lazygit = Terminal:new({
		cmd = "lazygit",
		hidden = true,
		direction = "float",
		float_opts = { border = "double" },
	})

	function _LAZYGIT_TOGGLE()
		lazygit:toggle()
	end

	local float_term = Terminal:new({ cmd = "zsh", hidden = true, direction = "float", count = 1 })
	function _FLOAT_TERM_TOGGLE()
		float_term:toggle()
	end

	-- Vertical Terminal
	local vertical_term = Terminal:new({ cmd = "zsh", hidden = true, direction = "vertical", count = 2 })
	function _VERTICAL_TERM_TOGGLE()
		vertical_term:toggle()
	end

	-- Horizontal Terminal
	local horizontal_term = Terminal:new({ cmd = "zsh", hidden = true, direction = "horizontal", count = 3 })
	function _HORIZONTAL_TERM_TOGGLE()
		horizontal_term:toggle()
	end

	-- Keymaps
	-- local map = vim.keymap.set
	-- map("n", "<leader>tt", "<cmd>ToggleTerm<CR>", { desc = "Toggle terminal (float)" })
	-- map("n", "<leader>tv", "<cmd>ToggleTerm direction=vertical<CR>", { desc = "Toggle vertical terminal" })
	-- map("n", "<leader>th", "<cmd>ToggleTerm direction=horizontal<CR>", { desc = "Toggle horizontal terminal" })
	-- map("n", "<leader>tg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", { desc = "Toggle Lazygit" })
	-- map("n", "<leader>tn", "<cmd>lua _NODE_TOGGLE()<CR>", { desc = "Toggle Node REPL" })
	-- map("n", "<leader>tp", "<cmd>lua _PYTHON_TOGGLE()<CR>", { desc = "Toggle Python REPL" })
	-- map("t", "<Esc>", [[<C-\><C-n>]], { desc = "Terminal mode to normal mode" })
end

return M
