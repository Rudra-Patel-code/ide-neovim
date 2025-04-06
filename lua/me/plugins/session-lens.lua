
-- File: lua/me/plugins/session-lens.lua
local M = {
  "rmagatti/session-lens",
  dependencies = { "nvim-telescope/telescope.nvim" },
  lazy = true,
  config = function()
    require("session-lens").setup({
      path_display = { "shorten" },
      previewer = true,
    })
  end,
}

return M
