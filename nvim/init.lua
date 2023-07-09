vim.loader.enable()

do
  local g = vim.g

  g.mapleader = ' '
  g.maplocalleader = ' '
  -- g.stc = '%=%{ v:virtnum ? "…" : v:lnum }%-01.01s'
  g.stc = '%=%l%s'

  g.qf_disable_statusline = 1
  g.tex_flavor = 'latex'
  g.do_filetype_lua = 1
  g.ft_man_folding_enable = 1
  -- g.loaded_python3_provider = 0
  -- g.loaded_node_provider = 0
  -- g.loaded_perl_provider = 0
  -- g.loaded_ruby_provider = 0
  -- g.loaded_gzip = 1
  -- g.loaded_remote_plugins = 1
  -- g.loaded_shada_plugin = 1
  -- g.loaded_tarPlugin = 1
  -- g.loaded_2html_plugin = 1
  -- g.loaded_tutor_mode_plugin = 1
  -- g.loaded_zipPlugin = 1
  -- g.editorconfig = false
  -- g.netrw_banner = 0
  -- g.netrw_hide = 0
  -- g.netrw_liststyle = 3
end

-- [[ core ]]
require 'core.lazy'
require 'core.autocommands'
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
