-- File: lua/me/plugins/incline.lua

local M = {
    "b0o/incline.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "SmiteshP/nvim-navic",
      "rcarriga/nvim-notify",
      "folke/noice.nvim",
    },
    config = function()
      local devicons = require("nvim-web-devicons")
      local navic = require("nvim-navic")
      local helpers = require("incline.helpers")
  
      require("incline").setup({
        debounce_threshold = {
          falling = 50,
          rising = 10,
        },
        hide = {
          cursorline = false,
          focused_win = false,
          only_win = false,
        },
        highlight = {
          groups = {
            InclineNormal = { default = true, group = "NormalFloat" },
            InclineNormalNC = { default = true, group = "NormalFloat" },
          },
        },
        ignore = {
          buftypes = "special",
          filetypes = {},
          floating_wins = true,
          unlisted_buffers = true,
          wintypes = "special",
        },
        window = {
          margin = { horizontal = 1, vertical = 1 },
          padding = 1,
          padding_char = " ",
          placement = {
            horizontal = "right",
            vertical = "top",
          },
          overlap = {
            borders = true,
            statusline = false,
            tabline = false,
            winbar = true,
          },
          width = "fit",
          zindex = 50,
          winhighlight = {
            active = {
              EndOfBuffer = "None",
              Normal = "InclineNormal",
              Search = "None",
            },
            inactive = {
              EndOfBuffer = "None",
              Normal = "InclineNormalNC",
              Search = "None",
            },
          },
        },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          if filename == "" then filename = "[No Name]" end
  
          local ft_icon, ft_color = devicons.get_icon_color(filename)
          local modified = vim.bo[props.buf].modified
  
          local function get_git_diff()
            local signs = vim.b[props.buf].gitsigns_status_dict
            local icons = { added = "", changed = "", removed = "" }
            local results = {}
            if signs then
              for name, icon in pairs(icons) do
                if signs[name] and signs[name] > 0 then
                  table.insert(results, { icon .. signs[name] .. " ", group = "Diff" .. name })
                end
              end
            end
            if #results > 0 then
              table.insert(results, { "┊ " })
            end
            return results
          end
  
          local function get_diagnostics()
            local icons = { error = " ", warn = " ", info = " ", hint = " " }
            local results = {}
            for severity, icon in pairs(icons) do
              local n = #vim.diagnostic.get(props.buf, { severity = vim.diagnostic.severity[string.upper(severity)] })
              if n > 0 then
                table.insert(results, { icon .. n .. " ", group = "DiagnosticSign" .. severity })
              end
            end
            if #results > 0 then
              table.insert(results, { "┊ " })
            end
            return results
          end
  
          local res = {
            get_diagnostics(),
            get_git_diff(),
            ft_icon and { " ", ft_icon, " ", guifg = ft_color, guibg = "none" } or "",
            { filename .. " ", gui = modified and "bold,italic" or "bold" },
            { "┊  " .. vim.api.nvim_win_get_number(props.win), group = "DevIconWindows" },
          }
  
          if props.focused and navic.is_available(props.buf) then
            for _, item in ipairs(navic.get_data(props.buf) or {}) do
              table.insert(res, {
                { " > ", group = "NavicSeparator" },
                { item.icon, group = "NavicIcons" .. item.type },
                { item.name, group = "NavicText" },
              })
            end
          end
  
          -- Simulated animation effect via async redraw (mini fade-in logic)
          vim.defer_fn(function()
            vim.cmd.redraw()
          end, 10)
  
          return res
        end,
      })
  
      -- Optional: Notify when Incline is loaded (connect with noice/notify)
      vim.defer_fn(function()
        vim.notify("Incline loaded successfully", vim.log.levels.INFO, { title = "Incline" })
      end, 500)
    end,
  }
  
  return M
  