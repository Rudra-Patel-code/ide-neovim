-- noice.lua

local M = {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
   
  }
  

  function M.config()
        require("noice").setup({
          lsp = {
            progress = {
              enabled = true,
              format = "lsp_progress",
              format_done = "lsp_progress_done",
              throttle = 1000 / 30,
              view = "mini",
            },
            override = {
              ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
              ["vim.lsp.util.stylize_markdown"] = true,
              ["cmp.entry.get_documentation"] = true,
            },
            hover = {
              enabled = true,
            },
            signature = {
              enabled = true,
            },
          },
    
          presets = {
            bottom_search = true,
            command_palette = true,
            long_message_to_split = true,
            inc_rename = true,
            lsp_doc_border = true,
          },
    
          messages = {
            enabled = true,
            view = "notify",
            view_error = "notify",
            view_warn = "notify",
            view_history = "messages",
            view_search = "virtualtext",
          },
    
          cmdline = {
            enabled = true,
            view = "cmdline_popup",
            format = {
              cmdline = { pattern = "^:", icon = "", lang = "vim" },
              search_down = { pattern = "/", icon = " ", lang = "regex" },
              search_up = { pattern = "?", icon = " ", lang = "regex" },
              lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "", lang = "lua" },
              help = { pattern = "^:%s*he?l?p?%s+", icon = "" },
              input = { view = "cmdline_input", icon = "󰥻 " },
            },
          },
    
          popupmenu = {
            enabled = true,
            backend = "nui",
            kind_icons = true,
          },
    
          notify = {
            enabled = true,
            view = "notify",
          },
    
          routes = {
            {
              view = "split",
              filter = { event = "msg_show", min_height = 20 },
            },
            {
              filter = { event = "msg_show", kind = "search_count" },
              opts = { skip = true },
            },
          },
    
          views = {
            cmdline_popup = {
              position = {
                row = 5,
                col = "50%",
              },
              size = {
                width = 60,
                height = "auto",
              },
              border = {
                style = "rounded",
              },
              win_options = {
                winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
              },
            },
          },
        })
    end


return M