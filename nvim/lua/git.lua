-- No need to copy this inside `setup()`. Will be used automatically.
require('mini.diff').setup({
  view = {
    style = 'sign',
    signs = { add = '┃', change = '┃', delete = '_' },
  },
  delay = { text_change = 200 },
  mappings = {
    apply = '',
    reset = 'U',
    textobject = 'H',
    goto_first = '',
    goto_last = '',
    goto_prev = '[h',
    goto_next = ']h',
  },
})

vim.keymap.set('n', 'H', require('mini.diff').toggle_overlay, { desc = 'preview hunk' })
