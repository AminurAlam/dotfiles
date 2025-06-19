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
local nmap = map { 'n' }
local vmap = map { 'x' }
local umap = map { '', 'i' }
local lazy = require 'lazy'

-- lazy
nmap('<leader>pu', lazy.update, 'update plugins')
nmap('<leader>pp', lazy.profile, 'open profiler')
nmap('<leader>pa', lazy.home, 'plugins info')
nmap('<leader>tt', require('lazy.util').float_term, 'floating terminal')

-- movement
umap('<c-left>', '<cmd>CybuPrev<cr>', 'previous buffer')
umap('<c-right>', '<cmd>CybuNext<cr>', 'next buffer')
umap('<c-up>', '<cmd>CybuPrev<cr>', 'previous buffer')
umap('<c-down>', '<cmd>CybuNext<cr>', 'next buffer')
umap('<c-h>', '<cmd>CybuPrev<cr>', 'previous buffer')
umap('<c-l>', '<cmd>CybuNext<cr>', 'next buffer')
umap('<c-k>', '<cmd>CybuPrev<cr>', 'previous buffer')
umap('<c-j>', '<cmd>CybuNext<cr>', 'next buffer')

-- diagnostics
nmap('<leader>d', vim.diagnostic.open_float, 'view line diagnostics')
-- stylua: ignore
vim.keymap.set('n', '<leader>li', function()
  print(table.concat(vim.tbl_map(function(client)
    return string.format('\n%s (%s): %s',
      client.name,
      client.name == 'null-ls' and '*' or table.concat(client.config.filetypes, ', '),
      client.workspace_folders and vim.fn.fnamemodify(client.workspace_folders[1].name, ':~') or 'single file mode'
    )
  end, vim.lsp.get_clients()), ''))
end, { desc = 'LspInfo' })

-- git
nmap('H', require('gitsigns').preview_hunk_inline, 'preview hunk')
nmap('U', require('gitsigns').reset_hunk, 'undo hunk')
nmap('[h', function() require('gitsigns').nav_hunk('prev') end, 'goto previous hunk')
nmap(']h', function() require('gitsigns').nav_hunk('next') end, 'goto next hunk')

-- deleting & registers
nmap('_', '"_', 'use void register')
nmap('s', '"_s')
nmap('x', '"_x')
vmap('p', '"_dP')
nmap('<del>', '"_x')
nmap('y<esc>', function() end)
nmap('cn', '*``"_cgn', 'search and replace') -- https://kevinli.co/posts/2017-01-19-multiple-cursors-in-500-bytes-of-vimscript/
nmap('<bs>', 'X', 'backspace in normal mode')
nmap('<cr>', '"_ciw', 'delete word at cursor')
nmap('r', '<cmd>redo<cr>')

-- write & quit
nmap('<leader>w', '<cmd>silent w <bar> redraw <cr>', 'write')
nmap('<leader>W', '<cmd>silent w <bar> redraw <cr>', 'write')
nmap('q', "<cmd>if len(getbufinfo({'buflisted': 1})) == 1|q|else|bd|endif<cr>", 'quit buffer')
nmap('Q', 'q', 'record macro')

-- indent & fold
nmap('=', '==')
nmap('>', '>>')
nmap('<', '<<')
vmap('>', '>gv')
vmap('<', '<gv')
nmap(']f', 'zf%')

-- toggles
nmap('<leader>ss', '<cmd>setlocal spell!<cr>', 'toggle spell')
nmap('<leader>sw', '<cmd>setlocal wrap!<cr>', 'toggle wrap')
nmap('<leader>st', '<cmd>set ts=4 sw=4 sts=4 si sta et sr<cr>', 'use spaces over tab')
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

-- other
umap('<c-c>', 'g~iw', 'toggle word case')
vmap('.', ':norm .<cr>', 'dot repeat on all selected lines')
nmap(';', '@:', 'dot repeat the last command')
umap('<esc>', '<cmd>nohlsearch<cr><esc>')
nmap('gj', [[@='j^"_d0kgJ'<cr>]], 'join without leaving space')
nmap('go', 'jA', 'like `o` but on existing line')
nmap('<leader>y', '<cmd>silent %y<cr>', 'yank entire buffer')
nmap('<leader>y', function() fn.setreg('+', fn.getreg '0') end, 'put last yank in sys clipboard')
nmap('<leader>p', '"+p', 'put last yank in sys clipboard')
nmap('<leader>a', 'moggVG<c-a>`o', 'increment all numbers')

-- visual
nmap('v', 'm`v') -- TODO: handle with autocmd
nmap('V', 'm`V')
nmap('<c-v>', 'm`<c-v>')
vmap('<esc>', '<esc><cmd>keepjumps norm ``<cr>') -- after umap '<esc>'
vmap('v', function()
  local next = { v = 'V', V = '\22', ['\22'] = '<esc>' }
  fn.feedkeys(vim.keycode(next[vim.api.nvim_get_mode().mode]))
end, 'repeat v to change visual mode')

-- overrides
nmap('z=', function()
  vim.ui.select(
    fn.spellsuggest(fn.expand('<cword>')),
    {},
    vim.schedule_wrap(function(word)
      if word then fn.feedkeys(vim.keycode('"_ciw' .. word .. '<esc>')) end
    end)
  )
end, 'open spellsuggests in select menu')

-- abbreviations
if fn.has('nvim-0.10.0') == 1 then
  map { 'ca' }('vq', 'wq') -- dvorak
  map { 'ca' }('qn', 'q!') -- qwert
end

-- macros
macro('m', [[mmA;`m]]) -- put ; at end of statements
macro('x', [[$T["_sx]]) -- mark todo as complete
macro('f', [[mmF"if`m]]) -- convert python string to format string
