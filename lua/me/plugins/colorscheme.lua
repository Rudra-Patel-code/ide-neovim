-- local M = {
-- 	"folke/tokyonight.nvim",
-- 	lazy = false,
-- 	priority = 1000,
-- }
--
-- function M.config()
-- 	require("tokyonight").setup({
-- 		style = "night", -- options: "storm", "night", "moon", "day"
-- 		transparent = false,
-- 		terminal_colors = true,
--
-- 		styles = {
-- 			comments = { italic = true },
-- 			keywords = { italic = true },
-- 			functions = {},
-- 			variables = {},
-- 			sidebars = "transparent",
-- 			floats = "transparent",
-- 		},
-- 		sidebars = { "qf", "help", "terminal", "packer", "spectre_panel", "snacks" },
-- 		dim_inactive = false,
-- 		lualine_bold = true,
-- 	})
--
-- 	vim.cmd.colorscheme("tokyonight")
-- end

-- lua/plugins/rose-pine.lua
--
--
--
--
--
--
--
--
-- local M = {
-- 	"rose-pine/neovim",
-- 	name = "rose-pine",
-- 	config = function()
-- 		vim.cmd("colorscheme rose-pine")
-- 	end,
-- }
--

local M = {
    "tiagovla/tokyodark.nvim",
    opts = {
        -- custom options here
    },
    config = function(_, opts)
        require("tokyodark").setup(opts) -- calling setup is optional
        vim.cmd [[colorscheme tokyodark]]
    end,
}
return M
