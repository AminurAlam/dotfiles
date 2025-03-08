return {
  { '0xAdk/full_visual_line.nvim', event = 'ModeChanged *:V', config = true },
  {
    'hat0uma/csvview.nvim',
    ft = { 'csv', 'tsv' },
    config = function()
      require('csvview').setup { view = { display_mode = 'border' } }
      require('csvview').enable()
    end,
  },
  {
    'tzachar/highlight-undo.nvim',
    enabled = false,
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
