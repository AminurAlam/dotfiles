return {
  'Wansmer/treesj',
  cmd = 'TSJToggle',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  opts = {
    use_default_keymaps = false,
    check_syntax_error = true,
    max_join_length = 120,
    -- hold - cursor follows the node/place on which it was called
    -- start - cursor jumps to the first symbol of the node being formatted
    -- end - cursor jumps to the last symbol of the node being formatted
    cursor_behavior = 'hold',
    notify = true,
    -- langs = langs,
    dot_repeat = true,
  },
}
