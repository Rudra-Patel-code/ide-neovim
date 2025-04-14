local M = {
	"williamboman/mason-lspconfig.nvim",
	dependencies = {
		"williamboman/mason.nvim",
		"neovim/nvim-lspconfig",
	},
	event = { "BufReadPre", "BufNewFile" },
}

function M.config()
	require("mason").setup({
		ui = {
			border = "rounded",
		},
	})
	local mason_lspconfig = require("mason-lspconfig")
	local navic = require("nvim-navic")

	local on_attach = function(client, bufnr)
		if client.server_capabilities.documentSymbolProvider then
			navic.attach(client, bufnr)
		end
	end

	mason_lspconfig.setup({
		-- Automatically install these LSP servers if they're not already installed
		ensure_installed = {
			"lua_ls",
			"pyright",
			"ts_ls",
			"html",
			"cssls",
			"jsonls",
			"clangd",
			"bashls",
			"jdtls",
		},

		-- Automatically install any LSP servers set up via lspconfig
		automatic_installation = true,

		-- Optional: hook into each server setup for custom configurations
		handlers = {
			-- Default handler (applies to all servers)
			function(server_name)
				require("lspconfig")[server_name].setup({
					on_attach = on_attach,
				})
			end,

			-- Example: Customize Lua LS settings
			["lua_ls"] = function()
				require("lspconfig").lua_ls.setup({
					on_attach = on_attach,
					settings = {
						Lua = {
							diagnostics = {
								globals = { "vim" },
							},
							workspace = {
								checkThirdParty = false,
							},
						},
					},
				})
			end,

			["ts_ls"] = function()
				require("lspconfig").tsserver.setup({
					on_attach = function(client, bufnr)
						local navic = require("nvim-navic")
						if client.server_capabilities.documentSymbolProvider then
							navic.attach(client, bufnr)
						end
						if client.server_capabilities.inlayHintProvider then
							vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
						end
					end,
					settings = {
						typescript = {
							inlayHints = {
								includeInlayParameterNameHints = "all", -- ✅ Force param hints
								includeInlayParameterNameHintsWhenArgumentMatchesName = false,
								includeInlayFunctionParameterTypeHints = true,
								includeInlayVariableTypeHints = true,
								includeInlayPropertyDeclarationTypeHints = true,
								includeInlayFunctionLikeReturnTypeHints = true,
								includeInlayEnumMemberValueHints = true,
							},
						},
						javascript = {
							inlayHints = {
								includeInlayParameterNameHints = "all",
								includeInlayParameterNameHintsWhenArgumentMatchesName = false,
								includeInlayFunctionParameterTypeHints = true,
								includeInlayVariableTypeHints = true,
								includeInlayPropertyDeclarationTypeHints = true,
								includeInlayFunctionLikeReturnTypeHints = true,
								includeInlayEnumMemberValueHints = true,
							},
						},
					},
				})
			end,
		},
	})
end

return M
