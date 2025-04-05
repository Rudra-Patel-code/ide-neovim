
-- File: lua/me/plugins/trouble.lua

local M = {
  "folke/trouble.nvim",
  cmd = "Trouble",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
    { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
    { "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Document Symbols (Trouble)" },
    { "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP Definitions/Refs (Trouble)" },
    { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
    { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
  },
  opts = {
    auto_open = false,
    auto_close = false,
    auto_preview = true,
    auto_refresh = true,
    auto_jump = false,
    focus = false,
    restore = true,
    follow = true,
    indent_guides = true,
    max_items = 200,
    multiline = true,
    pinned = false,
    warn_no_results = true,
    open_no_results = false,
    win = {},
    preview = {
      type = "main",
      scratch = true,
    },
    throttle = {
      refresh = 20,
      update = 10,
      render = 10,
      follow = 100,
      preview = { ms = 100, debounce = true },
    },
    icons = require("mini.icons").lsp or {},
  },
  config = function(_, opts)
    require("trouble").setup(opts)

    -- Telescope integration
    local trouble_telescope = require("trouble.sources.telescope").open
    local telescope = require("telescope")
    telescope.setup({
      defaults = {
        mappings = {
          i = { ["<C-t>"] = trouble_telescope },
          n = { ["<C-t>"] = trouble_telescope },
        },
      },
    })
  end,
}

return M
