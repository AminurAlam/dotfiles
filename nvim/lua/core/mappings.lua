local map = require('core.utils').map
local nmap = map('n') -- mappings for normal mode
local vmap = map('v') -- mappings for visual mode
local umap = map { '', 'i' } -- mappings for normal, visual & insert mode

-- telescope
nmap('<leader>ff', '<cmd>Telescope find_files hidden=true<cr>', { desc = 'find files' })
nmap('<leader>fr', '<cmd>Telescope oldfiles<cr>', { desc = 'find recent files' })
nmap('<leader>fg', '<cmd>Telescope live_grep disable_coordinates=true<cr>', { desc = 'find text' })
nmap('<leader>fb', '<cmd>Telescope buffers<cr>', { desc = 'find buffers' })
nmap('<leader>fh', '<cmd>Telescope help_tags<cr>', { desc = 'find help' })
nmap('<leader>fs', '<cmd>Telescope spell_suggest<cr>', { desc = 'find spelling' })

-- lazy
nmap('<leader>pu', '<cmd>Lazy update<cr>', { desc = 'update plugins' })
nmap('<leader>pi', '<cmd>Lazy install<cr>', { desc = 'install plugins' })
nmap('<leader>pr', '<cmd>Lazy clean<cr>', { desc = 'remove plugins' })
nmap('<leader>pa', '<cmd>Lazy<cr>', { desc = 'plugins info' })

-- cybu
umap('<c-left>', '<cmd>CybuPrev<cr>', { desc = 'previous buffer' })
umap('<c-right>', '<cmd>CybuNext<cr>', { desc = 'next buffer' })

-- git
nmap('<leader>gd', '<cmd>Gitsigns diffthis<cr>', { desc = 'view diff in split' })
nmap('<leader>gh', '<cmd>Gitsigns preview_hunk<cr>', { desc = 'preview hunk' })
nmap('<leader>gr', '<cmd>Gitsigns reset_hunk<cr>', { desc = 'undo hunk' })
nmap('<leader>gu', '<cmd>Gitsigns reset_hunk<cr>', { desc = 'undo hunk' })
nmap('<leader>gn', '<cmd>Gitsigns next_hunk<cr>', { desc = 'goto next hunk' })
nmap('<leader>gp', '<cmd>Gitsigns prev_hunk<cr>', { desc = 'goto previous hunk' })

-- lsp
nmap('<leader>li', '<cmd>LspInfo<cr>', { desc = 'LSP status' })
nmap('<leader>lf', function() vim.lsp.buf.format() end, { desc = 'format code using LSP' })
nmap('<leader>lr', function() vim.lsp.buf.rename() end, { desc = 'rename symbol under cursor' })
nmap('<leader>ld', function() vim.diagnostic.open_float() end, { desc = 'view line diagnostics' })
nmap('<leader>lb', function() vim.diagnostic.open_float({ scope = 'buffer' }) end, { desc = 'view all diagnostics' })

-- other plugins
nmap('<leader>co', '<cmd>ColorizerToggle<cr>')
nmap('<leader>ib', '<cmd>IndentBlanklineRefresh<cr>')
nmap('<leader>tt', function() require('lazy.util').float_term() end)
nmap('<leader>cs', '<cmd>CmpStatus<cr>')
nmap('<leader>j', '<cmd>TSJToggle<cr>')

-- deleting & registers
nmap('_', '"_', { desc = 'use void register' })
nmap('x', '"_x')
nmap('X', '"_x')
nmap('<del>', '"_x')
nmap('<bs>', 'i<bs><esc>l', { desc = 'backspace in normal mode' })
nmap('<cr>', 'o<esc>', { desc = 'enter in normal mode' })

-- other
umap('<c-c>', '<cmd>norm m`viw~``<cr>', { desc = 'toggle word case' })
umap('<c-z>', '<cmd>norm 1z=<cr>', { desc = 'spell correction' })
nmap('Q', '<cmd>bdelete<cr>')
nmap('<leader>q', '<cmd>bdelete<cr>')
nmap('r', '<cmd>silent redo <bar> redraw <cr>', { desc = 'shortcut for redo' })
nmap('cn', '*``cgn', { desc = 'search and replace' }) -- https://kevinli.co/posts/2017-01-19-multiple-cursors-in-500-bytes-of-vimscript/
nmap('dn', '*``diw', { desc = 'search and delete' })
nmap('dw', 'diw', { desc = 'delete word' })
umap('<esc>', '<cmd>nohlsearch<cr><esc>')
nmap('<leader>d ', [[m`<cmd>keeppatterns %s/\s\+$//e<cr>``]], { desc = 'delete trailing whitespace' })
nmap('<leader>d#', [[m`<cmd>keeppatterns s/\s*#.*$//e<cr>``]], { desc = 'delete # comment' })
nmap('<leader>d-', [[m`<cmd>keeppatterns s/\s*--.*$//e<cr>``]], { desc = 'delete -- comment' })
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
nmap('<leader>ss', '<cmd>setlocal spell!<cr>', { desc = 'toggle spell' })
nmap('<leader>sw', '<cmd>setlocal wrap!<cr>', { desc = 'toggle wrap' })
nmap('<leader>sn', function() vim.opt_local.stc = vim.o.stc ~= ' ' and ' ' or vim.g.stc end, {
    desc = 'toggle statuscolumn',
})

umap('<c-q>', '<cmd>q<cr>')
umap('<c-w>', '<cmd>silent w <bar> redraw <cr>')
umap('<c-m>', '')
umap('<c-j>', '<cmd>norm v%J<cr>')
