local M = {
	"nvim-tree/nvim-tree.lua",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	event = "VeryLazy",
}

function M.config()
	-- Disable netrw (recommended by nvim-tree)
	vim.g.loaded_netrw = 1
	vim.g.loaded_netrwPlugin = 1

	require("nvim-tree").setup({
		hijack_netrw = true,
		sync_root_with_cwd = true,
		respect_buf_cwd = true,

		view = {
			width = 30,
			relativenumber = true,
			signcolumn = "yes",
		},

		renderer = {
			root_folder_label = ":~:s?$??",
			highlight_git = true,
			highlight_opened_files = "name",
			indent_markers = {
				enable = true,
				inline_arrows = true,
				icons = {
					corner = "└",
					edge = "│",
					item = "│",
					none = " ",
				},
			},
			icons = {
				webdev_colors = true,
				git_placement = "before",
				padding = " ",
				symlink_arrow = " ➛ ",
			},
		},

		filters = {
			dotfiles = false,
			custom = { ".DS_Store", "node_modules" },
		},

		git = {
			enable = true,
			ignore = false,
			timeout = 500,
		},

		diagnostics = {
			enable = true,
			show_on_dirs = false,
			show_on_open_dirs = true,
			debounce_delay = 50,
			severity = {
				min = vim.diagnostic.severity.HINT,
				max = vim.diagnostic.severity.ERROR,
			},
		},

		actions = {
			open_file = {
				quit_on_open = false,
				resize_window = true,
				window_picker = {
					enable = false,
				},
			},
		},

		update_focused_file = {
			enable = true,
			update_root = true,
			ignore_list = {},
		},
	})
	--
	-- vim.api.nvim_create_autocmd("ColorScheme", {
	-- 	pattern = "*",
	-- 	callback = function()
	-- 		vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "#1e222a" })
	-- 		vim.api.nvim_set_hl(0, "NvimTreeNormalNC", { bg = "#1e222a" })
	-- 		vim.api.nvim_set_hl(0, "NvimTreeEndOfBuffer", { bg = "#1e222a" })
	-- 	end,
	-- }) -- Keymaps

	local map = vim.keymap.set
	local opts = { noremap = true, silent = true, desc = "[NvimTree]" }

	map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", vim.tbl_extend("force", opts, { desc = "Toggle Explorer" }))
	map(
		"n",
		"<leader>ef",
		"<cmd>NvimTreeFindFileToggle<CR>",
		vim.tbl_extend("force", opts, { desc = "Find Current File" })
	)
	map("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", vim.tbl_extend("force", opts, { desc = "Refresh Explorer" }))
	map("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", vim.tbl_extend("force", opts, { desc = "Collapse Explorer" }))

	-- Force solid background for nvim-tree even with transparent theme
	-- vim.defer_fn(function()
	-- 	vim.cmd([[
 --    highlight! NvimTreeNormal guibg=#1e222a
 --    highlight! NvimTreeNormalNC guibg=#1e222a
 --    highlight! NvimTreeEndOfBuffer guibg=#1e222a
 --  ]])
	-- end, 100)
	--
end

return M
