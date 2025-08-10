vim.wo.conceallevel = 3
vim.wo.concealcursor = 'n'
vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = [[getline(v:lnum)=~'^$'?0:1]]
vim.bo.commentstring = '# %s'
vim.wo.foldtext = 'getline(v:foldstart) .. " [" .. (v:foldend-v:foldstart) .. " links]"'
