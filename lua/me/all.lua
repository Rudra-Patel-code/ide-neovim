
-- File: lua/me/core/all.lua
-- Description: Centralized keymap configuration for all plugins and core settings
--              Keymaps are grouped and commented by source file

local map = vim.keymap.set

-- ╭──────────────────────────────╮
-- │ plugins/nvim-tree.lua        │
-- ╰──────────────────────────────╯
map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle Explorer" })
map("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Find Current File" })
map("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh Explorer" })
map("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse Explorer" })

-- ╭──────────────────────────────╮
-- │ plugins/toggle-term.lua      │
-- ╰──────────────────────────────╯
map("n", "<leader>tt", "<cmd>ToggleTerm<CR>", { desc = "Toggle terminal (float)" })
map("n", "<leader>tv", "<cmd>ToggleTerm direction=vertical<CR>", { desc = "Toggle vertical terminal" })
map("n", "<leader>th", "<cmd>ToggleTerm direction=horizontal<CR>", { desc = "Toggle horizontal terminal" })
map("n", "<leader>tg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", { desc = "Toggle Lazygit" })
map("t", "<Esc>", [[<C-\><C-n>]], { desc = "Terminal mode to normal mode" })

-- ╭──────────────────────────────╮
-- │ plugins/flash-leap.lua       │
-- ╰──────────────────────────────╯
map({ "n", "x", "o" }, "s", function() require("flash").jump() end, { desc = "Flash" })
map({ "n", "x", "o" }, "S", function() require("flash").treesitter() end, { desc = "Flash Treesitter" })
map("o", "<leader>jr", function() require("flash").remote() end, { desc = "Remote Flash" })
map({ "o", "x" }, "<leader>jR", function() require("flash").treesitter_search() end, { desc = "Treesitter Search" })
map("c", "<C-s>", function() require("flash").toggle() end, { desc = "Toggle Flash Search" })
map({ 'n', 'x', 'o' }, 'ga', function() require('leap.treesitter').select() end, { desc = "Leap Treesitter Select" })
map({ 'n', 'x', 'o' }, 'gA', 'V<cmd>lua require("leap.treesitter").select()<cr>', { desc = "Leap Treesitter Select Linewise" })

-- ╭──────────────────────────────╮
-- │ plugins/mini-animate.lua     │
-- ╰──────────────────────────────╯
map("n", "<leader>ua", function()
  local animate = require("mini.animate")
  local scroll_enabled = not vim.g.scroll_animate_disabled
  vim.g.scroll_animate_disabled = not scroll_enabled
  animate.setup({
    scroll = { enable = scroll_enabled }
  })
  vim.notify("Scroll animation " .. (scroll_enabled and "enabled" or "disabled"), vim.log.levels.INFO, { title = "Mini Animate" })
end, { desc = "Toggle Scroll Animation" })

-- ╭──────────────────────────────╮
-- │ plugins/todo-comments.lua    │
-- ╰──────────────────────────────╯
map("n", "]t", function() require("todo-comments").jump_next() end, { desc = "Next todo comment" })
map("n", "[t", function() require("todo-comments").jump_prev() end, { desc = "Previous todo comment" })
map("n", "<leader>st", ":TodoTelescope<CR>", { desc = "Search TODOs with Telescope" })
map("n", "<leader>xt", ":TodoTrouble<CR>", { desc = "TODOs in Trouble" })
map("n", "<leader>qf", ":TodoQuickFix<CR>", { desc = "TODOs in Quickfix" })
map("n", "<leader>xl", ":TodoLocList<CR>", { desc = "TODOs in LocList" })

-- ╭──────────────────────────────╮
-- │ plugins/telescope.lua        │
-- ╰──────────────────────────────╯
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Files" })
map("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Recent Files" })
map("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "String Grep" })
map("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Grep Under Cursor" })
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help" })
map("n", "<leader>fl", "<cmd>Telescope resume<cr>", { desc = "Last Picker" })
map("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Todos" })
map("n", "<leader>fp", "<cmd>Telescope project<cr>", { desc = "Projects" })
map("n", "<leader>fe", "<cmd>Telescope file_browser<cr>", { desc = "File Browser" })
map("n", "<leader>fC", "<cmd>Telescope cheatsheet<cr>", { desc = "Cheatsheet" })
map("n", "<leader>gs", "<cmd>Telescope git_status<cr>", { desc = "Git Status" })
map("n", "<leader>gb", "<cmd>Telescope git_branches<cr>", { desc = "Git Branches" })
map("n", "<leader>gc", "<cmd>Telescope git_commits<cr>", { desc = "Git Commits" })
map("n", "<leader>lr", "<cmd>Telescope lsp_references<cr>", { desc = "LSP References" })
map("n", "<leader>ld", "<cmd>Telescope lsp_definitions<cr>", { desc = "LSP Definitions" })
map("n", "<leader>li", "<cmd>Telescope lsp_implementations<cr>", { desc = "LSP Implementations" })
map("n", "<leader>lt", "<cmd>Telescope lsp_type_definitions<cr>", { desc = "LSP Type Definitions" })

