vim.opt_local.conceallevel = 2
vim.opt_local.concealcursor = 'n'
vim.opt_local.listchars = {
  tab = '  ',
  leadmultispace = '  ',
  trail = ' ',
}

vim.api.nvim_set_hl(0, 'Whitespace', {})
