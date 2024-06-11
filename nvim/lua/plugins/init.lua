return {
  { 'numToStr/Comment.nvim', keys = { 'gc', { 'gc', mode = 'v' }, { 'gb', mode = 'v' } }, config = true },
  { 'windwp/nvim-autopairs', enabled = false, event = { 'InsertEnter' }, config = true },
  {
    'tzachar/highlight-undo.nvim',
    keys = { 'u', 'r' },
    opts = { undo = { hlgroup = 'IncSearch' }, redo = { hlgroup = 'IncSearch', lhs = 'r' } },
  },
  {
    'Wansmer/treesj',
    enabled = false,
    keys = { { '<leader>j', '<cmd>TSJToggle<cr>' } },
    opts = { use_default_keymaps = false, check_syntax_error = false, notify = false },
  },
  {
    'altermo/ultimate-autopair.nvim',
    event = { 'InsertEnter', 'CmdlineEnter' },
    branch = 'v0.6',
    opts = {
      bs = { indent_ignore = true },
      extensions = { cmdtype = { skip = { '@', '-' }, p = 100 } },
    },
  },
}
