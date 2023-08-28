return {
  { 'kylechui/nvim-surround', keys = { 'cs', 'ds', 'ys' }, config = true },
  { 'numToStr/Comment.nvim', keys = { 'gcc', { 'gc', mode = 'v' } }, config = true },
  { 'windwp/nvim-autopairs', event = { 'InsertEnter' }, config = true },
  {
    'tzachar/highlight-undo.nvim',
    keys = { 'u', 'r' },
    opts = {
      duration = 300,
      undo = {
        hlgroup = 'IncSearch',
        mode = 'n',
        lhs = 'u',
        map = 'undo',
        opts = {},
      },
      redo = {
        hlgroup = 'IncSearch',
        mode = 'n',
        lhs = 'r',
        map = 'redo',
        opts = {},
      },
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
