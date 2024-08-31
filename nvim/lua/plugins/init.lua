return {
  {
    'windwp/nvim-autopairs',
    enabled = false,
    event = { 'InsertEnter' },
    config = true,
  },
  {
    'tzachar/highlight-undo.nvim',
    keys = { 'u', 'r' },
    opts = {
      undo = { hlgroup = 'IncSearch' },
      redo = { hlgroup = 'IncSearch', lhs = 'r' },
    },
  },
  {
    'Wansmer/treesj',
    enabled = true,
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
