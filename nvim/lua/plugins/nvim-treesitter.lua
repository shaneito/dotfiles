
-- ================================================================================================
-- TITLE : nvim-treesitter + nvim-treesitter-textobjects
-- ABOUT : Syntax-aware highlighting, indentation, folding and text objects.
--         Uses the `main` branch (the rewrite; `master` is frozen). On `main` the plugin only
--         installs parsers, so highlighting, indent and folds are switched on per buffer in
--         the FileType autocmd below.
-- LINKS :
--   > github : https://github.com/nvim-treesitter/nvim-treesitter
--   > github : https://github.com/nvim-treesitter/nvim-treesitter-textobjects
-- REQUIREMENTS :
--   > neovim         : a recent release (check the plugin README for the minimum)
--   > C compiler     : xcode-select --install
--   > tree-sitter    : brew install tree-sitter-cli
-- COMMANDS :
--   > :TSInstall <lang>             install a parser
--   > :TSUpdate                     update all parsers
--   > :InspectTree                  show the syntax tree for the current buffer
--   > :Inspect                      show highlight groups under the cursor
--   > :checkhealth nvim-treesitter  check compiler, CLI and installed parsers
-- KEYMAPS :
--   > af / if   select function (outer / inner)        [visual, operator-pending]
--   > ac / ic   select class (outer / inner)
--   > aa / ia   select argument (outer / inner)
--   > ]f / [f   next / previous function start         [normal, visual, operator-pending]
--   > ]c / [c   next / previous class start            (overrides built-in diff ]c / [c)
--   > ]a / [a   next / previous argument
-- ================================================================================================

local parsers = {
  -- Neovim / config editing
  "lua", "luadoc", "vim", "vimdoc", "query", "regex",
  -- Shell and config formats
  "bash", "toml", "yaml", "json", "ini", "gitignore", "gitcommit", "diff",
  -- Writing
  "markdown", "markdown_inline",
  -- Languages
  "javascript", "typescript", "tsx", "html", "css",
  "python", "c", "cpp", "arduino",
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false, -- the main branch does not support lazy-loading
    build = ":TSUpdate",
    config = function()
      local ts = require("nvim-treesitter")
      ts.setup()
      ts.install(parsers) -- async; no-op for parsers already installed

      -- zsh has no parser of its own; bash is close enough
      vim.treesitter.language.register("bash", "zsh")

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("user_treesitter", { clear = true }),
        callback = function(args)
          -- Only attach if a parser for this filetype is installed
          if not pcall(vim.treesitter.start, args.buf) then
            return
          end
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          vim.wo.foldmethod = "expr"
          vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
          vim.wo.foldlevel = 99 -- start with all folds open
        end,
      })
    end,
  },

  -- Text objects and motions built on the syntax tree
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = "VeryLazy",
    config = function()
      require("nvim-treesitter-textobjects").setup({
        select = { lookahead = true }, -- jump forward to the next match
        move = { set_jumps = true }, -- add moves to the jumplist
      })

      local select = require("nvim-treesitter-textobjects.select")
      local move = require("nvim-treesitter-textobjects.move")

      -- Select: vaf / vif (function), vac / vic (class), vaa / via (argument)
      local objects = {
        af = "@function.outer",
        ["if"] = "@function.inner",
        ac = "@class.outer",
        ic = "@class.inner",
        aa = "@parameter.outer",
        ia = "@parameter.inner",
      }
      for key, query in pairs(objects) do
        vim.keymap.set({ "x", "o" }, key, function()
          select.select_textobject(query, "textobjects")
        end, { desc = "TS select " .. query })
      end

      -- Move: ]f [f (function), ]c [c (class), ]a [a (argument)
      local motions = {
        f = "@function.outer",
        c = "@class.outer",
        a = "@parameter.inner",
      }
      for key, query in pairs(motions) do
        vim.keymap.set({ "n", "x", "o" }, "]" .. key, function()
          move.goto_next_start(query, "textobjects")
        end, { desc = "Next " .. query })
        vim.keymap.set({ "n", "x", "o" }, "[" .. key, function()
          move.goto_previous_start(query, "textobjects")
        end, { desc = "Prev " .. query })
      end
    end,
  },
}
