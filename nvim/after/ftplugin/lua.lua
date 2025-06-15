local set = vim.opt

set.tabstop = 2
set.shiftwidth = 2
set.softtabstop = 2
set.autoindent = true
set.smartindent = true
set.smarttab = true
set.expandtab = true
set.shiftround = true
set.foldmethod = 'expr'
set.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
