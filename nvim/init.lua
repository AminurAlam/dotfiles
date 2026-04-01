vim.loader.enable()

local g = vim.g

g.mapleader = ' '
g.maplocalleader = ' '
g.have_nerd_font = true
g.save_fmt = true

g.editorconfig = true
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
g.query_lint_on = { 'BufEnter', 'BufWrite' }

-- [[ core ]]
require 'pack'
require 'mappings'
require 'options'
require 'autocommands'
require 'colors'
require 'completion'
require 'diff'
require 'lsp'
require 'pairs'
require 'statusline'
require 'picker'
require 'treesitter'

vim.diagnostic.config {
  underline = { severity = vim.diagnostic.severity.ERROR },
  virtual_text = true,
  signs = {
    text = { '', '', '', '' }, -- { ' ', ' ', ' ', ' ' },
    numhl = {
      'DiagnosticSignError',
      'DiagnosticSignWarn',
      'DiagnosticSignInfo',
      'DiagnosticSignHint',
    },
  },

  status = { format = { ' ', ' ', ' ', ' ' } },
  float = { border = 'rounded', header = '', prefix = '', suffix = '' },
  update_in_insert = true,
  severity_sort = true,
}

require('vim._core.ui2').enable({
      enable = true, -- Whether to enable or disable the UI.
      msg = { -- Options related to the message module.
        ---@type 'cmd'|'msg' Default message target, either in the
        ---cmdline or in a separate ephemeral message window.
        ---@type string|table<string, 'cmd'|'msg'|'pager'> Default message target
        ---or table mapping |ui-messages| kinds and triggers to a target.
        targets = {'cmd', 'msg', 'pager'},
        cmd = { -- Options related to messages in the cmdline window.
          height = 0.5 -- Maximum height while expanded for messages beyond 'cmdheight'.
        },
        dialog = { -- Options related to dialog window.
          height = 0.5, -- Maximum height.
        },
        msg = { -- Options related to msg window.
          height = 0.5, -- Maximum height.
          timeout = 4000, -- Time a message is visible in the message window.
        },
        pager = { -- Options related to message window.
          height = 1, -- Maximum height.
        },
      },
    })
