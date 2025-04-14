-- File: lua/me/plugins/formatting.lua

local M = {
	{
		"mfussenegger/nvim-lint",
		event = { "BufWritePost", "BufReadPost", "InsertLeave" },
		config = function()
			local lint = require("lint")

			lint.linters.eslint_d_with_fallback = {
				cmd = "eslint_d",
				stdin = true,
				args = {
					"--stdin",
					"--stdin-filename",
					function()
						return vim.api.nvim_buf_get_name(0)
					end,
					function()
						local config_files = {
							".eslintrc",
							".eslintrc.js",
							".eslintrc.cjs",
							".eslintrc.json",
							"eslint.config.js", -- Flat config
						}

						local util = require("lint.util")
						local found = util.find_file(config_files, vim.fn.getcwd())

						if not found then
							return "--config=/home/rudra/.config/nvim/eslint.config.js"
						end
						return nil
					end,
				},
				stream = "stdout",
				ignore_exitcode = true,
			}

			lint.linters_by_ft = {
				javascript = { "eslint_d_with_fallback" },
				typescript = { "eslint_d_with_fallback" },
				javascriptreact = { "eslint_d_with_fallback" },
				typescriptreact = { "eslint_d_with_fallback" },
				python = { "flake8" },
				markdown = { "markdownlint" },
				sh = { "shellcheck" },
			}

			vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
				callback = function()
					lint.try_lint()
				end,
			})
		end,
	},

	{
		"mhartington/formatter.nvim",
		cmd = { "Format", "FormatWrite" },
		event = { "BufWritePre" },
		config = function()
			require("formatter").setup({
				logging = false,
				filetype = {
					javascript = { require("formatter.filetypes.javascript").prettier },
					typescript = { require("formatter.filetypes.typescript").prettier },
					javascriptreact = { require("formatter.filetypes.javascriptreact").prettier },
					typescriptreact = { require("formatter.filetypes.typescriptreact").prettier },
					css = { require("formatter.filetypes.css").prettier },
					html = { require("formatter.filetypes.html").prettier },
					json = { require("formatter.filetypes.json").prettier },
					lua = { require("formatter.filetypes.lua").stylua },
					python = { require("formatter.filetypes.python").black },
					sh = { require("formatter.filetypes.sh").shfmt },
					markdown = { require("formatter.filetypes.markdown").prettier },
					["*"] = {
						require("formatter.filetypes.any").remove_trailing_whitespace,
					},
				},
			})

			-- Format on save
			vim.api.nvim_create_autocmd("BufWritePre", {
				pattern = "*",
				command = "silent! FormatWrite",
			})
		end,
	},
}

return M
