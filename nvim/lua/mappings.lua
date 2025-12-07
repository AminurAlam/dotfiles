---@param mode table
---@return function
local map = function(mode)
  ---@param lhs string
  ---@param rhs string|function
  ---@param desc string?
  return function(lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, {
      noremap = true,
      silent = true,
      desc = desc,
    })
  end
end

local fn = vim.fn
local macro = function(reg, expr)
  vim.cmd.let(string.format([[@%s = '%s']], reg, expr))
end
local nmap = map { 'n' }
local vmap = map { 'x' }
local umap = map { '', 'i' }

-- movement
umap('<c-left>', '<cmd>bp<cr>', 'previous buffer')
umap('<c-right>', '<cmd>bn<cr>', 'next buffer')
umap('<c-up>', '<cmd>bp<cr>', 'previous buffer')
umap('<c-down>', '<cmd>bn<cr>', 'next buffer')
umap('<c-k>', '<cmd>bp<cr>', 'previous buffer')
umap('<c-j>', '<cmd>bn<cr>', 'next buffer')

-- deleting & registers
nmap('_', '"_', 'use void register')
nmap('s', '"_s')
nmap('x', '"_x')
vmap('p', '"_dp')
nmap('<del>', '"_x')
nmap('y<esc>', function() end)
nmap('cn', '*``"_cgn', 'search and replace') -- https://www.kevinli.co/posts/2017-01-19-multiple-cursors-in-500-bytes-of-vimscript/
nmap('<bs>', 'X', 'backspace in normal mode')
nmap('<cr>', '"_ciw', 'delete word at cursor')
nmap('r', '<cmd>silent redo<cr>')

-- write & quit
nmap('<leader>w', '<cmd>silent w <bar> redraw <cr>', 'write')
nmap('<leader>W', '<cmd>silent w <bar> redraw <cr>', 'write')
nmap('q', "<cmd>if len(getbufinfo({'buflisted': 1})) == 1|q|else|bd|endif<cr>", 'quit buffer')
nmap('Q', 'q', 'record macro')

-- indent & fold
nmap('=', '==')
nmap('>', '>>')
nmap('<', '<<')
vmap('>', '>gv')
vmap('<', '<gv')

-- toggles
nmap('<leader>ss', '<cmd>setlocal spell!<cr>', 'toggle spell')
nmap('<leader>sw', '<cmd>setlocal wrap!<cr>', 'toggle wrap')
nmap('<leader>st', '<cmd>set ts=4 sw=4 sts=4 si sta et sr<cr>', 'use spaces over tab')
nmap('<leader>sf', '<cmd>let g:save_fmt=g:save_fmt?v:false:v:true<cr>', 'toggle formatting on save')
nmap('<leader>sn', function()
  if vim.o.number then
    vim.o.number = false
    vim.o.relativenumber = false
    vim.o.signcolumn = 'no'
    vim.o.foldcolumn = '0'
  else
    vim.o.number = true
    vim.o.relativenumber = true
    vim.o.signcolumn = 'auto'
    vim.o.foldcolumn = 'auto'
  end
end, 'toggle statuscolumn')

-- other
nmap('<leader>d', vim.diagnostic.open_float, 'view line diagnostics')
nmap('<leader>tt', '<cmd>split | term<cr><cmd>startinsert<cr>')
umap('<c-c>', 'g~iw', 'toggle word case')
vmap('.', ':norm .<cr>', 'dot repeat on all selected lines')
nmap(';', '@:', 'dot repeat the last command')
umap('<esc>', '<cmd>nohlsearch<cr><esc>')
nmap('gj', [[@='j^"_d0kgJ'<cr>]], 'join without leaving space')
nmap('go', 'jA', 'like `o` but on existing line')
nmap('<leader>y', '<cmd>silent %y<cr>', 'yank entire buffer')
nmap('<leader>y', function()
  fn.setreg('+', fn.getreg '0')
end, 'put last yank in sys clipboard')
nmap('<leader>p', '"+p', 'put last yank in sys clipboard')
nmap('<leader>a', 'moggVG<c-a>`o', 'increment all numbers')
nmap('+', '<plug>(dial-increment)')
nmap('-', '<plug>(dial-decrement)')
nmap('z=', '1z=')

-- visual
nmap('v', 'm`v') -- TODO: handle with autocmd
nmap('V', 'm`V')
nmap('<c-v>', 'm`<c-v>')
vmap('<esc>', '<esc><cmd>keepjumps norm ``<cr>') -- after umap '<esc>'
vmap('v', function() --
  fn.feedkeys(({ v = 'V', V = '\22', ['\22'] = '' })[vim.api.nvim_get_mode().mode])
end, 'repeat v to change visual mode')

-- cmdline & abbreviations
vim.cmd 'cmap <c-j> <down>'
vim.cmd 'cmap <c-k> <up>'

if fn.has('termux') == 1 and fn.has('nvim-0.10.0') == 1 then
  map { 'ca' }('vq', 'wq') -- dvorak
end
map { 'ca' }('msg', 'messages')

-- macros
macro('m', [[mmA;`m]]) -- put ; at end of statements
macro('x', [[$T["_sx]]) -- mark todo as complete
macro('f', [[mmF"if`m]]) -- convert python string to format string
