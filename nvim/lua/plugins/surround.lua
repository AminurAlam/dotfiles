return {
  'https://github.com/kylechui/nvim-surround',
  keys = { 'cs', 'ds', 'ys' },
  opts = {
    move_cursor = false,
    surrounds = {
      ['('] = { add = { '(', ')' } },
      ['{'] = { add = { '{', '}' } },
      ['<'] = { add = { '<', '>' } },
      ['['] = { add = { '[', ']' } },
    },
  },
}
