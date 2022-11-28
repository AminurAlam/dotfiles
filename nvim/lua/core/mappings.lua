vim.g.mapleader = ' '
local opts = { noremap = true, silent = true }

local function nmap(k, v) vim.keymap.set('n', k, v, opts) end
local function vmap(k, v) vim.keymap.set('v', k, v, opts) end
local function umap(k, v) vim.keymap.set({ '', 'i' }, k, v, opts) end

-- telescope
nmap('<leader>ff', require('telescope.builtin').fd)
nmap('<leader>fg', require('telescope.builtin').live_grep)
nmap('<leader>fb', require('telescope.builtin').buffers)
nmap('<leader>fh', require('telescope.builtin').help_tags)

-- packer
nmap('<leader>pup', '<cmd>:PackerUpdate<cr>')
nmap('<leader>pin', '<cmd>:PackerInstall<cr>')
nmap('<leader>pun', '<cmd>:PackerClean<cr>')
nmap('<leader>pab', '<cmd>:PackerStatus<cr>')

-- cybu / buffer movement
umap('<c-right>', '<cmd>:CybuNext<cr>')
umap('<c-left>', '<cmd>:CybuPrev<cr>')
umap('<c-l>', '<cmd>:CybuNext<cr>')
umap('<c-h>', '<cmd>:CybuPrev<cr>')

-- other plugins
-- nmap('<leader>tr', '<cmd>:TroubleToggle document_diagnostics<cr>')
nmap('<leader>tr', require('trouble').toggle)
nmap('<leader>tt', '<cmd>:ToggleTerm<cr>')
nmap('<leader>co', '<cmd>:ColorizerToggle<cr>')
nmap('<leader>ib', '<cmd>:IndentBlanklineToggle<cr>')

-- other
nmap('Q', '<cmd>:bdelete<cr>')
nmap('r', '<cmd>:redo<cr>')
nmap('x', '"_x') -- deleted stuff doesnt go to clipboard
nmap('X', '"_x') -- deleted stuff doesnt go to clipboard
nmap('<del>', '"_x') -- deleted stuff doesnt go to clipboard
nmap('cn', '*``cgn')
nmap('cN', '*``cgN')

nmap('<leader>li', '<cmd>:LspInfo<cr>')
nmap('<leader>/', '<cmd>:nohlsearch<cr>')
nmap('<esc>', '<cmd>:nohlsearch<cr><esc>')
nmap('<leader>d ', '<cmd>:%s/\\s*$//g<cr><cmd>:nohlsearch<cr>') -- removes trailing whitespace

vmap('<s-j>', ":m '>+1<cr>gv")
vmap('<s-k>', ":m '<-2<cr>gv")

umap('<c-q>', '<cmd>:q<cr>')
umap('<c-w>', '<cmd>:w<cr>')

umap('<c-u>', '<c-y><c-y><c-y><c-y><c-y><c-y><c-y><c-y><c-y><c-y><c-y><c-y><c-y><c-y><c-y>')
umap('<c-d>', '<c-e><c-e><c-e><c-e><c-e><c-e><c-e><c-e><c-e><c-e><c-e><c-e><c-e><c-e><c-e>')

-- https://kevinli.co/posts/2017-01-19-multiple-cursors-in-500-bytes-of-vimscript/
