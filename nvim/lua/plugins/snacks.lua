return {
  "folke/snacks.nvim",
  version = false,
  event = "VeryLazy",
  opts = {
    bigfile = { enabled = true },
    image = { enabled = true },
    indent = { enabled = true },
    notifier = { enabled = true },
    scroll = { enabled = true },
    words = { enabled = true },

    picker = {
      enabled = true,
      layout = {
        preset = "default",
      },
    },

    explorer = {
      enabled = true,
    },

    input = {
      enabled = true,
    },
  },
  keys = {
    {
      "<leader>fe",
      function()
        require("snacks").explorer()
      end,
      desc = "Explorer",
    },
    {
      "<leader>ff",
      function()
        require("snacks").picker.files()
      end,
      desc = "Find Files",
    },
    {
      "<leader>fg",
      function()
        require("snacks").picker.grep()
      end,
      desc = "Live Grep",
    },
    {
      "<leader>fb",
      function()
        require("snacks").picker.buffers()
      end,
      desc = "Buffers",
    },
  },
}
