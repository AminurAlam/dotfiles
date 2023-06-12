local nmap = require('core.utils').map('n')

vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.statuscolumn = ' '

nmap('<cr>', 'K', { buffer = true, desc = 'open tag under cursor' })
nmap('<bs>', '<c-o>', { buffer = true, desc = 'go to older cursor position in jump list' })

vim.treesitter.start()
