-- local map = vim.keymap.set

local function noremap(mode, k, v)
	vim.keymap.set(mode, k, v, {noremap = true})
end

vim.g.mapleader = ' '

-- telescope
noremap('n', '<leader>ff', '<cmd>:Telescope find_files follow=true no_ignore=true hidden=true<cr>')
noremap('n', '<leader>fg', '<cmd>:Telescope live_grep<cr>')
noremap('n', '<leader>fb', '<cmd>:Telescope buffers<cr>')
noremap('n', '<leader>fh', '<cmd>:Telescope help_tags<cr>')

-- commands
noremap('n', '<leader>tr', '<cmd>:TroubleToggle<cr>')
noremap('n', '<leader>ex', '<cmd>:Explore<cr>')
noremap('n', '<leader>co', '<cmd>:ColorizerToggle<cr>')

-- write, quit
noremap('n', '<C-q>', '<cmd>:q<cr>')
noremap('n', '<C-w>', '<cmd>:w<cr>')
noremap('i', '<C-q>', '<cmd>:q<cr>')
noremap('i', '<C-w>', '<cmd>:w<cr>')

-- movement
noremap('n', '<C-n>', '<cmd>:bn<cr>')
noremap('n', '<C-p>', '<cmd>:bp<cr>')
noremap('i', '<C-n>', '<cmd>:bn<cr>')
noremap('i', '<C-p>', '<cmd>:bp<cr>')

-- noremap('n', '<C-1;5A>', '<cmd>:echo hi<cr>')
-- noremap('n', '<C-1;5B>', '<cmd>:echo hi<cr>')
-- noremap('i', '<C-1;5A>', '<cmd>:echo hi<cr>')
-- noremap('i', '<C-1;5B>', '<cmd>:echo hi<cr>')
