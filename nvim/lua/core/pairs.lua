require('nvim-surround').setup {
  move_cursor = false,
  surrounds = {
    ['('] = { add = { '(', ')' } },
    ['{'] = { add = { '{', '}' } },
    ['<'] = { add = { '<', '>' } },
    ['['] = { add = { '[', ']' } },
  },
}

require('ultimate-autopair').setup {
  bs = { indent_ignore = true },
  space = { check_box_ft = { 'markdown', 'note' } },
  tabout = { enable = false, hopout = false, map = '<s-tab>' },
  extensions = { cmdtype = { skip = { '@', '-' }, p = 100 } },
  fastwarp = {
    enable = true,
    enable_normal = true,
    enable_reverse = true,
    hopout = false,
    map = '<A-e>',
    rmap = '<A-E>',
    cmap = '<A-e>',
    rcmap = '<A-E>',
    multiline = true,
    nocursormove = true,
    do_nothing_if_fail = true,
    no_filter_nodes = { 'string', 'raw_string', 'string_literals', 'character_literal' },
    faster = false,
    conf = {},
    multi = false,
  },
}
