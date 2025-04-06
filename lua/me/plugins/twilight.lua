-- File: lua/me/plugins/twilight.lua

local M = {
    "folke/twilight.nvim",
    event = "VeryLazy",
    opts = {
      dimming = {
        alpha = 0.25, -- amount of dimming
        color = { "Normal", "#ffffff" },
        term_bg = "#000000",
        inactive = false, -- dim other windows completely
      },
      context = 10, -- number of lines around the cursor to keep visible
      treesitter = true, -- use treesitter for better context awareness
      expand = {
        "function",
        "method",
        "table",
        "if_statement",
      },
      exclude = {}, -- filetypes to exclude
    },
    }


function M.config(_, opts)
  require("twilight").setup(opts)

      -- Register which-key for Twilight toggle
    --   local wk = require("which-key")
    --
    --   wk.register({
    --     ["<leader>u"] = {
    --       name = "+ui",
    --       t = { "<cmd>Twilight<cr>", "Toggle Twilight" },
    --     },
    --   }, { mode = "n" })
    end

  return M

