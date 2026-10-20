return {
  "nvim-mini/mini.nvim",
  version = false,
  event = "VeryLazy",
  config = function()
    require("mini.files").setup({
      options = {
        permanent_delete = false,
        use_as_default_explorer = true,
      },
      windows = {
        preview = true,
        width_focus = 50,
        width_nofocus = 15,
        width_preview = 25,
      },
    })

    require("mini.surround").setup()
    require("mini.comment").setup()
    require("mini.align").setup()
    require("mini.ai").setup()
  end,
}
