vim.loader.enable()

local g = vim.g

g.mapleader = ' '
g.maplocalleader = ' '

g.editorconfig = false
g.loaded_gzip = 1
g.loaded_matchit = 1
g.loaded_matchparen = 1
g.loaded_netrwPlugin = 1
g.loaded_remote_plugins = 1
g.loaded_shada_plugin = 1
g.loaded_spellfile_plugin = 1
g.loaded_tarPlugin = 1
g.loaded_2html_plugin = 1
g.loaded_tutor_mode_plugin = 1
g.loaded_zipPlugin = 1

g.qf_disable_statusline = 1
g.tex_flavor = 'latex'
g.do_filetype_lua = 1
g.ft_man_folding_enable = 1

-- [[ core ]]
require 'core.lazy'
require 'core.autocommands'
-- require 'core.lsp'
require 'core.options'
require 'core.mappings'
require 'core.statusline'

vim.diagnostic.config {
  underline = { severity = vim.diagnostic.severity.ERROR },
  virtual_text = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '',
      [vim.diagnostic.severity.WARN] = '',
      [vim.diagnostic.severity.INFO] = '',
      [vim.diagnostic.severity.HINT] = '',
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
      [vim.diagnostic.severity.WARN] = 'DiagnosticSignWarn',
      [vim.diagnostic.severity.INFO] = 'DiagnosticSignInfo',
      [vim.diagnostic.severity.HINT] = 'DiagnosticSignHint',
    },
  },
  float = { border = 'rounded', header = '', prefix = '', suffix = '' },
  update_in_insert = true,
  severity_sort = true,
}

-- COLORSCHEME AND HIGHLIGHTS
vim.cmd.colorscheme 'tokyonight'

local hl = function(name, val) vim.api.nvim_set_hl(0, name, val) end

-- hl('Whitespace', { bg = '#364a82' })
hl('DiagnosticFloatingError', { bg = nil })
hl('DiagnosticFloatingWarn', { bg = nil })
hl('DiagnosticFloatingInfo', { bg = nil })
hl('DiagnosticFloatingHint', { bg = nil })
hl('CursorLineNr', {})
hl('LineNr', { fg = '#3b4261' })
hl('Folded', { bg = '#3b4261' })
hl('HighlightUndo', { link = 'IncSearch' })
hl('HighlightRedo', { link = 'IncSearch' })
hl('MsgSeparator', { link = 'TermCursorNC' })
hl('WinSeparator', { link = 'TermCursorNC' })
hl('@function.call.fish', { link = 'Special' })
hl('@variable.fish', { link = 'Constant' })
hl('@function.diff', { link = 'TabLineSel' })
hl('@attribute.diff', { fg = '#7dcfff', bg = '#3b4261' })
hl('@constant.fish', { link = '@punctuation.special' })
hl('@punctuation.bracket.fish', { link = '@punctuation.special' })
