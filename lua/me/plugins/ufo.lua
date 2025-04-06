
-- ╭──────────────────────────────────────────────────────────╮
-- │                    ✨ UFO Fold Setup ✨                  │
-- ╰──────────────────────────────────────────────────────────╯

return {
  {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    event = "BufReadPost",
    config = function()
      -- ╭────────────────────────────────────────────╮
      -- │            Neovim Fold Settings            │
      -- ╰────────────────────────────────────────────╯
      vim.o.foldcolumn = "auto"         -- Show fold column (like sign column)
      vim.o.foldlevel = 99           -- Set high foldlevel for ufo
      vim.o.foldlevelstart = 99      -- Start with all folds open
      vim.o.foldenable = true        -- Enable folding by default

      -- ╭────────────────────────────────────────────╮
      -- │            Fold Column Icons               │
      -- ╰────────────────────────────────────────────╯
      vim.fn.sign_define("UfoFolded", { text = "", texthl = "FoldColumn" })
      vim.fn.sign_define("UfoOpened", { text = "", texthl = "FoldColumn" })

      -- ╭────────────────────────────────────────────╮
      -- │          Custom Fold Visuals Setup         │
      -- ╰────────────────────────────────────────────╯
      local handler = function(virtText, lnum, endLnum, width, truncate)
        local newVirtText = {}
        local suffix = string.format(" 󰁂 %d lines ", endLnum - lnum)
        local sufWidth = vim.fn.strdisplaywidth(suffix)
        local targetWidth = width - sufWidth
        local curWidth = 0

        for _, chunk in ipairs(virtText) do
          local chunkText = chunk[1]
          local chunkWidth = vim.fn.strdisplaywidth(chunkText)

          if curWidth + chunkWidth < targetWidth then
            table.insert(newVirtText, chunk)
          else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            table.insert(newVirtText, { chunkText, chunk[2] })
            break
          end

          curWidth = curWidth + chunkWidth
        end

        table.insert(newVirtText, { suffix, "MoreMsg" })
        return newVirtText
      end

      -- ╭────────────────────────────────────────────╮
      -- │             Fold Provider Logic            │
      -- ╰────────────────────────────────────────────╯
      require("ufo").setup({
        fold_virt_text_handler = handler,
        provider_selector = function(_, filetype)
          -- Prefer LSP folds, fallback to indent if Treesitter is unsupported
          local has_ts, _ = pcall(require, "vim.treesitter.language.require_language", filetype)
          if has_ts then
            return { "treesitter", "indent" }
          else
            return { "lsp", "indent" }
          end
        end,
      })

      -- ╭────────────────────────────────────────────╮
      -- │               Key Mappings                 │
      -- ╰────────────────────────────────────────────╯
      -- local ufo = require("ufo")
      -- vim.keymap.set("n", "zR", ufo.openAllFolds, { desc = "Open all folds" })
      -- vim.keymap.set("n", "zM", ufo.closeAllFolds, { desc = "Close all folds" })
      -- vim.keymap.set("n", "zr", ufo.openFoldsExceptKinds, { desc = "Open folds except kinds" })
      -- vim.keymap.set("n", "zm", ufo.closeFoldsWith, { desc = "Close folds with depth" })
      -- vim.keymap.set("n", "K", function()
      --   local winid = ufo.peekFoldedLinesUnderCursor()
      --   if not winid then
      --     vim.lsp.buf.hover() -- fallback to LSP hover
      --   end
      -- end, { desc = "Peek or hover" })
    end,
  },
}

