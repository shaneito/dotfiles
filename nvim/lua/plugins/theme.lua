return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  opts = {
    flavour = "frappe",
    transparent_background = true,
  },
  config = function(_, opts)
    require("catppuccin").setup(opts)
    vim.cmd.colorscheme("catppuccin")

    local transparent_groups = {
      "Normal",
      "NormalFloat",
      "FloatBorder",
      "SignColumn",
      "EndOfBuffer",
      "MsgArea",
      "Folded",
      "LineNr",
      "CursorLineNr",
      "StatusLine",
      "StatusLineNC",
    }

    for _, group in ipairs(transparent_groups) do
      vim.api.nvim_set_hl(0, group, { bg = "none" })
    end
  end,
}
