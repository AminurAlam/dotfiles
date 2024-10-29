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
    text = { '', '', '', '' },
    numhl = {
      'DiagnosticSignError',
      'DiagnosticSignWarn',
      'DiagnosticSignInfo',
      'DiagnosticSignHint',
    },
  },
  float = { border = 'rounded', header = '', prefix = '', suffix = '' },
  update_in_insert = true,
  severity_sort = true,
}

vim.cmd.colorscheme 'tokyonight'
