local M = {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
      -- no need to include `nvim-web-devicons` since you're using mini.icons
    },
    opts = {
      attach_navic = true,
      create_autocmd = true,
      show_navic = true,
  
      -- Replace with mini icons (mini mimics nvim-web-devicons)
      show_basename = true,
      show_dirname = true,
      show_modified = true,
  
      -- Fancy symbols
      symbols = {
        modified = "●",
        ellipsis = "…",
        separator = "",
      },
  
      kinds = require("mini.icons").list("default", {style = "spaced"}), -- or "default" / "lspkind"
    },
  }
  
  return M
  
