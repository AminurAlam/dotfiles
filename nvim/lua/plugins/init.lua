return {
  { 'numToStr/Comment.nvim', keys = { 'gc', { 'gc', mode = 'v' }, { 'gb', mode = 'v' } }, config = true },
  { 'windwp/nvim-autopairs', event = { 'InsertEnter' }, config = true },
  { 'weilbith/nvim-code-action-menu', keys = { { '<leader>ca', '<cmd>CodeActionMenu<cr>' } } },
  {
    'tzachar/highlight-undo.nvim',
    keys = { 'u', 'r' },
    opts = { undo = { hlgroup = 'IncSearch' }, redo = { hlgroup = 'IncSearch', lhs = 'r' } },
  },
  {
    'Wansmer/treesj',
    keys = { { '<leader>j', '<cmd>TSJToggle<cr>' } },
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    opts = { use_default_keymaps = false, check_syntax_error = false, notify = false },
  },
}
