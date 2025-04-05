-- alpha.lua
local M = {
    "goolord/alpha-nvim",
    event = "VimEnter",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "echasnovski/mini.icons",
    },
  }

  function M.config()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    local function button(sc, txt, keybind, keybind_opts)
      local b = dashboard.button(sc, txt, keybind, keybind_opts)
      b.opts.hl_shortcut = "Include"
      return b
    end

    dashboard.section.header.val = {
            "",
            "",
            "",
            "",
            "",
            " ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗ ",
            " ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║ ",
            " ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║ ",
            " ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║ ",
            " ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║ ",
            " ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝ ",
            "",
            "",
            "",
    }

    dashboard.section.buttons.val = {
      button("e", "  New File", "<cmd>ene <BAR> startinsert<CR>"),
      button("f", "󰱼  Find File", "<cmd>Telescope find_files<CR>"),
      button("g", "  Live Grep", "<cmd>Telescope live_grep<CR>"),
      button("r", "  Recent Files", "<cmd>Telescope oldfiles<CR>"),
      button("p", "  Projects", "<cmd>Telescope projects<CR>"),
      button("s", "  Restore Session", "<cmd>SessionRestore<CR>"),
      button("c", "  Config", "<cmd>edit ~/.config/nvim/init.lua<CR>"),
      button("q", "  Quit", "<cmd>qa<CR>"),
    }

    dashboard.section.footer.val = function()
      local stats = require("lazy").stats()
      local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
      return "⚡ Loaded " .. stats.count .. " plugins in " .. ms .. "ms"
    end

    dashboard.section.header.opts.hl = "Keyword"
    dashboard.section.buttons.opts.hl = "Include"
    dashboard.section.footer.opts.hl = "Type"

    dashboard.opts.opts.noautocmd = true
    alpha.setup(dashboard.opts)

    vim.api.nvim_create_autocmd("User", {
      pattern = "LazyVimStarted",
      callback = function()
        pcall(vim.cmd.AlphaRedraw)
      end,
    })

    vim.api.nvim_create_autocmd("User", {
      pattern = "AlphaReady",
      callback = function()
        vim.cmd([[set laststatus=0 | autocmd BufUnload <buffer> set laststatus=3]])
      end,
    })
  end

  return M

