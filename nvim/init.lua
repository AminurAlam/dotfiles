vim.loader.enable()

local g = vim.g
local autocmd = vim.api.nvim_create_autocmd

g.mapleader = ' '
g.maplocalleader = ' '
g.stc = '%=%{ v:virtnum ? "…" : v:lnum }%s%C'
g.tex_flavor = 'latex'
g.editorconfig = false
g.do_filetype_lua = 1
g.netrw_banner = 0
g.netrw_hide = 0
g.netrw_liststyle = 3
g.ft_man_folding_enable = 1
g.loaded_python3_provider = 0

-- [[ core ]]
require('core.lazy')
require('core.options')
require('core.autocommands')

autocmd('CmdLineEnter', {
  callback = function() require('core.commands') end,
})

autocmd('User', {
  pattern = 'VeryLazy',
  callback = function() require('core.mappings') end,
})

vim.diagnostic.config {
  underline = { severity = vim.diagnostic.severity.ERROR },
  virtual_text = {
    format = function(diagnostic)
      if diagnostic.severity == vim.diagnostic.severity.HINT then return '󰌶 ' end
      return diagnostic.message
    end,
  },
  signs = true,
  float = { border = 'rounded', header = '', prefix = '', suffix = '' },
  update_in_insert = true,
  severity_sort = true,
}

for _, name in pairs {
  'DiagnosticSignError',
  'DiagnosticSignWarn',
  'DiagnosticSignInfo',
  'DiagnosticSignHint',
} do
  vim.fn.sign_define(name, { numhl = name })
end

vim.filetype.add {
  pattern = {
    ['.*%.log'] = 'log',
    ['.*%.cue'] = 'cuesheet',
    ['.*%.note'] = 'note',
  },
}

vim.cmd.colorscheme { 'tokyonight' }

local hl = function(name, val) vim.api.nvim_set_hl(0, name, val) end

hl('Whitespace', { bg = '#364a82' })
hl('CursorLineNr', { fg = '#c0caf5' })
hl('LineNr', { fg = '#3b4261' })
hl('Folded', { bg= '#3b4261', fg='NONE' })
