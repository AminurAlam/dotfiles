do local g = vim.g
  g.mapleader = ' '
  g.maplocalleader = ' '
  g.stc = '%=%{ v:virtnum ? " " : v:lnum }%{ v:virtnum ? "…" : ( v:relnum ? "│" : "❯" ) }%s%C'
  g.do_filetype_lua = 1
  g.editorconfig = false
  g.netrw_banner = 0
  g.netrw_hide = 0
  g.netrw_liststyle = 3
  g.ft_man_folding_enable = 1
  g.loaded_python3_provider = 0
end

-- [[ core ]]
require('core.lazy')
require('core.options')
require('core.mappings')
require('core.commands')
require('core.autocommands')

vim.diagnostic.config {
  underline = { severity = vim.diagnostic.severity.ERROR },
  virtual_text = {
    format = function(diagnostic)
      if diagnostic.severity == vim.diagnostic.severity.HINT then return '󰌶 ' end
      return diagnostic.message
    end,
  },
  signs = false,
  float = { border = 'rounded', header = '', prefix = '', suffix = '' },
  update_in_insert = true,
  severity_sort = true,
}

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
hl('CursorLineNr', { fg = '#98c379' })
hl('LineNr', { fg = '#3b4261' })
