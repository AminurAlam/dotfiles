return {
  { 'kylechui/nvim-surround', keys = { 'cs', 'ds', 'ys' }, config = true },
  { 'numToStr/Comment.nvim', keys = { 'gcc', { 'gc', mode = 'v' } }, config = true },
  { 'windwp/nvim-autopairs', event = { 'InsertEnter' }, config = true },
  {
    'chrishrb/gx.nvim',
    keys = { 'gx' },
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = true,
  },
  {
    'tzachar/highlight-undo.nvim',
    keys = { 'u', 'r' },
    opts = {
      hlgroup = 'IncSearch',
      duration = 300,
      keymaps = {
        { 'n', 'u', 'undo', {} },
        { 'n', 'r', 'redo', {} },
      },
    },
  },
}
