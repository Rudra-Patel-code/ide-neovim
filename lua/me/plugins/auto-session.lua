
local M = {
  "rmagatti/auto-session",
  lazy = false,
  config = function()
    require("auto-session").setup({
      log_level = "info",
      auto_session_enable_last_session = false,
      auto_session_root_dir = vim.fn.stdpath("data") .. "/sessions/",
      auto_session_enabled = true,
      auto_save_enabled = true,
      auto_restore_enabled = true,
      auto_session_suppress_dirs = { "~/", "~/Downloads", "/" },
    })

    -- Session telescope integration (optional)
    vim.keymap.set("n", "<leader>ss", require("auto-session.session-lens").search_session, {
      desc = "Search Sessions",
    })
  end,
}

return M
