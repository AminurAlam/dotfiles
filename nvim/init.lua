vim.loader.enable()

do
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
end

-- [[ core ]]
require 'core.lazy'
require 'core.autocommands'
require 'core.lsp'
require 'core.options'
require 'core.mappings'
require 'core.statusline'

vim.diagnostic.config {
  underline = { severity = vim.diagnostic.severity.ERROR },
  signs = true,
  float = { border = 'rounded', header = '', prefix = '', suffix = '' },
  update_in_insert = true,
  severity_sort = false,
}

-- COLORSCHEME AND HIGHLIGHTS
vim.cmd.colorscheme 'tokyonight'

local hl = function(name, val) vim.api.nvim_set_hl(0, name, val) end

vim.fn.sign_define('DiagnosticSignError', { numhl = 'DiagnosticSignError' })
vim.fn.sign_define('DiagnosticSignWarn', { numhl = 'DiagnosticSignWarn' })
vim.fn.sign_define('DiagnosticSignInfo', { numhl = 'DiagnosticSignInfo' })
vim.fn.sign_define('DiagnosticSignHint', { numhl = 'DiagnosticSignHint' })

-- hl('Whitespace', { bg = '#364a82' })
hl('CursorLineNr', {})
hl('LineNr', { fg = '#3b4261' })
hl('Folded', { bg = '#3b4261' })
hl('MsgSeparator', { link = 'WinSeparator' })
hl('@function.call.fish', { link = 'Special' })
hl('@variable.fish', { link = 'Constant' })
hl('@function.diff', { link = 'TabLineSel' })
hl('@attribute.diff', { fg = '#7dcfff', bg = '#3b4261' })
