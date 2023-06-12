local M = {
  'L3MON4D3/LuaSnip',
  event = 'InsertEnter',
}

M.config = function()
  local ls = require('luasnip')
  local t, i = ls.text_node, ls.insert_node

  -- stylua: ignore
  ls.add_snippets('fish', {
    ls.snippet('local', { t('set -l '), i(1) }),
    ls.snippet('function', {
      t('function '), i(1, 'name'),
      t { '', '    ' }, i(2),
      t { '', 'end' },
    }),
    ls.snippet('if', {
      t('if '), i(1, 'cond'),
      t { '', '    ' }, i(2, 'cmd'),
      t { '', 'end' },
    }),
    ls.snippet('elseif', {
      t('else if '), i(1, 'cond'),
      t { '', '    ' }, i(2, 'cmd'),
    }),
    ls.snippet('else', {
      t('else'),
      t { '', '    ' }, i(1, 'cmd'),
    }),
    ls.snippet('switch', {
      t('switch '), i(1, 'value'),
      t { '', '    case ' }, i(2, 'glob'),
      t { '', '        ' }, i(3, 'cmd'),
      t { '', '    case "*"' },
      t { '', '        ' }, i(4, 'cmd'),
      t { '', 'end' },
    }),
    ls.snippet('for', {
      t('for '), i(1, 'i'), t(' in '), i(2, 'iterator'),
      t { '', '    ' }, i(3, 'cmd'),
      t { '', 'end' },
    }),
  })
end

return M
