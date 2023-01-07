-- https://kevinli.co/posts/2017-01-19-multiple-cursors-in-500-bytes-of-vimscript/

local opts = { noremap = true, silent = true }

local function nmap(k, v) vim.keymap.set('n', k, v, opts) end
local function vmap(k, v) vim.keymap.set('v', k, v, opts) end
local function umap(k, v) vim.keymap.set({ '', 'i' }, k, v, opts) end

-- telescope
nmap('<leader>ff', '<cmd>:Telescope find_files<cr>')
nmap('<leader>fr', '<cmd>:Telescope oldfiles<cr>')
nmap('<leader>fg', '<cmd>:Telescope live_grep<cr>')
nmap('<leader>fb', '<cmd>:Telescope buffers<cr>')
nmap('<leader>fh', '<cmd>:Telescope help_tags<cr>')

-- packer
nmap('<leader>pu', '<cmd>:PackerUpdate<cr>')
nmap('<leader>pi', '<cmd>:PackerInstall<cr>')
nmap('<leader>pr', '<cmd>:PackerClean<cr>')
nmap('<leader>pa', '<cmd>:PackerStatus<cr>')

-- cybu
umap('<c-left>', '<cmd>:CybuPrev<cr>')
umap('<c-right>', '<cmd>:CybuNext<cr>')

-- other plugins
nmap('<leader>tr', '<cmd>:TroubleToggle<cr>')
nmap('<leader>co', '<cmd>:ColorizerToggle<cr>')
nmap('<leader>ib', '<cmd>:IndentBlanklineRefresh<cr>')
nmap('<leader>li', '<cmd>:LspInfo<cr>')
nmap('<leader>tt', '<cmd>:topleft 8sp | term <cr>')

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

nmap('v', 'm`v')
nmap('V', 'm`V')
nmap('<c-v>', 'm`<c-v>')
vim.keymap.set('x', '<esc>', '<esc>:keepjumps normal ``<cr>')

umap('<c-up>', '<c-home>')
umap('<c-down>', '<c-end>')
vmap('<c-up>', ":m '<-2<cr>gv")
vmap('<c-down>', ":m '>+1<cr>gv")

umap('<c-q>', '<cmd>:q<cr>')
umap('<c-w>', '<cmd>:w<cr>')
umap('<c-j>', '<cmd>:normal va%J<cr>')
