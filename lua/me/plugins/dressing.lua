-- File: lua/me/plugins/dressing.lua

local M = {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    opts = {
      input = {
        enabled = true,
        default_prompt = "Input",
        trim_prompt = true,
        title_pos = "left",
        start_mode = "insert",
        border = "rounded",
        relative = "cursor",
        prefer_width = 40,
        max_width = { 140, 0.9 },
        min_width = { 20, 0.2 },
        win_options = {
          wrap = false,
          list = true,
          listchars = "precedes:…,extends:…",
          sidescrolloff = 0,
          winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
        },
        mappings = {
          n = {
            ["<Esc>"] = "Close",
            ["<CR>"] = "Confirm",
          },
          i = {
            ["<C-c>"] = "Close",
            ["<CR>"] = "Confirm",
            ["<Up>"] = "HistoryPrev",
            ["<Down>"] = "HistoryNext",
          },
        },
      },
  
      select = {
        enabled = true,
        backend = { "telescope", "fzf_lua", "fzf", "builtin", "nui" },
        trim_prompt = true,
  
        telescope = require("telescope.themes").get_dropdown({}),
  
        fzf = {
          window = {
            width = 0.5,
            height = 0.4,
          },
        },
  
        nui = {
          position = "50%",
          relative = "editor",
          border = {
            style = "rounded",
          },
          buf_options = {
            swapfile = false,
            filetype = "DressingSelect",
          },
          win_options = {
            winblend = 0,
          },
          max_width = 80,
          max_height = 40,
          min_width = 40,
          min_height = 10,
        },
  
        builtin = {
          show_numbers = true,
          border = "rounded",
          relative = "editor",
          win_options = {
            cursorline = true,
            cursorlineopt = "both",
            winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
          },
          max_width = { 140, 0.8 },
          min_width = { 40, 0.2 },
          max_height = 0.9,
          min_height = { 10, 0.2 },
          mappings = {
            ["<Esc>"] = "Close",
            ["<C-c>"] = "Close",
            ["<CR>"] = "Confirm",
          },
        },
  
        format_item_override = {},
  
        get_config = function(opts)
          -- Customize code action picker
          if opts.kind == "codeaction" then
            return {
              backend = "nui",
              nui = {
                relative = "cursor",
                max_width = 40,
              },
            }
          end
        end,
      },
    },
  }
  
  return M
  