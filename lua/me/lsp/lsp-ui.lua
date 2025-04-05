

local M = {
  -- Live rename with preview
  {
    "smjonas/inc-rename.nvim",
    event = "LspAttach",
    cmd = "IncRename",
    config = function()
      require("inc_rename").setup({
        input_buffer_type = "dressing", -- Optional: use dressing.nvim for better UI
      })

      vim.keymap.set("n", "<leader>rn", function()
        return ":IncRename " .. vim.fn.expand("<cword>")
      end, { expr = true, desc = "LSP: Rename symbol" })
    end,
  },

  -- Code action preview window
  {
    "aznhe21/actions-preview.nvim",
    event = "LspAttach",
    config = function()
      require("actions-preview").setup({
        backend = { "telescope", "nui" },
        diff = {
          ctxlen = 5,
          algorithm = "patience",
        },
      })

      vim.keymap.set({ "n", "v" }, "<leader>ca", require("actions-preview").code_actions, { desc = "LSP: Code Actions Preview" })
    end,
  },

  -- Virtual inlay types (inferred types)
}

return M
