local set = vim.opt

set.wrap = true
set.linebreak = true
set.statuscolumn = vim.g.stc_symbol

vim.keymap.set('n', '<cr>', 'K', { buffer = true })
vim.keymap.set('n', '<bs>', '<c-o>', { buffer = true })

vim.cmd('hi Whitespace guibg=NONE')
