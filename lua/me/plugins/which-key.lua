return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	config = function()
		local wk = require("which-key")

		wk.setup({
			plugins = {
				marks = true,
				registers = true,
				spelling = { enabled = true, suggestions = 20 } ,
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

		-- Core keymaps
		wk.register({
			["<leader>"] = {
				n = {
					h = { ":nohl<CR>", "Clear search highlights" },
				},
				["+"] = { "<C-a>", "Increment number" },
				["-"] = { "<C-x>", "Decrement number" },
				s = {
					name = "Splits",
					v = { "<C-w>v", "Split window vertically" },
					h = { "<C-w>s", "Split window horizontally" },
					e = { "<C-w>=", "Make splits equal size" },
					c = { "<cmd>close<CR>", "Close current split" },
				},
			},
			["<C-h>"] = { "<C-w>h", "Move to left split" },
			["<C-j>"] = { "<C-w>j", "Move to below split" },
			["<C-k>"] = { "<C-w>k", "Move to above split" },
			["<C-l>"] = { "<C-w>l", "Move to right split" },
			["<C-Up>"] = { ":resize -2<CR>", "Resize split up" },
			["<C-Down>"] = { ":resize +2<CR>", "Resize split down" },
			["<C-Left>"] = { ":vertical resize -2<CR>", "Resize split left" },
			["<C-Right>"] = { ":vertical resize +2<CR>", "Resize split right" },
			["<C-s>"] = { "<Esc>:w<CR>", "Save file" },
		}, { mode = { "n", "i", "v" } })

		-- Insert mode
		wk.register({
			["jk"] = { "<ESC>", "Exit insert mode" },
		}, { mode = "i" })

		-- Visual mode
		wk.register({
			["<"] = { "<gv", "Indent left and keep selection" },
			[">"] = { ">gv", "Indent right and keep selection" },
		}, { mode = "v" })

		-- Explorer mappings
		wk.register({
			e = {
				name = "Explorer",
				e = { "<cmd>NvimTreeToggle<CR>", "Toggle Explorer" },
				f = { "<cmd>NvimTreeFindFileToggle<CR>", "Find Current File" },
				r = { "<cmd>NvimTreeRefresh<CR>", "Refresh Explorer" },
				c = { "<cmd>NvimTreeCollapse<CR>", "Collapse Explorer" },
			},
		}, { prefix = "<leader>" })

		-- Tabs and Terminal mappings
		wk.register({
			t = {
				name = "Tabs and Terminal",
				o = { "<cmd>tabnew<CR>", "Open new tab" },
				x = { "<cmd>tabclose<CR>", "Close current tab" },
				n = { "<cmd>tabn<CR>", "Go to next tab" },
				p = { "<cmd>tabp<CR>", "Go to previous tab" },
				f = { "<cmd>tabnew %<CR>", "Open current buffer in new tab" },
				t = { "<cmd>lua _FLOAT_TERM_TOGGLE()<CR>", "Toggle terminal (float)" },
				v = { "<cmd>lua _VERTICAL_TERM_TOGGLE()<CR>", "Toggle vertical terminal" },
				h = { "<cmd>lua _HORIZONTAL_TERM_TOGGLE()<CR>", "Toggle horizontal terminal" },
				g = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Toggle Lazygit" },
			},
		}, { prefix = "<leader>" })

		-- Flash/Leap mappings
		wk.register({
			s = {
				function()
					require("flash").jump()
				end,
				"Flash",
			},
			S = {
				function()
					require("flash").treesitter()
				end,
				"Flash Treesitter",
			},
			ga = {
				function()
					require("leap.treesitter").select()
				end,
				"Leap Treesitter Select",
			},
			gA = { 'V<cmd>lua require("leap.treesitter").select()<cr>', "Leap Treesitter Select Linewise" },
		}, { mode = { "n", "x", "o" } })

		wk.register({
			j = {
				r = {
					function()
						require("flash").remote()
					end,
					"Remote Flash",
				},
				R = {
					function()
						require("flash").treesitter_search()
					end,
					"Treesitter Search",
				},
			},
		}, { mode = { "o", "x" }, prefix = "<leader>" })

		-- Mini-animate
		wk.register({
			u = {
				a = {
					function()
						local animate = require("mini.animate")
						local scroll_enabled = not vim.g.scroll_animate_disabled
						vim.g.scroll_animate_disabled = not scroll_enabled
						animate.setup({ scroll = { enable = scroll_enabled } })
						vim.notify(
							"Scroll animation " .. (scroll_enabled and "enabled" or "disabled"),
							vim.log.levels.INFO,
							{ title = "Mini Animate" }
						)
					end,
					"Toggle Scroll Animation",
				},
				t = { "<cmd>Twilight<cr>", "Toggle Twilight" },
			},
		}, { prefix = "<leader>" })

		-- Todo-comments
		wk.register({
			["]t"] = {
				function()
					require("todo-comments").jump_next()
				end,
				"Next todo comment",
			},
			["[t"] = {
				function()
					require("todo-comments").jump_prev()
				end,
				"Previous todo comment",
			},
			s = {
				t = { ":TodoTelescope<CR>", "Search TODOs with Telescope" },
			},
			x = {
				t = { ":TodoTrouble<CR>", "TODOs in Trouble" },
				l = { ":TodoLocList<CR>", "TODOs in LocList" },
			},
			q = {
				f = { ":TodoQuickFix<CR>", "TODOs in Quickfix" },
			},
		})

		-- Telescope
		wk.register({
			f = {
				name = "Telescope",
				f = { "<cmd>Telescope find_files<cr>", "Files" },
				r = { "<cmd>Telescope oldfiles<cr>", "Recent Files" },
				s = { "<cmd>Telescope live_grep<cr>", "String Grep" },
				c = { "<cmd>Telescope grep_string<cr>", "Grep Under Cursor" },
				b = { "<cmd>Telescope buffers<cr>", "Buffers" },
				h = { "<cmd>Telescope help_tags<cr>", "Help" },
				l = { "<cmd>Telescope resume<cr>", "Last Picker" },
				t = { "<cmd>TodoTelescope<cr>", "Todos" },
				p = { "<cmd>Telescope project<cr>", "Projects" },
				e = { "<cmd>Telescope file_browser<cr>", "File Browser" },
				C = { "<cmd>Telescope cheatsheet<cr>", "Cheatsheet" },
			},
			g = {
				s = { "<cmd>Telescope git_status<cr>", "Git Status" },
				b = { "<cmd>Telescope git_branches<cr>", "Git Branches" },
				c = { "<cmd>Telescope git_commits<cr>", "Git Commits" },
			},
			l = {
				r = { "<cmd>Telescope lsp_references<cr>", "LSP References" },
				d = { "<cmd>Telescope lsp_definitions<cr>", "LSP Definitions" },
				i = { "<cmd>Telescope lsp_implementations<cr>", "LSP Implementations" },
				t = { "<cmd>Telescope lsp_type_definitions<cr>", "LSP Type Definitions" },
				f = { "<cmd>FormatWrite<cr>", "Format & Save" },
			},
		}, { prefix = "<leader>", mode = "n" })

		-- Trouble
		wk.register({
			x = {
				name = "Trouble",
				x = { "<cmd>Trouble diagnostics toggle<cr>", "Diagnostics" },
				X = { "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", "Buffer Diagnostics" },
				L = { "<cmd>Trouble loclist toggle<cr>", "Location List" },
				Q = { "<cmd>Trouble qflist toggle<cr>", "Quickfix List" },
			},
			c = {
				s = { "<cmd>Trouble symbols toggle focus=false<cr>", "Document Symbols" },
				l = { "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", "LSP Definitions/Refs" },
			},
		}, { prefix = "<leader>" })

		-- UFO (folding)
		wk.register({
			z = {
				R = {
					function()
						require("ufo").openAllFolds()
					end,
					"Open all folds",
				},
				M = {
					function()
						require("ufo").closeAllFolds()
					end,
					"Close all folds",
				},
				r = {
					function()
						require("ufo").openFoldsExceptKinds()
					end,
					"Open folds except kinds",
				},
				m = {
					function()
						require("ufo").closeFoldsWith()
					end,
					"Close folds with depth",
				},
			},
			K = {
				function()
					local winid = require("ufo").peekFoldedLinesUnderCursor()
					if not winid then
						vim.lsp.buf.hover()
					end
				end,
				"Peek or hover",
			},
		})

		-- DAP (Debug)
		local dap_status_ok, dap = pcall(require, "dap")
		local dapui_status_ok = pcall(require, "dapui")
		if dap_status_ok then
			wk.register({
				d = {
					name = "Debug",
					c = { dap.continue, "Start/Continue" },
					b = { dap.toggle_breakpoint, "Toggle Breakpoint" },
					B = {
						function()
							dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
						end,
						"Set Conditional Breakpoint",
					},
					r = { dap.repl.open, "Open REPL" },
					l = { dap.run_last, "Run Last" },
					o = { dap.step_over, "Step Over" },
					i = { dap.step_into, "Step Into" },
					u = { dap.step_out, "Step Out" },
					x = { dap.terminate, "Terminate" },
					t = { dapui_status_ok and require("dapui").toggle or nil, "Toggle DAP UI" },
				},
			}, { prefix = "<leader>" })
		end

		-- Git
		wk.register({
			h = {
				name = "+gitsigns",
				["]"] = { "]h", "Next Hunk" },
				["["] = { "[h", "Previous Hunk" },
				s = { "<leader>hs", "Stage Hunk" },
				r = { "<leader>hr", "Reset Hunk" },
				S = { "<leader>hS", "Stage Buffer" },
				R = { "<leader>hR", "Reset Buffer" },
				u = { "<leader>hu", "Undo Stage Hunk" },
				p = { "<leader>hp", "Preview Hunk" },
				b = { "<leader>hb", "Blame Line (Full)" },
				B = { "<leader>hB", "Toggle Blame Line" },
				d = { "<leader>hd", "Diff This" },
				D = { "<leader>hD", "Diff This ~" },
			},
		}, { prefix = "<leader>" })

		wk.register({
			h = {
				name = "+gitsigns",
				s = { "<leader>hs", "Stage Hunk (Visual)" },
				r = { "<leader>hr", "Reset Hunk (Visual)" },
			},
		}, { mode = "v", prefix = "<leader>" })

		wk.register({
			h = {
				name = "+gitsigns",
				["]"] = { "]h", "Next Hunk" },
				["["] = { "[h", "Previous Hunk" },
			},
		})

		-- For the visual/operator pending mode mapping
		wk.register({
			ih = { ":<C-U>Gitsigns select_hunk<CR>", "Select Hunk" },
		}, { mode = { "o", "x" } })
	end,
}
