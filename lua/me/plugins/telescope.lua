
local M = {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  cmd = "Telescope",
  dependencies = {
    { "nvim-lua/plenary.nvim" },
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    { "nvim-tree/nvim-web-devicons" },
    { "folke/todo-comments.nvim" },
    { "nvim-telescope/telescope-ui-select.nvim" },
    { "nvim-telescope/telescope-file-browser.nvim" },
    { "nvim-telescope/telescope-project.nvim" },
    { "folke/trouble.nvim" },
  },
}

function M.config()
  local telescope = require("telescope")
  local actions = require("telescope.actions")
  local trouble_telescope = require("trouble.sources.telescope")

  telescope.setup({
    defaults = {
      prompt_prefix = " ",
      selection_caret = " ",
      path_display = { "smart" },
      mappings = {
        i = {
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
          ["<C-q>"] = actions.send_selected_to_qflist,
          ["<C-t>"] = trouble_telescope.open,
          ["<esc>"] = actions.close,
        },
        n = {
          ["<C-q>"] = actions.send_selected_to_qflist,
          ["<C-t>"] = trouble_telescope.open,
        },
      },
    },
    pickers = {
      find_files = { theme = "dropdown", previewer = true},
      buffers = {
        theme = "dropdown",
        previewer = false,
        initial_mode = "normal",
        mappings = {
          i = { ["<C-d>"] = actions.delete_buffer },
          n = { ["dd"] = actions.delete_buffer },
        },
      },
      live_grep = { theme = "dropdown" },
      grep_string = { theme = "dropdown" },
      lsp_references = { theme = "dropdown", initial_mode = "normal" },
      lsp_definitions = { theme = "dropdown", initial_mode = "normal" },
      lsp_implementations = { theme = "dropdown", initial_mode = "normal" },
    },
    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
      },
      project = {
        base_dirs = { "~/projects", "~/.config" },
        hidden_files = true,
      },
    },
  })

  telescope.load_extension("fzf")
  telescope.load_extension("ui-select")
  telescope.load_extension("file_browser")
  telescope.load_extension("project")
--  telescope.load_extension("cheat")

  -- Keymaps
  -- local wk = require("which-key")
  -- wk.register({
  --   ["<leader>f"] = {
  --     name = "+find",
  --     f = { "<cmd>Telescope find_files<cr>", "Files" },
  --     r = { "<cmd>Telescope oldfiles<cr>", "Recent Files" },
  --     s = { "<cmd>Telescope live_grep<cr>", "String Grep" },
  --     c = { "<cmd>Telescope grep_string<cr>", "Grep Under Cursor" },
  --     b = { "<cmd>Telescope buffers<cr>", "Buffers" },
  --     h = { "<cmd>Telescope help_tags<cr>", "Help" },
  --     l = { "<cmd>Telescope resume<cr>", "Last Picker" },
  --     t = { "<cmd>TodoTelescope<cr>", "Todos" },
  --     p = { "<cmd>Telescope project<cr>", "Projects" },
  --     e = { "<cmd>Telescope file_browser<cr>", "File Browser" },
  --     C = { "<cmd>Telescope cheatsheet<cr>", "Cheatsheet" },
  --   },
  --   ["<leader>g"] = {
  --     name = "+git",
  --     s = { "<cmd>Telescope git_status<cr>", "Status" },
  --     b = { "<cmd>Telescope git_branches<cr>", "Branches" },
  --     c = { "<cmd>Telescope git_commits<cr>", "Commits" },
  --   },
  --   ["<leader>l"] = {
  --     name = "+lsp",
  --     r = { "<cmd>Telescope lsp_references<cr>", "References" },
  --     d = { "<cmd>Telescope lsp_definitions<cr>", "Definitions" },
  --     i = { "<cmd>Telescope lsp_implementations<cr>", "Implementations" },
  --     t = { "<cmd>Telescope lsp_type_definitions<cr>", "Type Defs" },
  --   },
  -- })
end

return M
 
