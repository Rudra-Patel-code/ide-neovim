
local M = {
  "echasnovski/mini.animate",
  version = "*",
  event = "VeryLazy",
  config = function()
    local animate = require("mini.animate")

    local scroll_enabled = true
    local timer = vim.loop.new_timer()

    local function reapply_animate()
      animate.setup({
        cursor = {
          enable = true,
          timing = animate.gen_timing.linear({ duration = 70, unit = "total" }),
        },
        scroll = {
          enable = scroll_enabled,
          timing = animate.gen_timing.linear({ duration = 100, unit = "total" }),
        },
        resize = {
          enable = true,
          timing = animate.gen_timing.linear({ duration = 80, unit = "total" }),
        },
        open = { enable = false },
        close = { enable = false },
      })
    end

    local function debounce_enable_scroll()
      if timer:is_active() then
        timer:stop()
      end
      timer:start(300, 0, function()
        scroll_enabled = true
        vim.g.scroll_animate_disabled = false
        vim.schedule(reapply_animate)
      end)
    end

    -- Initial animate setup
    reapply_animate()

    -- Toggle keybind
    vim.g.scroll_animate_disabled = false
    vim.keymap.set("n", "<leader>ua", function()
      scroll_enabled = not scroll_enabled
      vim.g.scroll_animate_disabled = not scroll_enabled
      reapply_animate()
      vim.notify("Scroll animation " .. (scroll_enabled and "enabled" or "disabled"), vim.log.levels.INFO, { title = "Mini Animate" })
    end, { desc = "Toggle Scroll Animation" })

    -- Mouse/touchpad detection disables scroll animation
    vim.on_key(function(char)
      local keys = {
        "<ScrollWheelUp>",
        "<ScrollWheelDown>",
        "\27[M",
      }

      for _, key in ipairs(keys) do
        if char:find(key, 1, true) then
          if scroll_enabled then
            scroll_enabled = false
            vim.g.scroll_animate_disabled = true
            reapply_animate()
            debounce_enable_scroll()
          end
          break
        end
      end
    end, vim.api.nvim_create_namespace("mini.animate.scroll_toggle"))

    -- Statusline global flag: vim.g.scroll_animate_disabled
  end,
}

return M

