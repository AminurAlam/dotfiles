vim.wo.wrap = false
vim.wo.statusline = '%#stl_hl_b# %t %{ &modified ? "󰆓 " : "" }'
  .. '%#stl_hl_to#%#Normal# %='
  .. '%{ v:hlsearch ? g:stl.hlsearch(searchcount()) : "" } '
  .. '%{ g:stl.progress(line("."), line("$")) } '
