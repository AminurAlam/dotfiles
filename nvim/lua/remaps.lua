local map = vim.keymap.set
vim.g.mapleader = ' '
map('n', '<Leader>ff', '<cmd>lua require(\'telescope.builtin\').find_files()<cr>', {noremap = true})
map('n', '<leader>tr', '<cmd>:TroubleToggle<cr>', {noremap = true})
map('n', '<leader>ex', '<cmd>:Explore<cr>', {noremap = true})
map('n', '<leader>co', '<cmd>:ColorizerToggle<cr>', {noremap = true})

map('n', '<C-q>', '<cmd>:q<cr>', {noremap = true})
map('n', '<C-w>', '<cmd>:w<cr>', {noremap = true})
map('i', '<C-q>', '<cmd>:q<cr>', {noremap = true})
map('i', '<C-w>', '<cmd>:w<cr>', {noremap = true})
map('n', '<C-n>', '<cmd>:bn<cr>', {noremap = true})
map('n', '<C-p>', '<cmd>:bp<cr>', {noremap = true})
map('i', '<C-n>', '<cmd>:bn<cr>', {noremap = true})
map('i', '<C-p>', '<cmd>:bp<cr>', {noremap = true})
