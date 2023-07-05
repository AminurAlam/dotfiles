local nmap = function(lhs, rhs)
  vim.keymap.set('n', lhs, rhs, {
    noremap = true,
    silent = true,
  })
end

vim.opt.listchars = { trail = ' ' }
vim.opt.stc = '  '
vim.opt.buftype = 'nofile'
vim.opt.bufhidden = 'hide'

nmap('^', '<cmd>qall!<cr>')
nmap('<bs>', '<cmd>qall!<cr>')
