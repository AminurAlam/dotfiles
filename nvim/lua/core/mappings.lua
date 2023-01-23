local function nmap(k, v, opts) vim.keymap.set('n', k, v, opts or { noremap = true, silent = true }) end
local function vmap(k, v, opts) vim.keymap.set('v', k, v, opts or { noremap = true, silent = true }) end
local function umap(k, v, opts) vim.keymap.set({ '', 'i' }, k, v, opts or { noremap = true, silent = true }) end

-- https://kevinli.co/posts/2017-01-19-multiple-cursors-in-500-bytes-of-vimscript/

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
nmap('<leader>tt', '<cmd>:topleft 8sp | term <cr>i')

-- deleting & registers
nmap('_', '"_')
nmap('x', '"_x')
nmap('X', '"_x')
nmap('<del>', '"_x')
nmap('<bs>', 'i<bs><esc>l') -- backspace in normal mode

-- other
umap('<c-c>', '<cmd>:normal m`viw~``<cr>') -- switch word case
nmap('Q', '<cmd>:bdelete<cr>')
nmap('r', '<cmd>:redo<cr>')
nmap('<cr>', 'o<esc>')
nmap('cn', '*``cgn') -- search and replace
nmap('>', '>>')
nmap('<', '<<')
vmap('>', '>gv')
vmap('<', '<gv')

umap('<esc>', '<cmd>:nohlsearch<cr><esc>')
nmap('<leader>d ', 'm`<cmd>:%s/\\s\\+$//ge<cr><cmd>:nohlsearch<cr>``') -- removes trailing whitespace
nmap('<leader>ss', function() vim.opt_local.spell = not vim.opt_local.spell:get() end)
nmap('<leader>sw', function() vim.opt_local.wrap = not vim.opt_local.wrap:get() end)
nmap('<leader>sn', function()
    vim.opt_local.relativenumber = not vim.opt_local.number:get()
    vim.opt_local.number = not vim.opt_local.number:get()
end)
nmap('<leader>ol', "@='ywo<c-v><esc>p<c-a>'<cr>") -- https://jdhao.github.io/2019/04/29/nvim_map_with_a_count/

-- keep cursor position if you exit visual selection
nmap('v', 'm`v')
nmap('V', 'm`V')
nmap('<c-v>', 'm`<c-v>')
vmap('<esc>', '<esc>:keepjumps normal ``<cr>') -- after umap '<esc>'

-- scrolling
umap('<c-u>', string.rep('<cmd>:norm k<cr><cmd>:sl 1m<cr>', vim.opt.scroll._value))
umap('<c-d>', string.rep('<cmd>:norm j<cr><cmd>:sl 1m<cr>', vim.opt.scroll._value))
nmap('gg', '10gg' .. string.rep('k<cmd>:sl 1m<cr>', 9) .. '0')
umap('<c-up>', '10gg' .. string.rep('k<cmd>:sl 1m<cr>', 9) .. '0')
umap('<c-down>', '<c-end>')

vmap('<c-up>', ":m '<-2<cr>gv") -- after umap <c-up>
vmap('<c-down>', ":m '>+1<cr>gv") -- after umap <c-down>

umap('<c-q>', '<cmd>:q<cr>')
umap('<c-w>', '<cmd>:w<cr>')
umap('<c-j>', '<cmd>:normal v%J<cr>')
