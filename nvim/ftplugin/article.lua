local nmap = function(lhs, rhs)
  vim.keymap.set('n', lhs, rhs, {
    noremap = true,
    silent = true,
  })
end

vim.opt.listchars = { trail = ' ' }
vim.opt.stc = '  '
vim.opt.buftype = 'hidden'

nmap('^', '<cmd>qall!<cr>')
nmap('<bs>', '<cmd>qall!<cr>')
