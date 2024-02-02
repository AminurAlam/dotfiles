return {
  'kylechui/nvim-surround',
  keys = { 'cs', 'ds', 'ys' },
  config = {
    move_cursor = false,
    surrounds = {
      ['('] = { add = { '(', ')' } },
      ['{'] = { add = { '{', '}' } },
      ['<'] = { add = { '<', '>' } },
      ['['] = { add = { '[', ']' } },
    },
  },
}
