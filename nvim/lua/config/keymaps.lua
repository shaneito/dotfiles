vim.keymap.set('i', 'jk', '<ESC>', { desc = 'Exit insert mode with jk' })

vim.keymap.set('n', '<leader>nh', ':nohl<CR>', { desc = 'Clear search highlights' })
vim.keymap.set('n', '<leader>o', ':update<CR> :source<CR>', { desc = 'Reload Neovim' })
vim.keymap.set('n', '<leader>w', ':write<CR>', { desc = 'Write File' })
vim.keymap.set('n', '<leader>q', ':quit<CR>', { desc = 'Quit Neovim' })


vim.keymap.set('n', 'L', '$', { desc = 'Move to end of line' })
vim.keymap.set('n', 'H', '0', { desc = 'Move to start of line' })

-- increment/decrement numbers
vim.keymap.set('n', '<leader>=', '<C-a>', { desc = 'Increment number' }) -- increment
vim.keymap.set('n', '<leader>-', '<C-x>', { desc = 'Decrement number' }) -- decrement
vim.keymap.set('n', '<leader>sc', ':so ~/.config/nvim/init.lua<CR>', { desc = 'Reload config'})
vim.keymap.set('n', '<leader>w', ':w<CR>', { desc = 'Save File' })
vim.keymap.set('n', '<leader>q', ':q<CR>', { desc = 'Quit Neovim' })

-- Move lines
vim.keymap.set('x', 'J', ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set('x', 'K', ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

vim.keymap.set('n', '<A-j>', ':m .+1<CR>==', { noremap = true, silent = true })
vim.keymap.set('n', '<A-k>', ':m .-2<CR>==', { noremap = true, silent = true })

-- Yank to black hole register
vim.keymap.set('x', '<leader>p', '"_dP', { noremap = true, silent = true })
vim.keymap.set({ 'n', 'v' }, '<leader>d', '"_d', { noremap = true, silent = true })
vim.keymap.set({ 'n', 'v' }, '<leader>c', '"_c', { noremap = true, silent = true })

vim.keymap.set("n", "<leader>e", function()
  require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
end, { desc = "Open mini.files" })

vim.keymap.set("n", "-", function()
  require("mini.files").open(vim.api.nvim_buf_get_name(0), false)
end, { desc = "Open mini.files in current directory" })
