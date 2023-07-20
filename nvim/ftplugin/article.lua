vim.opt_local.listchars = { trail = ' ' }
vim.opt_local.stc = '  '
vim.opt_local.buftype = 'nofile'
vim.opt_local.bufhidden = 'hide'

vim.keymap.set('n', '^', '<cmd>qall!<cr>', { buffer = true })
vim.keymap.set('n', '<bs>', '<cmd>qall!<cr>', { buffer = true })
