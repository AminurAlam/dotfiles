local set = vim.opt

set.conceallevel = 3
set.concealcursor = 'n'
set.foldmethod = 'expr'
set.foldexpr = [[getline(v:lnum)=~'^$'?0:1]]
set.commentstring = '# %s'
set.foldtext = 'getline(v:foldstart) .. " [" .. (v:foldend-v:foldstart) .. " links]"'
