
-- debug.lua
-- 💥 Debugging setup with nvim-dap and dap-ui for multiple languages

local M = {
  "mfussenegger/nvim-dap",
  dependencies = {
    { "rcarriga/nvim-dap-ui" },
    { "theHamsta/nvim-dap-virtual-text" },
    { "nvim-neotest/nvim-nio" },
    { "mfussenegger/nvim-jdtls" },
  },
}

function M.config()
  local dap = require("dap")
  local dapui = require("dapui")

  -- Setup UI
  dapui.setup({
    layouts = {
      {
        elements = {
          { id = "scopes", size = 0.25 },
          { id = "breakpoints", size = 0.25 },
          { id = "stacks", size = 0.25 },
          { id = "watches", size = 0.25 },
        },
        size = 40,
        position = "left",
      },
      {
        elements = {
          { id = "repl", size = 0.5 },
          { id = "console", size = 0.5 },
        },
        size = 10,
        position = "bottom",
      },
    },
    controls = {
      enabled = true,
      element = "repl",
    },
  })

  -- Virtual text
  require("nvim-dap-virtual-text").setup({
    enabled = true,
    highlight_changed_variables = true,
    highlight_new_as_changed = true,
    show_stop_reason = true,
  })

  -- Auto open/close UI
  dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
  end
  dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
  end
  dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
  end

  -- 🔧 Language-specific Adapters

  -- C / C++ (using lldb)
  dap.adapters.lldb = {
    type = "executable",
    command = "/usr/bin/lldb-vscode",
    name = "lldb",
  }
  dap.configurations.cpp = {
    {
      name = "Launch file",
      type = "lldb",
      request = "launch",
      program = function()
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
      end,
      cwd = "${workspaceFolder}",
      stopOnEntry = false,
      args = {},
    },
  }
  dap.configurations.c = dap.configurations.cpp

  -- Python
  dap.adapters.python = {
    type = "executable",
    command = "python3",
    args = { "-m", "debugpy.adapter" },
  }
  dap.configurations.python = {
    {
      type = "python",
      request = "launch",
      name = "Launch file",
      program = "${file}",
      pythonPath = function()
        return "python3"
      end,
    },
  }

  -- JavaScript / TypeScript
  dap.adapters.node2 = {
    type = "executable",
    command = "node",
    args = { os.getenv("HOME") .. "/.local/share/nvim/dap_adapters/vscode-node-debug2/out/src/nodeDebug.js" },
  }
  dap.configurations.javascript = {
    {
      name = "Launch",
      type = "node2",
      request = "launch",
      program = "${file}",
      cwd = vim.fn.getcwd(),
      sourceMaps = true,
      protocol = "inspector",
      console = "integratedTerminal",
    },
  }
  dap.configurations.typescript = dap.configurations.javascript

  -- Java (with nvim-jdtls)
  dap.configurations.java = {
    {
      type = "java",
      request = "launch",
      name = "Launch Main Class",
      mainClass = function()
        return vim.fn.input("Main class: ")
      end,
      projectName = function()
        return vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
      end,
      cwd = vim.fn.getcwd(),
      console = "integratedTerminal",
    },
  }

  -- 🔑 Keybindings
  vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Start/Continue" })
  vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
  vim.keymap.set("n", "<leader>dB", function()
    dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
  end, { desc = "Set Conditional Breakpoint" })
  vim.keymap.set("n", "<leader>dr", dap.repl.open, { desc = "Open REPL" })
  vim.keymap.set("n", "<leader>dl", dap.run_last, { desc = "Run Last" })
  vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "Step Over" })
  vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step Into" })
  vim.keymap.set("n", "<leader>du", dap.step_out, { desc = "Step Out" })
  vim.keymap.set("n", "<leader>dx", dap.terminate, { desc = "Terminate" })
  vim.keymap.set("n", "<leader>dt", dapui.toggle, { desc = "Toggle DAP UI" })
end

return M
