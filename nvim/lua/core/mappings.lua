---@param mode table
---@return function
local map = function(mode)
  ---@param lhs string
  ---@param rhs string|function
  ---@param desc string|nil
  return function(lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, {
      noremap = true,
      silent = true,
      desc = desc,
    })
  end
end

local nmap = map { 'n' }
local vmap = map { 'x' }
local umap = map { '', 'i' }
local abbr = map { 'ca' }

-- lazy
nmap('<leader>pu', require('lazy').update, 'update plugins')
nmap('<leader>pp', require('lazy').profile, 'open profiler')
nmap('<leader>pa', require('lazy').home, 'plugins info')

-- movement
umap('<c-left>', '<cmd>CybuPrev<cr>', 'previous buffer')
umap('<c-right>', '<cmd>CybuNext<cr>', 'next buffer')
nmap('[b', '<cmd>CybuPrev<cr>', 'previous buffer')
nmap(']b', '<cmd>CybuNext<cr>', 'next buffer')
nmap('[t', '<cmd>tabp<cr>', 'previous tab')
nmap(']t', '<cmd>tabn<cr>', 'next tab')

-- git
nmap('H', require('gitsigns').preview_hunk, 'preview hunk')
nmap('U', require('gitsigns').reset_hunk, 'undo hunk')
nmap('[h', require('gitsigns').prev_hunk, 'goto previous hunk')
nmap(']h', require('gitsigns').next_hunk, 'goto next hunk')

-- other plugins
nmap('<leader>tt', require('lazy.util').float_term)
nmap('<leader>j', '<cmd>TSJToggle<cr>') -- norm v%J

-- deleting & registers
nmap('_', '"_', 'use void register')
nmap('x', '"_x')
nmap('X', '"_x')
nmap('<del>', '"_x')
nmap('cn', '*``"_cgn', 'search and replace') -- https://kevinli.co/posts/2017-01-19-multiple-cursors-in-500-bytes-of-vimscript/
nmap('d<space>', [[m`<cmd>keeppatterns %s/\s\+$//e<cr>``]], 'delete trailing whitespace')
nmap('<bs>', 'i<bs><esc>l', 'backspace in normal mode')

-- write & quit
nmap('<leader>w', '<cmd>silent w <bar> redraw <cr>', 'write')
umap('<c-w>', '<cmd>silent w <bar> redraw <cr>', 'write')
umap('<c-q>', '<cmd>qa<cr>', 'quit')
nmap('Q', '<cmd>bdelete<cr>', 'quit buffer')

-- indent
nmap('=', '==')
nmap('>', '>>')
nmap('<', '<<')
vmap('>', '>gv')
vmap('<', '<gv')

-- other
umap('<c-c>', '<cmd>norm m`viw~``<cr>', 'toggle word case')
vmap('.', ':norm .<cr>', 'dot repeat on all selected lines')
umap('<esc>', '<cmd>nohlsearch<cr><esc>')
nmap('gj', [[@='j^"_d0kgJ'<cr>]], 'join without leaving space')

-- keep cursor position if you exit visual selection
nmap('v', 'm`v')
nmap('V', 'm`V')
nmap('<c-v>', 'm`<c-v>')
vmap('<esc>', '<esc>:keepjumps norm ``<cr>') -- after umap '<esc>'

-- scrolling
umap('<c-u>', string.rep('<cmd>norm k<cr><cmd>sl 1m<cr>', vim.o.scroll))
umap('<c-d>', string.rep('<cmd>norm j<cr><cmd>sl 1m<cr>', vim.o.scroll))

-- toggles
nmap('<leader>ss', '<cmd>setlocal spell!<cr>', 'toggle spell')
nmap('<leader>sw', '<cmd>setlocal wrap!<cr>', 'toggle wrap')
nmap('<leader>sn', function() vim.o.stc = vim.o.stc ~= ' ' and ' ' or vim.g.stc end, 'toggle statuscolumn')

abbr('qw', 'q!') -- dvorak
abbr('qn', 'q!') -- qwert

if vim.fn.has('termux') == 1 then
  umap('<ScrollWheelUp>', '<c-y>')
  umap('<ScrollWheelDown>', '<c-e>')
  vim.keymap.set('i', '<ScrollWheelUp>', '<c-x><c-y>')
  vim.keymap.set('i', '<ScrollWheelDown>', '<c-x><c-e>')
end
