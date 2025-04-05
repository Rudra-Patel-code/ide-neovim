local M = {
   {  "nvim-lua/plenary.nvim" },
 {
    -- 🪟 Maximize and restore splits
    "szw/vim-maximizer",
    lazy = false, -- load immediately
    keys = {
      { "<leader>sm", "<cmd>MaximizerToggle<CR>", mode = { "n", "v", "i" }, desc = "Toggle Maximizer" },
    },
    init = function()
      vim.g.maximizer_set_default_mapping = 0 -- disable plugin's default mappings
    end,
  },

  {
    -- 📜 Smooth scrolling animations
    "declancm/cinnamon.nvim",
    event = "VeryLazy",
    config = function()
      require("cinnamon").setup({
        default_keymaps = true,     -- Enable all default keymaps
        extra_keymaps = true,       -- Enable extended keymaps like n/N search, {, }, etc.
        extended_keymaps = true,    -- More fine-tuned motion control
        override_keymaps = true,    -- Override existing keymaps (e.g., <C-d>, <C-u>, etc.)
        max_length = 500,           -- Maximum number of lines that can be scrolled at once
        scroll_limit = 150,         -- Max distance per scroll command
        centered = true,            -- Keep cursor centered during scroll
        horizontal_scroll = true,   -- Enable smooth horizontal scroll
      })
    end,
  },


}

return M
