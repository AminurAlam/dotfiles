vim.loader.enable()

local g = vim.g

g.mapleader = ' '
g.maplocalleader = ' '
g.stc = '%=%{ v:virtnum ? "…" : v:lnum }%s'

g.loaded_python3_provider = 0
g.loaded_node_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0

g.tex_flavor = 'latex'
g.editorconfig = false
g.do_filetype_lua = 1
g.netrw_banner = 0
g.netrw_hide = 0
g.netrw_liststyle = 3
g.ft_man_folding_enable = 1

-- [[ core ]]
require('core.lazy')
require('core.autocommands')
require('core.options')
require('core.mappings')

local severity_icons = { ' ', ' ', ' ', ' ', '󰌵' }

vim.diagnostic.config {
  underline = { severity = vim.diagnostic.severity.ERROR },
  virtual_text = {
    -- TODO: fix this
    -- prefix = function(details) return severity_icons[details.severity] end,
    -- format = function(diagnostic) return diagnostic.message end,
  },
  signs = true,
  float = { border = 'rounded', header = '', prefix = '', suffix = '' },
  update_in_insert = true,
  severity_sort = false,
}

vim.filetype.add {
  extention = {
    -- ['conf'] = 'confini',
  },
  pattern = {
    ['.*%.log'] = 'log',
    ['.*%.cue'] = 'cuesheet',
    ['.*%.note'] = 'note',
    ['.*%.conf'] = 'toml',
  },
}

-- COLORSCHEME AND HIGHLIGHTS
vim.cmd.colorscheme { 'tokyonight' }

local hl = function(name, val) vim.api.nvim_set_hl(0, name, val) end

vim.fn.map({
  'DiagnosticSignError',
  'DiagnosticSignWarn',
  'DiagnosticSignInfo',
  'DiagnosticSignHint',
}, function() vim.fn.sign_define(vim.v.val, { numhl = vim.v.val }) end)

hl('Whitespace', { bg = '#364a82' })
hl('CursorLineNr', { fg = '#c0caf5' })
hl('LineNr', { fg = '#3b4261' })
hl('Folded', { bg = '#3b4261', fg = 'NONE' })
hl('MsgSeparator', { bg = 'NONE', fg = 'NONE' })
hl('@function.call.fish', { link = 'Special' })
hl('@variable.fish', { link = 'Constant' })
