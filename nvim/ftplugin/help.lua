vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.statuscolumn = ' '

vim.keymap.set('n', '<cr>', 'K', { buffer = true })
vim.keymap.set('n', '<bs>', '<c-o>', { buffer = true })

vim.treesitter.start()
