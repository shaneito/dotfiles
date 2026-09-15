-- ========================================================================== --
-- ==                           EDITOR SETTINGS                            == --
-- ========================================================================== --

vim.opt.number = true
vim.opt.mouse = "a"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.wrap = true
vim.opt.breakindent = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- ========================================================================== --
-- ==                             KEYBINDINGS                              == --
-- ========================================================================== --

-- Space as leader key
vim.g.mapleader = " "

-- VsCode
-- Toggle explorer pane with <leader>e
vim.keymap.set("n", "<leader>e", function()
	vim.fn.VSCodeCall("workbench.action.toggleSidebarVisibility")
end, { noremap = true, silent = true })

-- Toggle terminal with <leader>t
vim.keymap.set("n", "<leader>t", function()
	vim.fn.VSCodeCall("workbench.action.togglePanel")
end, { noremap = true, silent = true })

-- Navigate tabs like Vim
vim.keymap.set("n", "gt", function()
	vim.fn.VSCodeCall("workbench.action.nextEditor")
end, { noremap = true, silent = true })

vim.keymap.set("n", "gT", function()
	vim.fn.VSCodeCall("workbench.action.previousEditor")
end, { noremap = true, silent = true })

-- Shortcuts
vim.keymap.set({ "n", "x", "o" }, "<leader>h", "^")
vim.keymap.set({ "n", "x", "o" }, "<leader>l", "g_")
vim.keymap.set("n", "<leader>a", ":keepjumps normal! ggVG<cr>")

-- Basic system clipboard interaction
vim.keymap.set({ "n", "x" }, "gy", '"+y') -- copy
vim.keymap.set({ "n", "x" }, "gp", '"+p') -- paste

-- Delete text but don't polute register with minor deletions
vim.keymap.set({ "n", "x" }, "x", '"_x')
vim.keymap.set({ "n", "x" }, "X", '"_d')

-- Commands
vim.keymap.set("n", "<leader>w", "<cmd>write<cr>")

-- ========================================================================== --
-- ==                               PLUGINS                                == --
-- ========================================================================== --

local lazy = {}

function lazy.install(path)
	if not vim.loop.fs_stat(path) then
		print("Installing lazy.nvim....")
		vim.fn.system({
			"git",
			"clone",
			"--filter=blob:none",
			"https://github.com/folke/lazy.nvim.git",
			"--branch=stable", -- latest stable release
			path,
		})
	end
end

function lazy.setup(plugins)
	if vim.g.plugins_ready then
		return
	end

	-- You can "comment out" the line below after lazy.nvim is installed
	lazy.install(lazy.path)

	vim.opt.rtp:prepend(lazy.path)

	require("lazy").setup(plugins, lazy.opts)
	vim.g.plugins_ready = true
end

lazy.path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
lazy.opts = {}

lazy.setup({
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},
	{
		"nvim-mini/mini.align",
		version = "*",
		event = "VeryLazy",
		config = function()
			require("mini.align").setup()
		end,
	},

	{
		"smoka7/hop.nvim",
		version = "*",
		opts = {
			keys = "etovxqpdygfblzhckisuran",
		},
		-- config = function()
		-- local hop = require('hop')
		-- local directions = require('hop.hint').HintDirection  -- AND THIS

		--     hop.setup({ keys = 'etovxqpdygfblzhckisuran' })

		--     vim.keymap.set('', 'f', function()
		--         hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = false })
		--     end, { remap = true })
		-- 		vim.keymmap.set('', 'F', function()

		-- 		hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = false })
		-- 		end, {remap=true})

		-- 		vim.keymap.set('', 't', function()
		-- 	  hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = false, hint_offset = -1 })
		-- 		end, {remap=true})

		-- 		vim.keymap.set('', 'T', function()
		-- 		hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = false, hint_offset = 1 })
		-- 		end, {remap=true})
		-- end
	},
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		---@type Flash.Config
		opts = {
			modes = {
				search = {
					enabled = true,
				},
				char = {
					jump_labels = true,
				},
			},
		},
		keys = {
			{
				"<leader>s",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump({
            remote_op = {
              restore = true,
              motion = true
            },
          })
				end,
				desc = "Flash",
			},
			{
				"<leader>S",
				mode = { "n", "x", "o" },
				function()
					require("flash").treesitter()
				end,
				desc = "Flash Treesitter",
			},
			{
				"<leader>r",
				mode = "o",
				function()
					require("flash").remote()
				end,
				desc = "Remote Flash",
			},
			{
				"<leader>R",
				mode = { "o", "x" },
				function()
					require("flash").treesitter_search()
				end,
				desc = "Treesitter Search",
			},
			{
				"<c-s>",
				mode = { "c" },
				function()
					require("flash").toggle()
				end,
				desc = "Toggle Flash Search",
			},
		},
	},
})
