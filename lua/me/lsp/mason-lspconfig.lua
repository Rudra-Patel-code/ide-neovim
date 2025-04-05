
local M = {
  "williamboman/mason-lspconfig.nvim",
  dependencies = {
    "williamboman/mason.nvim",
    "neovim/nvim-lspconfig",
  },
  event = { "BufReadPre", "BufNewFile" },
}

function M.config()
  local mason_lspconfig = require("mason-lspconfig")

  mason_lspconfig.setup({
    -- Automatically install these LSP servers if they're not already installed
    ensure_installed = {
      "lua_ls",
      "pyright",
      "typescript-language-server",
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
        require("lspconfig")[server_name].setup({})
      end,

      -- Example: Customize Lua LS settings
      ["lua_ls"] = function()
        require("lspconfig").lua_ls.setup({
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
    },
  })
end

return M
