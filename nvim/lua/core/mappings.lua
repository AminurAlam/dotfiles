local nmap = require('core.utils').map('n') -- mappings for normal mode
local vmap = require('core.utils').map('v') -- mappings for visual mode
local umap = require('core.utils').map { '', 'i' } -- mappings for normal, visual & insert mode

-- telescope
nmap('<leader>ff', '<cmd>Telescope find_files hidden=true<cr>', 'find files')
nmap('<leader>fg', '<cmd>Telescope live_grep disable_coordinates=true<cr>', 'find text')
nmap('<leader>fh', '<cmd>Telescope help_tags<cr>', 'find help')
nmap('<leader>fs', '<cmd>Telescope spell_suggest<cr>', 'find spelling')

-- lazy
nmap('<leader>pu', '<cmd>Lazy update<cr>', 'update plugins')
nmap('<leader>pi', '<cmd>Lazy install<cr>', 'install plugins')
nmap('<leader>pr', '<cmd>Lazy clean<cr>', 'remove plugins')
nmap('<leader>pa', '<cmd>Lazy<cr>', 'plugins info')

-- cybu
umap('<c-left>', '<cmd>CybuPrev<cr>', 'previous buffer')
umap('<c-right>', '<cmd>CybuNext<cr>', 'next buffer')

-- git
nmap('<leader>gd', '<cmd>Gitsigns diffthis<cr>', 'view diff in split')
nmap('<leader>gh', '<cmd>Gitsigns preview_hunk<cr>', 'preview hunk')
nmap('<leader>gr', '<cmd>Gitsigns reset_hunk<cr>', 'undo hunk')
nmap('<leader>gn', '<cmd>Gitsigns next_hunk<cr>', 'goto next hunk')
nmap('<leader>gp', '<cmd>Gitsigns prev_hunk<cr>', 'goto previous hunk')

-- lsp
nmap('<leader>ni', '<cmd>NullLsInfo<cr>', 'null-ls status')
nmap('<leader>li', '<cmd>LspInfo<cr>', 'LSP status')
nmap('<leader>lf', function() vim.lsp.buf.format() end, 'format code using LSP')
nmap('<leader>lr', function() vim.lsp.buf.rename() end, 'rename symbol under cursor')

-- diagnostics
nmap('<leader>dp', function() vim.diagnostic.goto_prev() end, 'goto prev diagnostic message')
nmap('<leader>dn', function() vim.diagnostic.goto_next() end, 'goto next diagnostic message')
nmap('<leader>ld', function() vim.diagnostic.open_float() end, 'view line diagnostics')
nmap('<leader>da', function()
  vim.diagnostic.opn_float {
    prefix = function(details) return vim.g.severity_icons[details.severity] end,
    scope = 'buffer',
  }
end, 'view all diagnostics in a buffer')

-- other plugins
nmap('<leader>al', '<cmd>Alpha<cr>')
nmap('<leader>co', '<cmd>ColorizerToggle<cr>')
nmap('<leader>ib', '<cmd>IndentBlanklineRefresh<cr>')
nmap('<leader>tt', function() require('lazy.util').float_term() end)
nmap('<leader>j', '<cmd>TSJToggle<cr>') -- norm v%J

-- deleting & registers
nmap('_', '"_', 'use void register')
nmap('x', '"_x')
nmap('X', '"_x')
nmap('<del>', '"_x')
nmap('<bs>', 'i<bs><esc>l', 'backspace in normal mode')
nmap('<cr>', 'o<esc>', 'enter in normal mode')

-- other
nmap('<leader>w', '<cmd>silent w <bar> redraw <cr>', 'write')
umap('<c-w>', '<cmd>silent w <bar> redraw <cr>', 'write')
umap('<c-q>', '<cmd>q<cr>', 'quit')
nmap('<leader>q', '<cmd>bdelete<cr>', 'quit buffer')
nmap('Q', '<cmd>bdelete<cr>', 'quit buffer')
umap('<c-c>', '<cmd>norm m`viw~``<cr>', 'toggle word case')
umap('<c-z>', '<cmd>norm 1z=<cr>', 'spell correction')
nmap('cn', '*``cgn', 'search and replace') -- https://kevinli.co/posts/2017-01-19-multiple-cursors-in-500-bytes-of-vimscript/
nmap('dn', '*``diw', 'search and delete')
nmap('dw', 'diw', 'delete word')
vmap('.', ':norm .<cr>', 'dot repeat on all selected lines')
umap('<esc>', '<cmd>nohlsearch<cr><esc>')
nmap('<leader>d ', [[m`<cmd>keeppatterns %s/\s\+$//e<cr>``]], 'delete trailing whitespace')
nmap('<leader>d#', [[m`<cmd>keeppatterns s/\s*#.*$//e<cr>``]], 'delete # comment')
nmap('<leader>d-', [[m`<cmd>keeppatterns s/\s*--.*$//e<cr>``]], 'delete -- comment')
nmap('<leader>fd', '<cmd>filetype detect<cr>', 'recheck the filetype')
nmap('gj', [[@='j^"_d0kgJ'<cr>]], 'join without leaving space')
nmap('<leader>ol', [[@='^"1yiwo<c-v><esc>"1pA.<space><c-v><esc>0<c-a>$'<cr>]], 'create an ordered list') -- https://jdhao.github.io/2019/04/29/nvim_map_with_a_count/

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
nmap('<leader>ss', '<cmd>setlocal spell!<cr>', 'toggle spell')
nmap('<leader>sw', '<cmd>setlocal wrap!<cr>', 'toggle wrap')
nmap(
  '<leader>sn',
  function() vim.opt_local.stc = vim.o.stc ~= ' ' and ' ' or vim.g.stc end,
  'toggle statuscolumn'
)
