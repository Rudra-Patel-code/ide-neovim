
-- File: lua/me/plugins/indentscope.lua

local M = {
  "echasnovski/mini.indentscope",
  version = "*",
  event = { "BufReadPre", "BufNewFile" },
}

function M.config()
  local indentscope = require("mini.indentscope")

  indentscope.setup({
    symbol = "│", -- Can also try "▏", "┆", "┊" for subtlety

    options = {
      indent_at_cursor = true,
      border = "both", -- draw lines both above and below the scope
    },

    draw = {
      delay = 10, -- Smoother animation speed (lower = faster)
      animation = indentscope.gen_animation.cubic({
        easing = "in-out",
        duration = 40,
        unit = "step",
      }),
    },
  })

  -- Highlight tweaks (for themes with transparency or poor contrast)
  vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { fg = "#5eacd3", nocombine = true })

  -- Exclude certain filetypes
  vim.api.nvim_create_autocmd("FileType", {
    pattern = {
      "help", "alpha", "dashboard", "NvimTree", "Trouble",
      "lazy", "mason", "TelescopePrompt", "toggleterm",
    },
    callback = function()
      vim.b.miniindentscope_disable = true
    end,
  })
end

return M
