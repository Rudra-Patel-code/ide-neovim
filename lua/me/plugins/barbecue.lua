local M = {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
    },
    opts = {
      attach_navic = true,
      create_autocmd = true,
      show_navic = true,
  
      show_basename = true,
      show_dirname = true,
      show_modified = true,
  
      -- Fancy symbols
      symbols = {
        modified = "●",
        ellipsis = "…",
        separator = "",
      },
  
    },
  }
  
  return M
  
