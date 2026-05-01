local macro = function(reg, expr)
  vim.cmd.let(string.format([[@%s = '%s']], reg, expr))
end
local nmap = function(lhs, rhs)
  vim.keymap.set('n', lhs, rhs)
end
local vmap = function(lhs, rhs)
  vim.keymap.set('x', lhs, rhs)
end
local map = vim.keymap.set

-- movement
map({ '', 'i' }, '<c-up>', '<cmd>bp<cr>')
map({ '', 'i' }, '<c-down>', '<cmd>bn<cr>')
map({ '', 'i' }, '<c-k>', '<cmd>bp<cr>')
map({ '', 'i' }, '<c-j>', '<cmd>bn<cr>')

-- deleting & registers
nmap('_', '"_')
nmap('s', '"_s')
nmap('x', '"_x')
vmap('p', '"_dp')
nmap('<del>', '"_x')
nmap('y<esc>', function() end)
nmap('cn', '*``"_cgn') -- https://www.kevinli.co/posts/2017-01-19-multiple-cursors-in-500-bytes-of-vimscript/
nmap('<bs>', 'X')
nmap('<cr>', '"_ciw')
nmap('r', '<cmd>silent redo<cr>')

-- write & quit
nmap('<leader>w', '<cmd>silent w <bar> redraw <cr>')
nmap('q', "<cmd>if len(getbufinfo({'buflisted': 1})) == 1|q|else|bd|endif<cr>")
nmap('Q', 'q')

-- indent & fold
nmap('=', '==')
nmap('>', '>>')
nmap('<', '<<')
vmap('>', '>gv')
vmap('<', '<gv')
nmap('zM', '<nop>')

-- toggles
nmap('zs', '<cmd>setlocal spell!<cr>')
nmap('zw', '<cmd>setlocal wrap!<cr>')
nmap('zf', '<cmd>let g:save_fmt=g:save_fmt?v:false:v:true<cr>')
nmap('zn', function()
  if vim.o.number then
    vim.o.number = false
    vim.o.signcolumn = 'no'
  else
    vim.o.number = true
    vim.o.signcolumn = 'auto:1'
  end
end)

-- other
nmap('<leader>d', vim.diagnostic.open_float)
nmap('<leader>t', '<cmd>split | term<cr><cmd>startinsert<cr>')
vmap('.', ':norm .<cr>')
nmap(';', '@:')
nmap('<esc>', '<cmd>nohlsearch<cr><esc>')
nmap('gj', [[@='j^"_d0kgJ'<cr>]])
nmap('+', '<plug>(dial-increment)')
nmap('-', '<plug>(dial-decrement)')

-- visual
vmap('v', function()
  vim.fn.feedkeys(({ v = 'V', V = '\22', ['\22'] = '' })[vim.api.nvim_get_mode().mode])
end)

-- cmdline & abbreviations
map({ 'c' }, '<c-j>', '<down>')
map({ 'c' }, '<c-k>', '<up>')
map({ 'ca' }, 'msg', 'messages')
map({ 'ca' }, 'in', 'Inspect')
map({ 'ca' }, 'it', 'InspectTree')
map(
  { 'ca' },
  'pu',
  'lua vim.pack.update' .. (os.getenv 'USER' == 'fisher' and '()' or '(nil, {target = "lockfile"})')
)

-- macros
macro('m', [[mmA;`m]]) -- put ; at end of statements
macro('x', [[$T["_sx]]) -- mark todo as complete
macro('f', [[mmF"if`m]]) -- convert python string to format string
