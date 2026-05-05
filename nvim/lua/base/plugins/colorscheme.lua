return {
	{
		"sainnhe/gruvbox-material",
		priority = 1000,
		config = function()
			-- Palette options: "material", "mix", "original"
			vim.g.gruvbox_material_palette = "material"

			-- Background options: "hard", "medium", "soft"
			vim.g.gruvbox_material_background = "soft"

			-- Enable bold in UI elements
			vim.g.gruvbox_material_enable_bold = 1

			-- Enable italic for keywords, comments, etc.
			vim.g.gruvbox_material_enable_italic = 1

			-- Better performance by disabling treesitter highlights override
			vim.g.gruvbox_material_better_performance = 1

			-- Statusline style options: "default", "atlantis", "andromeda", "gruvbox", "everforest", "nightfly"
			vim.g.gruvbox_material_statusline_style = "gruvbox"

			-- Dim inactive windows to differentiate focus
			vim.g.gruvbox_material_dim_inactive_windows = 1

			-- Makes background slightly transparent
			vim.g.gruvbox_material_transparent_background = 1

			-- Load the colorscheme
			vim.cmd([[colorscheme gruvbox-material]])
		end,
	},
}
