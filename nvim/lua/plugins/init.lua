return {
  {
    'tzachar/highlight-undo.nvim',
    keys = { 'u', 'r' },
    opts = {
      hlgroup = 'IncSearch',
      keymaps = { paste = { disabled = true }, redo = { lhs = 'r' } },
    },
  },
  {
    'Wansmer/treesj',
    keys = { { '<leader>j', '<cmd>TSJToggle<cr>' } },
    opts = {
      max_join_length = 240,
      use_default_keymaps = false,
      check_syntax_error = false,
      notify = false,
    },
  },
  {
    'numToStr/Comment.nvim',
    enabled = false,
    keys = { 'gc', { 'gc', mode = 'v' }, { 'gb', mode = 'v' } },
    config = true,
  },
}
