vim.keymap.set('n', '<cr>', 'K', { buffer = true })
vim.keymap.set('n', '<bs>', '<c-o>', { buffer = true })

vim.wo.wrap = false
vim.wo.statusline = '%#stl_hl_b# %t %{ &modified ? "󰆓 " : "" }'
  .. '%#stl_hl_to#%#Normal# %='
  .. '%{ v:hlsearch ? g:stl.hlsearch(searchcount()) : "" } '
  .. '%{ g:stl.progress(line("."), line("$")) } '
