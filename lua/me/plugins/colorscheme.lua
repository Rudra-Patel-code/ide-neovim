local M = {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
  }
  
function M.config()
    require("tokyonight").setup({
        style = "night", -- options: "storm", "night", "moon", "day"
      --  transparent = true,
        terminal_colors = true,
        
        styles = {
          comments = { italic = true },
          keywords = { italic = true },
          functions = {},
          variables = {},
          sidebars = "transparent",
          floats = "transparent",
        },
        sidebars = { "qf", "help", "terminal", "packer", "spectre_panel", "snacks" },
        dim_inactive = false,
        lualine_bold = true,
      })
  
      vim.cmd.colorscheme("tokyonight")
    end

 return M
