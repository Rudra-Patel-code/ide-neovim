
-- File: lua/me/plugins/leap-flash.lua

local M = {
  { -- Leap setup
    "ggandor/leap.nvim",
    event = "VeryLazy",
    dependencies = {
      "tpope/vim-repeat",
    },
    config = function()
      local leap = require("leap")
      leap.add_default_mappings()

      -- Equivalence classes for more intuitive navigation
      leap.opts.equivalence_classes = { ' \\t\\r\\n', '([{', ')]}', '\'\"`' }

      -- Treesitter incremental node selection
      vim.keymap.set({ 'n', 'x', 'o' }, 'ga', function()
        require('leap.treesitter').select()
      end, { desc = "Leap Treesitter Select" })

      vim.keymap.set({ 'n', 'x', 'o' }, 'gA', 'V<cmd>lua require("leap.treesitter").select()<cr>', { desc = "Leap Treesitter Select Linewise" })

      -- Optional preview filter for cleaner label display
      leap.opts.preview_filter = function(ch0, ch1, ch2)
        return not (
          ch1:match('%s') or
          ch0:match('%w') and ch1:match('%w') and ch2:match('%w')
        )
      end
    end,
  },

  { -- Flash setup
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
      labels = "asdfghjklqwertyuiopzxcvbnm",
      label = {
        rainbow = {
          enabled = true,
          shade = 6,
        },
      },
      modes = {
        char = {
          jump_labels = true,
        },
        treesitter = {
          labels = "abcdefghijklmnopqrstuvwxyz",
          jump = { pos = "range", autojump = true },
          label = { before = true, after = true, style = "inline" },
        },
        remote = {
          remote_op = {
            restore = true,
            motion = true,
          },
        },
      },
    },
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<C-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },
}

return M
