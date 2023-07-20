return {
  { 'kylechui/nvim-surround', keys = { 'cs', 'ds', 'ys' }, config = true },
  { 'numToStr/Comment.nvim', keys = { 'gcc', { 'gc', mode = 'v' } }, config = true },
  { 'windwp/nvim-autopairs', event = { 'InsertEnter' }, config = true },
  {
    'tzachar/highlight-undo.nvim',
    keys = { 'u', 'r' },
    opts = {
      hlgroup = 'IncSearch',
      duration = 300,
      keymaps = { { 'n', 'u', 'undo', {} }, { 'n', 'r', 'redo', {} } },
    },
  },
  {
    'Wansmer/treesj',
    keys = { { '<leader>j', '<cmd>TSJToggle<cr>' } },
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    opts = {
      use_default_keymaps = false,
      check_syntax_error = false,
      notify = false,
    },
  },
}
