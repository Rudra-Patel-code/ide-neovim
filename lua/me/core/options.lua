-- Set Neovim options
local opt = vim.opt

-- Use tree-style view for netrw file explorer
vim.cmd("let g:netrw_liststyle = 3")

-- Clipboard
opt.clipboard = "unnamedplus" -- Use system clipboard for copy/paste

-- Line numbers
opt.relativenumber = true     -- Show relative line numbers
opt.number = true             -- Show absolute number on the current line

-- Indentation
opt.tabstop = 4               -- Number of spaces for a tab character
opt.shiftwidth = 4            -- Number of spaces for each indentation level
opt.expandtab = true          -- Use spaces instead of tabs
opt.autoindent = true         -- Copy indentation from current line

-- Line wrapping
opt.wrap = false              -- Disable line wrapping

-- Search
opt.ignorecase = true         -- Ignore case in search patterns
opt.smartcase = true          -- Override ignorecase if uppercase is used
opt.incsearch = true          -- Show search matches as you type
opt.hlsearch = true           -- Highlight all matches after search

-- UI Enhancements
opt.cursorline = true         -- Highlight the current line
opt.termguicolors = true      -- Enable 24-bit RGB color in the terminal
opt.background = "dark"       -- Use dark background for compatible colorschemes
opt.signcolumn = "yes"        -- Always show the sign column (no text shifting)

-- Backspace behavior
opt.backspace = "indent,eol,start" -- Allow backspace over indent, end of line, and insert start

-- Split window behavior
opt.splitright = true         -- Vertical splits open to the right
opt.splitbelow = true         -- Horizontal splits open below

-- File handling
opt.swapfile = false          -- Don't create swap files
opt.backup = false            -- Don't create backup files
opt.undofile = true           -- Save undo history to file (persistent undo)

-- Performance
opt.updatetime = 300          -- Faster completion (default is 4000ms)
opt.timeoutlen = 500          -- Shorter timeout for mapped sequences

-- Mouse support
opt.mouse = 'a'               -- Enable mouse in all modes

-- Completion behavior
opt.completeopt = {'menu', 'menuone', 'noselect'} -- Better auto-completion experience

opt.sessionoptions:append("localoptions")


vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})




vim.api.nvim_create_autocmd("DirChanged", {
  callback = function()
    vim.fn.jobstart("eslint_d restart")
  end,
})
