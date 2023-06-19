local nmap = require('core.utils').map('n') -- mappings for normal mode
local vmap = require('core.utils').map('x') -- mappings for visual mode
local umap = require('core.utils').map { '', 'i' } -- mappings for normal, visual & insert mode
local abbr = require('core.utils').map('ca') -- abbleviations

-- telescope
nmap('<leader>ff', '<cmd>Telescope find_files hidden=true<cr>', 'find files')
nmap('<leader>fg', '<cmd>Telescope live_grep disable_coordinates=true<cr>', 'find text')
nmap('<leader>fh', '<cmd>Telescope help_tags<cr>', 'find help')
nmap('<leader>6', '<cmd>cd ~/repos/dotfiles/ | Telescope find_files<cr>')

-- lazy
nmap('<leader>pu', '<cmd>Lazy update<cr>', 'update plugins')
nmap('<leader>pa', '<cmd>Lazy<cr>', 'plugins info')

-- movement
umap('<c-left>', '<cmd>CybuPrev<cr>', 'previous buffer')
umap('<c-right>', '<cmd>CybuNext<cr>', 'next buffer')
nmap('[b', '<cmd>CybuPrev<cr>', 'previous buffer')
nmap(']b', '<cmd>CybuNext<cr>', 'next buffer')
nmap('[t', '<cmd>tabp<cr>', 'previous tab')
nmap(']t', '<cmd>tabn<cr>', 'next tab')

-- git
nmap('H', '<cmd>Gitsigns preview_hunk<cr>', 'preview hunk')
nmap('U', '<cmd>Gitsigns reset_hunk<cr>', 'undo hunk')
nmap('[h', '<cmd>Gitsigns prev_hunk<cr>', 'goto previous hunk')
nmap(']h', '<cmd>Gitsigns next_hunk<cr>', 'goto next hunk')

-- lsp

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    nmap('<leader>ni', '<cmd>NullLsInfo<cr>', { buffer = args.buf, desc = 'null-ls status' })
    nmap('<leader>li', '<cmd>LspInfo<cr>', { buffer = args.buf, desc = 'LSP status' })
    nmap('<leader>lf', vim.lsp.buf.format, { buffer = args.buf, desc = 'format code using LSP' })
    nmap('<leader>lr', vim.lsp.buf.rename, { buffer = args.buf, desc = 'rename symbol under cursor' })
    nmap('<leader>gd', vim.lsp.buf.definition, { buffer = args.buf, desc = 'goto definition' })
    nmap('<leader>ca', vim.lsp.buf.code_action, { buffer = args.buf, desc = 'goto definition' })
  end,
})
-- diagnostics
nmap('[d', vim.diagnostic.goto_prev, 'goto prev diagnostic message')
nmap(']d', vim.diagnostic.goto_next, 'goto next diagnostic message')
nmap('<leader>d', vim.diagnostic.open_float, 'view line diagnostics')
nmap(
  '<leader>D',
  function() vim.diagnostic.open_float { scope = 'buffer' } end,
  'view all diagnostics in a buffer'
)

-- other plugins
nmap('<leader>co', '<cmd>ColorizerToggle<cr>')
nmap('<leader>ib', '<cmd>IndentBlanklineRefresh<cr>')
nmap('<leader>tt', require('lazy.util').float_term)
nmap('<leader>j', '<cmd>TSJToggle<cr>') -- norm v%J

-- deleting & registers
nmap('_', '"_', 'use void register')
nmap('x', '"_x')
nmap('X', '"_x')
nmap('<del>', '"_x')
nmap('<bs>', 'i<bs><esc>l', 'backspace in normal mode')

-- other
nmap('<leader>w', '<cmd>silent w <bar> redraw <cr>', 'write')
umap('<c-w>', '<cmd>silent w <bar> redraw <cr>', 'write')
umap('<c-q>', '<cmd>q<cr>', 'quit')
nmap('Q', '<cmd>bdelete<cr>', 'quit buffer')
nmap('C', '<cmd>norm m`viw~``<cr>', 'toggle word case')
umap('<c-z>', '<cmd>norm 1z=<cr>', 'spell correction')
nmap('cn', '*``cgn', 'search and replace') -- https://kevinli.co/posts/2017-01-19-multiple-cursors-in-500-bytes-of-vimscript/
nmap('dn', '*``diw', 'search and delete')
vmap('.', ':norm .<cr>', 'dot repeat on all selected lines')
umap('<esc>', '<cmd>nohlsearch<cr><esc>')
nmap('d<space>', [[m`<cmd>keeppatterns %s/\s\+$//e<cr>``]], 'delete trailing whitespace')
nmap('gj', [[@='j^"_d0kgJ'<cr>]], 'join without leaving space')
nmap('<leader>ol', [[@='^"1yiwo<c-v><esc>"1pA.<space><c-v><esc>0<c-a>$'<cr>]], 'create an ordered list') -- https://jdhao.github.io/2019/04/29/nvim_map_with_a_count/

-- indent
nmap('=', '==')
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

-- toggles
nmap('<leader>ss', '<cmd>setlocal spell!<cr>', 'toggle spell')
nmap('<leader>sw', '<cmd>setlocal wrap!<cr>', 'toggle wrap')
nmap('<leader>sn', function() vim.o.stc = vim.o.stc ~= ' ' and ' ' or vim.g.stc end, 'toggle statuscolumn')

abbr('qw', 'q!') -- dvorak
abbr('qn', 'q!') -- qwert