-- ╭──────────────────────────────╮
-- │ plugins/trouble.lua          │
-- ╰──────────────────────────────╯
map("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
map("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Buffer Diagnostics (Trouble)" })
map("n", "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", { desc = "Document Symbols (Trouble)" })
map("n", "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", { desc = "LSP Definitions/Refs (Trouble)" })
map("n", "<leader>xL", "<cmd>Trouble loclist toggle<cr>", { desc = "Location List (Trouble)" })
map("n", "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", { desc = "Quickfix List (Trouble)" })

-- ╭──────────────────────────────╮
-- │ plugins/ufo.lua              │
-- ╰──────────────────────────────╯
map("n", "zR", function() require("ufo").openAllFolds() end, { desc = "Open all folds" })
map("n", "zM", function() require("ufo").closeAllFolds() end, { desc = "Close all folds" })
map("n", "zr", function() require("ufo").openFoldsExceptKinds() end, { desc = "Open folds except kinds" })
map("n", "zm", function() require("ufo").closeFoldsWith() end, { desc = "Close folds with depth" })
map("n", "K", function()
  local winid = require("ufo").peekFoldedLinesUnderCursor()
  if not winid then
    vim.lsp.buf.hover()
  end
end, { desc = "Peek or hover" })

-- ╭──────────────────────────────╮
-- │ plugins/debug.lua            │
-- ╰──────────────────────────────╯
local dap_status_ok, dap = pcall(require, "dap")

if dap_status_ok then
    map("n", "<leader>dc", dap.continue, { desc = "Start/Continue" })
    map("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
    map("n", "<leader>dB", function() dap.set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, { desc = "Set Conditional Breakpoint" })
    map("n", "<leader>dr", dap.repl.open, { desc = "Open REPL" })
    map("n", "<leader>dl", dap.run_last, { desc = "Run Last" })
    map("n", "<leader>do", dap.step_over, { desc = "Step Over" })
    map("n", "<leader>di", dap.step_into, { desc = "Step Into" })
    map("n", "<leader>du", dap.step_out, { desc = "Step Out" })
    map("n", "<leader>dx", dap.terminate, { desc = "Terminate" })
end


local dapui_status_ok, dapui = pcall(require, "dapui")
if dapui_status_ok then
    map("n", "<leader>dt", require("dapui").toggle, { desc = "Toggle DAP UI" })
end

-- ╭──────────────────────────────╮
-- │ plugins/twilight.lua         │
-- ╰──────────────────────────────╯
map("n", "<leader>ut", "<cmd>Twilight<cr>", { desc = "Toggle Twilight" })


-- ╭──────────────────────────────╮
-- │ plugins/editing.lua          │
-- ╰──────────────────────────────╯
map("n", "<leader>s", function() require("substitute").operator() end, { noremap = true, desc = "Substitute with motion" })
map("n", "<leader>ss", function() require("substitute").line() end, { noremap = true, desc = "Substitute entire line" })
map("n", "<leader>S", function() require("substitute").eol() end, { noremap = true, desc = "Substitute to end of line" })
map("x", "<leader>s", function() require("substitute").visual() end, { noremap = true, desc = "Substitute in visual mode" })
map("n", "<leader>sx", function() require("substitute.exchange").operator() end, { noremap = true, desc = "Exchange with motion" })
map("n", "<leader>sxx", function() require("substitute.exchange").line() end, { noremap = true, desc = "Exchange line" })
map("x", "<leader>X", function() require("substitute.exchange").visual() end, { noremap = true, desc = "Exchange visual selection" })
map("n", "<leader>sxc", function() require("substitute.exchange").cancel() end, { noremap = true, desc = "Cancel exchange" })

-- 

-- ╭──────────────────────────────╮
-- │ plugins/git.lua          │
-- ╰──────────────────────────────╯

map("n", "]h", function() require("gitsigns").next_hunk() end, { desc = "Next Hunk" })
map("n", "[h", function() require("gitsigns").prev_hunk() end, { desc = "Previous Hunk" })
map("n", "<leader>hs", function() require("gitsigns").stage_hunk() end, { desc = "Stage Hunk" })
map("n", "<leader>hr", function() require("gitsigns").reset_hunk() end, { desc = "Reset Hunk" })
map("v", "<leader>hs", function()
	require("gitsigns").stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
end, { desc = "Stage Hunk" })
map("v", "<leader>hr", function()
	require("gitsigns").reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
end, { desc = "Reset Hunk" })
map("n", "<leader>hS", function() require("gitsigns").stage_buffer() end, { desc = "Stage Buffer" })
map("n", "<leader>hR", function() require("gitsigns").reset_buffer() end, { desc = "Reset Buffer" })
map("n", "<leader>hu", function() require("gitsigns").undo_stage_hunk() end, { desc = "Undo Stage Hunk" })
map("n", "<leader>hp", function() require("gitsigns").preview_hunk() end, { desc = "Preview Hunk" })
map("n", "<leader>hb", function() require("gitsigns").blame_line({ full = true }) end, { desc = "Blame Line (Full)" })
map("n", "<leader>hB", function() require("gitsigns").toggle_current_line_blame() end, { desc = "Toggle Blame Line" })
map("n", "<leader>hd", function() require("gitsigns").diffthis() end, { desc = "Diff This" })
map("n", "<leader>hD", function() require("gitsigns").diffthis("~") end, { desc = "Diff This ~" })
map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Select Hunk" })




