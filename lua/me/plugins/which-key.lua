-- File: lua/me/plugins/which-key.lua

return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    local wk = require("which-key")

    wk.setup({
     plugins = {
        marks = true,
        registers = true,
        spelling = { enabled = true, suggestions = 20 },
        presets = {
          operators = true,
          motions = true,
          text_objects = true,
          windows = true,
          nav = true,
          z = true,
          g = true,
        },
      },
    })

    wk.register({
      ["<leader>"] = {
        name = "+leader",
        ["nh"] = { ":nohl<CR>", "Clear search highlights" },
        ["+"] = { "<C-a>", "Increment number" },
        ["-"] = { "<C-x>", "Decrement number" },
        ["sv"] = { "<C-w>v", "Split window vertically" },
        ["sh"] = { "<C-w>s", "Split window horizontally" },
        ["se"] = { "<C-w>=", "Make splits equal size" },
        ["sx"] = { "<cmd>close<CR>", "Close current split" },
        ["to"] = { "<cmd>tabnew<CR>", "Open new tab" },
        ["tx"] = { "<cmd>tabclose<CR>", "Close current tab" },
        ["tn"] = { "<cmd>tabn<CR>", "Go to next tab" },
        ["tp"] = { "<cmd>tabp<CR>", "Go to previous tab" },
        ["tf"] = { "<cmd>tabnew %<CR>", "Open current buffer in new tab" },
        u = {
          name = "+ui",
          t = { "<cmd>Twilight<cr>", "Toggle Twilight" },
          z = { "<cmd>ZenMode<cr>", "Toggle Zen Mode" },
        },
      },
    })

    wk.register({
      ["<C-s>"] = { "<ESC>:w<CR>", "Save file" },
    }, { mode = "n" })

    wk.register({
      ["<C-s>"] = { "<ESC>:w<CR>", "Save file" },
      ["<"] = { "<gv", "Indent left and keep selection" },
      [">"] = { ">gv", "Indent right and keep selection" },
    }, { mode = "v" })

    wk.register({
      ["<C-s>"] = { "<ESC>:w<CR>", "Save file" },
      ["jk"] = { "<ESC>", "Exit insert mode with jk" },
    }, { mode = "i" })


wk.register({
  ["<leader>j"] = {
    name = "+jump",
    -- Leap
    s = { "<Plug>(leap-forward)", "Leap Forward" },
    S = { "<Plug>(leap-backward)", "Leap Backward" },
    g = { "<Plug>(leap-from-window)", "Leap Other Window" },

    -- Flash
    f = { function() require("flash").jump() end, "Flash Jump" },
    t = { function() require("flash").treesitter() end, "Flash Treesitter" },
    r = { function() require("flash").remote() end, "Flash Remote (Op-pending)" },
    R = { function() require("flash").treesitter_search() end, "Flash Treesitter Search" },
  }
})
  end,
}
