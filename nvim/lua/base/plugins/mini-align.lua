return {
	"nvim-mini/mini.align",
	version = "*",
	config = function()
		local minialign = require("mini.align")
		minialign.setup()
	end,
}
