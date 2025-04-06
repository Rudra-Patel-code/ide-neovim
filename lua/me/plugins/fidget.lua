
-- File: lua/me/plugins/fidget.lua

local M = {
  "j-hui/fidget.nvim",
  event = "LspAttach",
  opts = {
    progress = {
      suppress_on_insert = false,
      ignore_done_already = true,
      display = {
        render_limit = 10,
        done_icon = "✔",
        progress_icon = { "dots" },
        group_style = "Title",
        icon_style = "Question",
        done_style = "Constant",
        progress_style = "WarningMsg",
        skip_history = false,
      },
    },
    notification = {
      override_vim_notify = false,
      filter = vim.log.levels.INFO,
      view = {
        stack_upwards = true,
        group_separator = "---",
        group_separator_hl = "Comment",
      },
      window = {
        border = "rounded",
        winblend = 0,
        zindex = 45,
        align = "bottom",
        relative = "editor",
      },
    },
    integration = {
      ["nvim-tree"] = { enable = true },
    },
  },
}

return M
