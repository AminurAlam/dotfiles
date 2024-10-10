return {
  {
    'https://github.com/windwp/nvim-autopairs',
    enabled = false,
    event = { 'InsertEnter', 'CmdlineEnter' },
    opts = {
      disable_filetype = { 'TelescopePrompt' },
      disable_in_macro = false,
      disable_in_visualblock = false, -- disable when insert after visual block mode,
      disable_in_replace_mode = true,
      ignored_next_char = [=[[%w%%%'%[%"%.%`%$]]=],
      enable_moveright = true,
      enable_afterquote = true, -- add bracket pairs after quote,
      enable_check_bracket_line = true, --- check bracket in same line,
      enable_bracket_in_quote = true,
      enable_abbr = false, -- trigger abbreviation,
      break_undo = true, -- switch for basic rule break undo sequence,
      check_ts = true,
      map_cr = true,
      map_bs = true, -- map the <BS> key,
      map_c_h = false, -- Map the <C-h> key to delete a pair,
      map_c_w = false, -- map <c-w> to delete a pair if possible,
    },
  },
  {
    'https://github.com/altermo/ultimate-autopair.nvim',
    enabled = true,
    event = { 'InsertEnter', 'CmdlineEnter' },
    branch = 'v0.6',
    opts = {
      bs = { indent_ignore = true },
      space = { check_box_ft = { 'markdown', 'note' } },
      tabout = { enable = true, hopout = true, map = '<tab>' },
      extensions = { cmdtype = { skip = { '@', '-' }, p = 100 } },
    },
  },
  {
    'https://github.com/kylechui/nvim-surround',
    keys = { 'cs', 'ds', 'ys' },
    opts = {
      move_cursor = false,
      surrounds = {
        ['('] = { add = { '(', ')' } },
        ['{'] = { add = { '{', '}' } },
        ['<'] = { add = { '<', '>' } },
        ['['] = { add = { '[', ']' } },
      },
    },
  },
  {
    'https://github.com/NStefan002/visual-surround.nvim',
    enabled = false,
    opts = {
      use_default_keymaps = true,
      surround_chars = { '[', ']', '(', ')', "'", '"', '`' },
      exit_visual_mode = true,
    },
  },
}
