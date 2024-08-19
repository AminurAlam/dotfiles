---@param mode table
---@return function
local map = function(mode)
  ---@param lhs string
  ---@param rhs string|function
  ---@param desc string?
  return function(lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, {
      noremap = true,
      silent = true,
      desc = desc,
    })
  end
end

local fn = vim.fn
local macro = function(reg, expr) vim.cmd.let(string.format([[@%s = '%s']], reg, expr)) end
local feed = function(key) fn.feedkeys(vim.keycode(key)) end
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
nmap(']b', '<cmd>CybuNext<cr>', 'next buffer')

-- lsp & diagnostics
nmap('<leader>lf', vim.lsp.buf.format, 'format code using LSP')
nmap('<leader>lh', vim.lsp.buf.hover, 'show doc of symbol under cursor')
nmap('<leader>lr', vim.lsp.buf.rename, 'rename symbol under cursor')
nmap('<leader>gd', vim.lsp.buf.definition, 'goto definition')
nmap('<leader>ca', vim.lsp.buf.code_action, 'see code actions')
nmap('<leader>d', vim.diagnostic.open_float, 'view line diagnostics')
-- nmap('[d', function() vim.diagnostic.jump { count = -1 } end, 'goto prev diagnostic message') -- echasnovski/mini.bracketed
-- nmap(']d', function() vim.diagnostic.jump { count = 1 } end, 'goto next diagnostic message') -- echasnovski/mini.bracketed

-- git
nmap('H', require('gitsigns').preview_hunk_inline, 'preview hunk')
nmap('U', require('gitsigns').reset_hunk, 'undo hunk')
nmap('[h', function() require('gitsigns').nav_hunk('prev') end, 'goto previous hunk')
nmap(']h', function() require('gitsigns').nav_hunk('next') end, 'goto next hunk')

-- deleting & registers
nmap('_', '"_', 'use void register')
nmap('s', '"_s')
nmap('x', '"_x')
nmap('X', '"_x')
vmap('p', '"_dP')
nmap('<del>', '"_x')
nmap('y<esc>', function() end)
nmap('cn', '*``"_cgn', 'search and replace') -- https://kevinli.co/posts/2017-01-19-multiple-cursors-in-500-bytes-of-vimscript/
nmap('d<space>', [[m`<cmd>keeppatterns %s/\s\+$//e<cr>``]], 'delete trailing white pace')
nmap('<bs>', 'i<bs><esc>l', 'backspace in normal mode')
nmap('<cr>', '"_ciw', 'delete word at cursor')

-- write & quit
nmap('<leader>w', '<cmd>silent w <bar> redraw <cr>', 'write')
nmap('<leader>W', '<cmd>silent w <bar> redraw <cr>', 'write')
nmap('Q', function() vim.cmd(#fn.getbufinfo({ buflisted = 1 }) == 1 and 'q' or 'bd') end, 'quit buffer')

-- indent
nmap('=', '==')
nmap('>', '>>')
nmap('<', '<<')
vmap('>', '>gv')
vmap('<', '<gv')
nmap('[f', 'zc')
nmap(']f', 'zf%')

-- macros
macro('m', [[mmA;`m]]) -- put ; at end of statements
macro('x', [[$T["_sx]]) -- mark todo as complete
macro('f', [[mmF"if`m]]) -- convert python string to format string

-- scrolling
umap('<c-u>', string.rep('<cmd>norm k<cr><cmd>sl 1m<cr>', vim.o.scroll))
umap('<c-d>', string.rep('<cmd>norm j<cr><cmd>sl 1m<cr>', vim.o.scroll))

-- toggles
nmap('<leader>ss', '<cmd>setlocal spell!<cr>', 'toggle spell')
nmap('<leader>sw', '<cmd>setlocal wrap!<cr>', 'toggle wrap')
nmap('<leader>sn', function()
  if vim.o.number then
    vim.o.number = false
    vim.o.relativenumber = false
    vim.o.signcolumn = 'no'
    vim.o.foldcolumn = '0'
  else
    vim.o.number = true
    vim.o.relativenumber = true
    vim.o.signcolumn = 'auto'
    vim.o.foldcolumn = 'auto'
  end
end, 'toggle statuscolumn')
nmap('<leader>si', function()
  local lcs = (vim.opt_local.lcs:get().leadmultispace ~= ' ') and ' ' or '│   '
  vim.opt_local.lcs = { leadmultispace = lcs }
end, 'toggle indentlines')

-- other
umap('<c-c>', '<cmd>norm m`viw~``<cr>', 'toggle word case')
vmap('.', ':norm .<cr>', 'dot repeat on all selected lines')
nmap(';', '@:', 'dot repeat the last command')
umap('<esc>', '<cmd>nohlsearch<cr><esc>')
nmap('gj', [[@='j^"_d0kgJ'<cr>]], 'join without leaving space')
nmap('go', 'jA', 'like `o` but on existing line')

-- visual
nmap('v', 'm`v')
nmap('V', 'm`V')
nmap('<c-v>', 'm`<c-v>')
vmap('<esc>', '<esc><cmd>keepjumps norm ``<cr>') -- after umap '<esc>'
vmap('v', function()
  local next = { ['v'] = 'V', ['V'] = '\22', ['\22'] = '<esc>' }
  feed(next[vim.api.nvim_get_mode().mode])
end, 'repeat v to change visual mode')

nmap('z=', function()
  vim.ui.select(
    fn.spellsuggest(vim.fn.expand('<cword>')),
    {},
    vim.schedule_wrap(function(word)
      if word then feed('"_ciw' .. word .. '<esc>') end
    end)
  )
end, 'open spellsuggests in select menu')

-- abbreviations
if fn.has('nvim-0.10.0') == 1 then
  abbr('qw', 'q!') -- dvorak
  abbr('vq', 'wq') -- dvorak
  abbr('qn', 'q!') -- qwert
  -- abbr('S', [[s/\v]])
end
