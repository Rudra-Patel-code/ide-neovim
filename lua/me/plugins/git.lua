
-- git.lua
-- 🧲 Git integration via gitsigns, neogit, and lazygit

local M = {
  "lewis6991/gitsigns.nvim",
  dependencies = {
    "TimUntersberger/neogit",
    "kdheepak/lazygit.nvim",
  },
  event = { "BufReadPre", "BufNewFile" },
}

function M.config()
  -- 🧲 Gitsigns setup
  require("gitsigns").setup({
    signs = {
      add          = { text = "+" },
      change       = { text = "~" },
      delete       = { text = "_" },
      topdelete    = { text = "‾" },
      changedelete = { text = "~" },
    },
    signcolumn = true,
    numhl = false,
    linehl = false,
    word_diff = false,
    watch_gitdir = {
      interval = 1000,
      follow_files = true,
    },
    attach_to_untracked = true,
    current_line_blame = true,
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = "eol",
      delay = 100,
      ignore_whitespace = false,
    },
    preview_config = {
      border = "rounded",
      style = "minimal",
      relative = "cursor",
      row = 0,
      col = 1,
    },
  })

  -- 🧰 Neogit setup
  require("neogit").setup({
    disable_commit_confirmation = false,
    integrations = {
      diffview = true,
      telescope = true,
    },
    signs = {
      section = { ">", "v" },
      item = { ">", "v" },
      hunk = { "", "" },
    },
  })

  -- 🧼 Lazygit floating terminal
  vim.api.nvim_set_keymap("n", "<leader>gg", ":LazyGit<CR>", { noremap = true, silent = true, desc = "Open LazyGit" })

  -- 📦 Keybindings for Git
  local wk = require("which-key")
  wk.register({
    g = {
      name = "+git",
      g = { "<cmd>LazyGit<cr>", "Lazygit" },
      s = { "<cmd>Neogit<cr>", "Status (Neogit)" },
      b = { "<cmd>Gitsigns toggle_current_line_blame<cr>", "Toggle Blame" },
      d = { "<cmd>Gitsigns diffthis<cr>", "Diff This" },
      p = { "<cmd>Gitsigns preview_hunk<cr>", "Preview Hunk" },
      r = { "<cmd>Gitsigns reset_hunk<cr>", "Reset Hunk" },
      R = { "<cmd>Gitsigns reset_buffer<cr>", "Reset Buffer" },
      S = { "<cmd>Gitsigns stage_hunk<cr>", "Stage Hunk" },
      u = { "<cmd>Gitsigns undo_stage_hunk<cr>", "Undo Stage Hunk" },
      n = { "]c", "Next Hunk" },
      N = { "[c", "Prev Hunk" },
    },
  }, { prefix = "<leader>" })
end

return M
