local set = vim.opt
local nmap = require('core.utils').map('n')

set.wrap = true
set.linebreak = true
set.statuscolumn = ' '

nmap('<cr>', 'K', { buffer = true, desc = 'open tag under cursor' })
nmap('<bs>', '<c-o>', { buffer = true, desc = 'go to older cursor position in jump list' })

vim.cmd('hi Whitespace guibg=NONE')
