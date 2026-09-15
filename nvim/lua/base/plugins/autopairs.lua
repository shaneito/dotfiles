return {
	"windwp/nvim-autopairs",
	event = { "InsertEnter" },
	dependencies = {
		"hrsh7th/nvim-cmp",
	},
	config = function()
		-- import nvim-autopairs
		local autopairs = require("nvim-autopairs")

		-- configure autopairs
		autopairs.setup({
			check_ts = true, -- enable treesitter
			ts_config = {
				map_cr = true,
				lua = { "string" },
				javascript = { "template_string" },
			},
		})

		-- import nvim-autopairs completion functionality
		local cmp_autopairs = require("nvim-autopairs.completion.cmp")

		-- import nvim-cmp plugin (completions plugin)
		local cmp = require("cmp")

		-- make autopairs and completion work together
		cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

		-- Tab to jump out of a closing character
		vim.keymap.set("i", "<Tab>", function()
			local closers = { ")", "]", "}", '"', "'", "`" }
			local line = vim.api.nvim_get_current_line()
			local col = vim.api.nvim_win_get_cursor(0)[2] + 1

			if require("luasnip").jumpable(1) then
				return "<Plug>luasnip-jump-next" -- advance through snippet placeholders
			elseif vim.tbl_contains(closers, line:sub(col, col)) then
				return "<Right>" -- jump out of closing char
			else
				return "<Tab>" -- normal tab
			end
		end, { expr = true })
	end,
}
