return {
  { 'kylechui/nvim-surround', keys = { 'cs', 'ds', 'ys' }, config = true },
  { 'numToStr/Comment.nvim', keys = { 'gcc', { 'gc', mode = 'v' } }, config = true },
  { 'windwp/nvim-autopairs', event = { 'InsertEnter' }, config = true },
  {
    'tzachar/highlight-undo.nvim',
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
