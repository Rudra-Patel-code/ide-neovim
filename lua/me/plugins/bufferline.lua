local M = {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = {
      "nvim-tree/nvim-web-devicons", -- icons
    },
  }
  
  function M.config()
    vim.opt.termguicolors = true
  
    require("bufferline").setup({
      options = {
        mode = "buffers", -- or "tabs"
        style_preset = require("bufferline").style_preset.no_italic, -- no italic for better transparency feel
        themable = true,
        numbers = "ordinal", -- show buffer number
        close_command = "bdelete! %d", -- close with :bd
        right_mouse_command = "bdelete! %d",
        indicator = {
          style = "icon",
          icon = "▎",
        },
        buffer_close_icon = "󰅖",
        modified_icon = "●",
        close_icon = "",
        left_trunc_marker = "",
        right_trunc_marker = "",
  
        max_name_length = 25,
        max_prefix_length = 15,
        truncate_names = true,
  
        diagnostics = "nvim_lsp",
        diagnostics_update_in_insert = false,
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
          local icons = { error = " ", warning = " ", info = " " }
          local result = ""
          for type, icon in pairs(icons) do
            local n = diagnostics_dict[type]
            if n and n > 0 then
              result = result .. icon .. n .. " "
            end
          end
          return result
        end,
  
        offsets = {
          {
            filetype = "NvimTree",
            text = "File Explorer",
            highlight = "Directory",
            text_align = "left",
            separator = true,
          },
        },
  
        color_icons = true,
        show_buffer_icons = true,
        show_buffer_close_icons = true,
        show_close_icon = true,
        show_tab_indicators = true,
        persist_buffer_sort = true,
  
        separator_style = "thin", -- can be "slant" | "thick" | "thin" | { 'any', 'any' }
        enforce_regular_tabs = false,
        always_show_bufferline = true,
        hover = {
          enabled = true,
          delay = 200,
          reveal = { "close" },
        },
        sort_by = "insert_after_current",
      },
    })
  end
  
  return M
  