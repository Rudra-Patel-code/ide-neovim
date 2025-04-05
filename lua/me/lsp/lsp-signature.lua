local M = {
  "ray-x/lsp_signature.nvim",
  event = "InsertEnter",
  opts = function()
    local icons = require("mini.icons").lsp or {}

    return {
      bind = true,
      floating_window = true,
      floating_window_above_cur_line = true,
      floating_window_off_x = 1,
      floating_window_off_y = 0,
      handler_opts = {
        border = "rounded",
      },
      hint_enable = true,
      hint_prefix = icons.param or " ",
      hi_parameter = "IncSearch",
      hint_scheme = "String",
      max_height = 12,
      max_width = function()
        return math.floor(vim.api.nvim_win_get_width(0) * 0.8)
      end,
      wrap = true,
      close_timeout = 4000,
      fix_pos = false,
      always_trigger = false,
      extra_trigger_chars = {},
      zindex = 200,
      padding = " ",
      transparency = nil,
      shadow_blend = 36,
      shadow_guibg = "Black",
      timer_interval = 200,
      toggle_key = nil,
      toggle_key_flip_floatwin_setting = false,
      select_signature_key = nil,
      move_signature_window_key = nil,
      move_cursor_key = nil,
      keymaps = {},
    }
  end,
}

return M
