local M = {
	{
		"numToStr/Comment.nvim",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			padding = true,
			sticky = true,
			ignore = nil,
			toggler = {
				line = "gcc",
				block = "gbc",
			},
			opleader = {
				line = "gc",
				block = "gb",
			},
			extra = {
				above = "gcO",
				below = "gco",
				eol = "gcA",
			},
			mappings = {
				basic = true,
				extra = true,
			},
			pre_hook = nil,
			post_hook = nil,
		},
		config = function(_, opts)
			require("Comment").setup(opts)
		end,
	},

	{
		"kylechui/nvim-surround",
		event = "VeryLazy",
		version = "^3.0.0",
		config = function()
			require("nvim-surround").setup({})
		end,
	},

	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			local npairs = require("nvim-autopairs")
			npairs.setup({
				check_ts = true,
				disable_filetype = { "TelescopePrompt", "spectre_panel", "snacks_picker_input" },
			})

			local cmp_status_ok, cmp = pcall(require, "cmp")
			if cmp_status_ok then
				local cmp_autopairs = require("nvim-autopairs.completion.cmp")
				cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
			end
		end,
	},
}
return M
