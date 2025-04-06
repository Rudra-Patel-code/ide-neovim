
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
      add = { text = "┃" },
      change = { text = "┋" },
      delete = { text = "" },
      topdelete = { text = "" },
      changedelete = { text = "┃" },
    },
    signcolumn = true,
    numhl = false,
    linehl = false,
    current_line_blame = false,
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = "eol",
      delay = 100,
      ignore_whitespace = false,
    },
    current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
    update_debounce = 200,
    preview_config = {
      border = "rounded",
      style = "minimal",
      relative = "cursor",
      row = 0,
      col = 1,
    },
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns
      local function map(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
      end

    --   map("n", "]h", gs.next_hunk, "Next Hunk")
    --   map("n", "[h", gs.prev_hunk, "Prev Hunk")
    --   map("n", "<leader>hs", gs.stage_hunk, "Stage Hunk")
    --   map("n", "<leader>hr", gs.reset_hunk, "Reset Hunk")
    --   map("v", "<leader>hs", function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, "Stage Hunk")
    --   map("v", "<leader>hr", function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, "Reset Hunk")
    --   map("n", "<leader>hS", gs.stage_buffer, "Stage Buffer")
    --   map("n", "<leader>hR", gs.reset_buffer, "Reset Buffer")
    --   map("n", "<leader>hu", gs.undo_stage_hunk, "Undo Stage Hunk")
    --   map("n", "<leader>hp", gs.preview_hunk, "Preview Hunk")
    --   map("n", "<leader>hb", function() gs.blame_line({ full = true }) end, "Blame Line (Full)")
    --   map("n", "<leader>hB", gs.toggle_current_line_blame, "Toggle Blame Line")
    --   map("n", "<leader>hd", gs.diffthis, "Diff This")
    --   map("n", "<leader>hD", function() gs.diffthis("~") end, "Diff This ~")
    --   map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "Select Hunk")
    end,
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
