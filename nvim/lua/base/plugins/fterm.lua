return {
	"numToStr/FTerm.nvim",
	config = function()
		local FTerm = require("FTerm")
		FTerm.setup({
			vim.keymap.set("n", "<C-t>", '<CMD>lua require("FTerm").toggle()<CR>'),
		})
	end,
}
