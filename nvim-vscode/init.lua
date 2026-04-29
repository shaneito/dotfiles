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
vim.opt.expandtab = false

-- ========================================================================== --
-- ==                             KEYBINDINGS                              == --
-- ========================================================================== --

-- Space as leader key
vim.g.mapleader = " "

vim.keymap.set("i", "jj", "<ESC>", { desc = "Exit insert mode with jk" })

-- Shortcuts
vim.keymap.set({ "n", "x", "o" }, "<leader>h", "^")
vim.keymap.set({ "n", "x", "o" }, "<leader>l", "g_")
vim.keymap.set("n", "<leader>a", ":keepjumps normal! ggVG<cr>")

-- Basic clipboard interaction
vim.keymap.set({ "n", "x" }, "gy", '"+y') -- copy
vim.keymap.set({ "n", "x" }, "gp", '"+p') -- paste

-- Delete text
vim.keymap.set({ "n", "x" }, "x", '"_x')
vim.keymap.set({ "n", "x" }, "X", '"_d')

-- Commands
vim.keymap.set("n", "<leader>w", "<cmd>write<cr>")
vim.keymap.set("n", "<leader>bq", "<cmd>bdelete<cr>")
vim.keymap.set("n", "<leader>bl", "<cmd>buffer #<cr>")

-- place this in one of your configuration file(s)
-- local hop = require('hop')
-- local directions = require('hop.hint').HintDirection
-- vim.keymap.set('', 'f', function()
--   hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
-- end, {remap=true})
-- vim.keymap.set('', 'F', function()
--   hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
-- end, {remap=true})
-- vim.keymap.set('', 't', function()
--   hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
-- end, {remap=true})
-- vim.keymap.set('', 'T', function()
--   hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
-- end, {remap=true})

-- ========================================================================== --
-- ==                               COMMANDS                               == --
-- ========================================================================== --

vim.api.nvim_create_user_command("ReloadConfig", "source $MYVIMRC", {})

local group = vim.api.nvim_create_augroup("user_cmds", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight on yank",
	group = group,
	callback = function()
		vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "help", "man" },
	group = group,
	command = "nnoremap <buffer> q <cmd>quit<cr>",
})

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

	-- {
	-- 	'smoka7/hop.nvim',
	-- 	version = '*',
	-- 	opts = {
	-- 		keys = 'etovxqpdygfblzhckisuran'
	-- 	}
	-- },
})

-- ========================================================================== --
-- ==                         PLUGIN CONFIGURATION                         == --
-- ========================================================================== --
