local opts = { noremap = true, silent = true }

local function nmap(k, v) vim.keymap.set('n', k, v, opts) end
local function vmap(k, v) vim.keymap.set('v', k, v, opts) end
local function umap(k, v) vim.keymap.set({ '', 'i' }, k, v, opts) end

-- packer
nmap('<leader>pu', '<cmd>:Lazy update<cr>')
nmap('<leader>pr', '<cmd>:Lazy clean<cr>')
nmap('<leader>pa', '<cmd>:Lazy show<cr>')

-- other plugins
nmap('<leader>co', '<cmd>:ColorizerToggle<cr>')
nmap('<leader>li', '<cmd>:LspInfo<cr>')

-- void register
nmap('_', '"_')
nmap('x', '"_x')
nmap('X', '"_x')
nmap('<del>', '"_x')

-- other
umap('<c-c>', '<cmd>:normal m0viw~`0<cr>') -- switch word case
nmap('Q', '<cmd>:bdelete<cr>')
nmap('r', '<cmd>:redo<cr>')
nmap('cn', '*``cgn') -- search and replace
nmap('>', '>>')
nmap('<', '<<')
vmap('>', '>gv')
vmap('<', '<gv')

umap('<esc>', '<cmd>:nohlsearch<cr><esc>')
nmap('<leader>/', '<cmd>:nohlsearch<cr>')
nmap('<leader>d ', '<cmd>:%s/\\s*$//g<cr><cmd>:nohlsearch<cr>') -- removes trailing whitespace

vmap('<c-up>', ":m '<-2<cr>gv")
vmap('<c-down>', ":m '>+1<cr>gv")

umap('<c-q>', '<cmd>:q<cr>')
umap('<c-w>', '<cmd>:w<cr>')
umap('<c-j>', '<cmd>:normal va%J<cr>')

nmap('<c-^>', '<c-home>')
nmap('<c-$>', '<c-end>')

nmap('+', '<c-a>')
nmap('-', '<c-x>')
-- https://kevinli.co/posts/2017-01-19-multiple-cursors-in-500-bytes-of-vimscript/
