local nmap = function(k, v) vim.keymap.set('n', k, v, { noremap = true, silent = true }) end
local vmap = function(k, v) vim.keymap.set('v', k, v, { noremap = true, silent = true }) end
local umap = function(k, v) vim.keymap.set({ '', 'i' }, k, v, { noremap = true, silent = true }) end

-- telescope
nmap('<leader>ff', '<cmd>Telescope find_files<cr>')
nmap('<leader>fr', '<cmd>Telescope oldfiles<cr>')
nmap('<leader>fg', '<cmd>Telescope live_grep<cr>')
nmap('<leader>fb', '<cmd>Telescope buffers<cr>')
nmap('<leader>fh', '<cmd>Telescope help_tags<cr>')
nmap('<leader>fs', '<cmd>Telescope spell_suggest<cr>')

-- packer
nmap('<leader>pu', '<cmd>Lazy update<cr>')
nmap('<leader>pi', '<cmd>Lazy install<cr>')
nmap('<leader>pr', '<cmd>Lazy clean<cr>')
nmap('<leader>pa', '<cmd>Lazy<cr>')

-- cybu
umap('<c-left>', '<cmd>CybuPrev<cr>')
umap('<c-right>', '<cmd>CybuNext<cr>')

-- other plugins
nmap('<leader>tr', '<cmd>TroubleToggle<cr>')
nmap('<leader>co', '<cmd>ColorizerToggle<cr>')
nmap('<leader>ib', '<cmd>IndentBlanklineRefresh<cr>')
nmap('<leader>tt', '<cmd>topleft 8sp | term <cr>i')
nmap('<leader>li', '<cmd>LspInfo<cr>')
nmap('<leader>lf', function() vim.lsp.buf.format() end)

-- deleting & registers
nmap('_', '"_')
nmap('x', '"_x')
nmap('X', '"_x')
nmap('<del>', '"_x')
nmap('<bs>', 'i<bs><esc>l') -- backspace in normal mode

-- other
umap('<c-c>', '<cmd>norm m`viw~``<cr>') -- switch word case
umap('<c-z>', '<cmd>norm 1z=<cr>') -- spell correction
nmap('Q', '<cmd>bdelete<cr>')
nmap('r', '<cmd>silent redo <bar> redraw <cr>') -- shortcut for redo
nmap('<cr>', 'o<esc>')
nmap('cn', '*``cgn') -- search and replace https://kevinli.co/posts/2017-01-19-multiple-cursors-in-500-bytes-of-vimscript/
nmap('dn', '*``diw') -- search and delete
nmap('dw', 'diw') -- delete word
umap('<esc>', '<cmd>nohlsearch<cr><esc>')
nmap('<leader>d ', [[m`<cmd>keeppatterns %s/\s\+$//e<cr>``]]) -- delete trailing whitespace
nmap('<leader>d#', [[m`<cmd>keeppatterns s/\s*#.*$//e<cr>``]]) -- delete # comment
nmap('<leader>d-', [[m`<cmd>keeppatterns s/\s*--.*$//e<cr>``]]) -- delete -- comment
nmap('<leader>ol', [[@='^"1yiwo<c-v><esc>"1p<c-a>0'<cr>]]) -- https://jdhao.github.io/2019/04/29/nvim_map_with_a_count/

-- indent
nmap('>', '>>')
nmap('<', '<<')
vmap('>', '>gv')
vmap('<', '<gv')

-- keep cursor position if you exit visual selection
nmap('v', 'm`v')
nmap('V', 'm`V')
nmap('<c-v>', 'm`<c-v>')
vmap('<esc>', '<esc>:keepjumps norm ``<cr>') -- after umap '<esc>'

-- scrolling
umap('<c-u>', string.rep('<cmd>norm k<cr><cmd>sl 1m<cr>', vim.o.scroll))
umap('<c-d>', string.rep('<cmd>norm j<cr><cmd>sl 1m<cr>', vim.o.scroll))
umap('<c-up>', '<c-home>')
umap('<c-down>', '<c-end>')

-- toggles
nmap('<leader>ss', '<cmd>setlocal spell!<cr>')
nmap('<leader>sw', '<cmd>setlocal wrap!<cr>')
nmap('<leader>sn', function() vim.opt_local.stc = vim.o.stc ~= ' ' and ' ' or vim.g.stc end)

umap('<c-q>', '<cmd>q<cr>')
umap('<c-w>', '<cmd>silent w <bar> redraw <cr>')
umap('<c-m>', '')
umap('<c-j>', '<cmd>norm v%J<cr>')
