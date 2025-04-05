
-- editing.lua
-- Plugin: numToStr/Comment.nvim
-- Plugin: kylechui/nvim-surround
-- Plugin: gbprod/substitute.nvim
-- Plugin: windwp/nvim-autopairs

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
    "gbprod/substitute.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      local substitute = require("substitute")
      substitute.setup({})

      vim.keymap.set("n", "s", substitute.operator, { noremap = true, desc = "Substitute with motion" })
      vim.keymap.set("n", "ss", substitute.line, { noremap = true, desc = "Substitute entire line" })
      vim.keymap.set("n", "S", substitute.eol, { noremap = true, desc = "Substitute to end of line" })
      vim.keymap.set("x", "s", substitute.visual, { noremap = true, desc = "Substitute in visual mode" })

      vim.keymap.set("n", "sx", require("substitute.exchange").operator, { noremap = true, desc = "Exchange with motion" })
      vim.keymap.set("n", "sxx", require("substitute.exchange").line, { noremap = true, desc = "Exchange line" })
      vim.keymap.set("x", "X", require("substitute.exchange").visual, { noremap = true, desc = "Exchange visual selection" })
      vim.keymap.set("n", "sxc", require("substitute.exchange").cancel, { noremap = true, desc = "Cancel exchange" })
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

      -- Integration with nvim-cmp if available
      local cmp_status_ok, cmp = pcall(require, "cmp")
      if cmp_status_ok then
        local cmp_autopairs = require("nvim-autopairs.completion.cmp")
        cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
      end
    end,
  },
}
 return M
