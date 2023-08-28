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
nmap('<leader>tt', require('lazy.util').float_term, 'floating terminal')

-- movement
umap('<c-left>', '<cmd>CybuPrev<cr>', 'previous buffer')
umap('<c-right>', '<cmd>CybuNext<cr>', 'next buffer')
nmap('[b', '<cmd>CybuPrev<cr>', 'previous buffer')
nmap(']b', '<cmd>CybuNext<cr>', 'next buffer') -- TODO: repeat with ]]
nmap('[t', '<cmd>tabp<cr>', 'previous tab')
nmap(']t', '<cmd>tabn<cr>', 'next tab')

-- lsp & diagnostics
nmap('<leader>li', '<cmd>LspInfo<cr>', 'LSP status')
nmap('<leader>lf', vim.lsp.buf.format, 'format code using LSP')
nmap('<leader>lr', vim.lsp.buf.rename, 'rename symbol under cursor')
nmap('<leader>gd', vim.lsp.buf.definition, 'goto definition')
nmap('<leader>ca', vim.lsp.buf.code_action, 'goto definition')
nmap('<leader>d', vim.diagnostic.open_float, 'view line diagnostics')
nmap('[d', vim.diagnostic.goto_prev, 'goto prev diagnostic message')
nmap(']d', vim.diagnostic.goto_next, 'goto next diagnostic message')

-- git
nmap('H', require('gitsigns').preview_hunk, 'preview hunk')
nmap('U', require('gitsigns').reset_hunk, 'undo hunk')
nmap('[h', require('gitsigns').prev_hunk, 'goto previous hunk')
nmap(']h', require('gitsigns').next_hunk, 'goto next hunk')

-- deleting & registers
nmap('_', '"_', 'use void register')
nmap('x', '"_x')
nmap('X', '"_x')
vmap('p', '"_dP')
nmap('<del>', '"_x')
nmap('cn', '*``"_cgn', 'search and replace') -- https://kevinli.co/posts/2017-01-19-multiple-cursors-in-500-bytes-of-vimscript/
nmap('d<space>', [[m`<cmd>keeppatterns %s/\s\+$//e<cr>``]], 'delete trailing white pace')
nmap('<bs>', 'i<bs><esc>l', 'backspace in normal mode')
nmap('<cr>', '"_ciw', 'delete word at cursor')

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
-- nmap('q:', '<nop>') -- messes up q in reader mode
umap('<c-c>', '<cmd>norm m`viw~``<cr>', 'toggle word case')
vmap('.', ':norm .<cr>', 'dot repeat on all selected lines')
nmap(';', '@:', 'dot repeat the last command')
umap('<esc>', '<cmd>nohlsearch<cr><esc>')
nmap('gj', [[@='j^"_d0kgJ'<cr>]], 'join without leaving space')
-- vmap('V', 'j', 'repeat V to select more lines')
vmap('v', function()
  local mode = vim.api.nvim_get_mode().mode

  if mode == 'v' then
    vim.api.nvim_feedkeys('V', 't', false)
  elseif mode == 'V' then
    vim.api.nvim_feedkeys('\22', 't', false)
  elseif mode == '\22' then
    vim.api.nvim_feedkeys(vim.keycode('<esc>'), 't', false)
  end
end, 'repeat v to change visual mode')

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
nmap('<leader>sn', function() vim.o.stc = vim.o.stc ~= '' and '' or ' ' end, 'toggle statuscolumn')
nmap('<leader>sr', function() vim.o.cb = vim.o.cb ~= '' and '' or 'unnamedplus' end, 'toggle system clipboard') -- TODO: sync last item
nmap('<leader>si', function()
  local lcs = (vim.opt_local.lcs:get().leadmultispace ~= ' ') and ' ' or '│   '
  vim.opt_local.lcs = { leadmultispace = lcs }
end, 'toggle indentlines')

if vim.fn.has('nvim-0.10.0') == 1 then
  abbr('qw', 'q!') -- dvorak
  abbr('qn', 'q!') -- qwert
  -- abbr('S', [[s/\v]])
end

if vim.fn.has('termux') == 1 then
  umap('<ScrollWheelUp>', '<c-y>')
  umap('<ScrollWheelDown>', '<c-e>')
  vim.keymap.set('i', '<ScrollWheelUp>', '<c-x><c-y>')
  vim.keymap.set('i', '<ScrollWheelDown>', '<c-x><c-e>')
end
