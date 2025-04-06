
-- alpha.lua
local M = {
	"goolord/alpha-nvim",
	event = "VimEnter",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"echasnovski/mini.icons",
		"rmagatti/auto-session",
		"nvim-telescope/telescope.nvim",
	},
}

function M.config()
	local alpha = require("alpha")
	local dashboard = require("alpha.themes.dashboard")

	local function current_session_name()
		local cwd = vim.fn.getcwd()
		return cwd:gsub(":", "%%") .. ".vim"
	end

	local function get_session_dir()
		local config = vim.g.auto_session_root_dir or (vim.fn.stdpath("data") .. "/sessions")
		return config
	end

	-- Auto-restore session silently if available and not in suppressed dir
	local suppressed_dirs = { vim.fn.expand("~"), "/" }
	local current_dir = vim.fn.getcwd()
	if not vim.tbl_contains(suppressed_dirs, current_dir) then
		local session_path = get_session_dir() .. "/" .. current_dir:gsub(":", "%%") .. ".vim"
		if vim.fn.filereadable(session_path) == 1 then
			vim.cmd("silent! SessionRestore")
		end
	end

	local function button(sc, txt, keybind, keybind_opts)
		local b = dashboard.button(sc, txt, keybind, keybind_opts)
		b.opts.hl_shortcut = "Include"
		return b
	end

	-- Get recent session list (max 3)
	local function recent_sessions()
		local dir = get_session_dir()
		local handle = vim.loop.fs_scandir(dir)
		local sessions = {}
		if handle then
			while true do
				local name = vim.loop.fs_scandir_next(handle)
				if not name then
					break
				end
				if name:match("%.vim$") then
					table.insert(sessions, name)
				end
			end
		end
		table.sort(sessions, function(a, b)
			local stat_a = vim.loop.fs_stat(dir .. "/" .. a)
			local stat_b = vim.loop.fs_stat(dir .. "/" .. b)
			return stat_a.mtime.sec > stat_b.mtime.sec
		end)
		return vim.tbl_map(function(s)
			return "📁 " .. s:gsub("%%", "/"):gsub("%.vim$", "")
		end, vim.list_slice(sessions, 1, 3))
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
		button("s", "  Restore Session", function()
			local session_dir = get_session_dir()
			local cwd = vim.fn.getcwd():gsub(":", "%%")
			local session_path = session_dir .. "/" .. cwd .. ".vim"
			if vim.fn.filereadable(session_path) == 1 then
				vim.cmd("SessionRestore")
			else
				vim.notify("No session found for this directory.", vim.log.levels.WARN, { title = "Session" })
			end
		end),
		button("d", "  Delete Session", function()
			local session_name = current_session_name()
			if session_name then
				local session_path = get_session_dir() .. "/" .. session_name
				if vim.fn.filereadable(session_path) == 1 then
					os.remove(session_path)
					vim.notify("Deleted session: " .. session_name, vim.log.levels.INFO, { title = "Session" })
				else
					vim.notify("No session found to delete.", vim.log.levels.WARN, { title = "Session" })
				end
			end
		end),
		button("c", "  Config", "<cmd>edit ~/.config/nvim/init.lua<CR>"),
		button("q", "  Quit", "<cmd>qa<CR>"),
	}

	dashboard.section.footer.val = function()
		local stats = require("lazy").stats()
		local session = current_session_name() or "No session"
		local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
		local recents = table.concat(recent_sessions(), "\n")
		return "⚡ Loaded "
			.. stats.count
			.. " plugins in "
			.. ms
			.. "ms\n"
			.. "📁 Last Session: "
			.. session
			.. "\n"
			.. recents
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

	-- Git branch aware session name on exit
	vim.api.nvim_create_autocmd("VimLeavePre", {
		callback = function()
			local cwd = vim.fn.getcwd()
			local branch = vim.fn.system("git rev-parse --abbrev-ref HEAD"):gsub("\n", "")
			if vim.v.shell_error == 0 and branch ~= "" then
				vim.g.auto_session_root_dir = cwd
				vim.g.auto_session_enabled = true
				vim.g.auto_session_use_git_branch = true
				vim.g.auto_session_name = cwd:gsub(":", "%%") .. "__" .. branch
			end
		end,
	})
end

return M

