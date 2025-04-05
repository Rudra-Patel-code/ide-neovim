
local M = {
  "ahmedkhalf/project.nvim",
  event = "VeryLazy",
  config = function()
    require("project_nvim").setup({
      manual_mode = false,
      detection_methods = { "lsp", "pattern" },
      patterns = { ".git", "Makefile", "package.json", "pyproject.toml" },
      ignore_lsp = {},
      exclude_dirs = { "~/.cargo/*" },
      show_hidden = true,
      silent_chdir = true,
      datapath = vim.fn.stdpath("data"),
    })

    require("telescope").load_extension("projects")
  end,
}

return M
