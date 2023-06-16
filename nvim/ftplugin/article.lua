local nmap = require('core.utils').map('n')

vim.opt.readonly = true
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.statuscolumn = ' '
vim.opt.breakat:remove { '/', '.', ':' }

vim.opt.buftype = 'nofile'
vim.opt.bufhidden = 'hide'
vim.opt.swapfile = false

nmap('q', '<cmd>q!<cr>')

vim.api.nvim_set_hl(0, 'Whitespace', { bg = '' })
