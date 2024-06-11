return {
  { 'echasnovski/mini.files', enabled = false, version = false },
  {
    'echasnovski/mini.splitjoin',
    version = false,
    keys = { '<leader>j' },
    opts = { mappings = { toggle = '<leader>j' } },
  },
  {
    'echasnovski/mini.bracketed',
    keys = { '[', ']' },
    version = false,
    opts = {
      buffer = { suffix = 'b', options = {} },
      comment = { suffix = 'c', options = {} },
      conflict = { suffix = '', options = {} },
      diagnostic = { suffix = '', options = {} },
      file = { suffix = '', options = {} },
      indent = { suffix = 'i', options = {} },
      jump = { suffix = 'j', options = {} },
      location = { suffix = '', options = {} },
      oldfile = { suffix = 'o', options = {} },
      quickfix = { suffix = 'q', options = {} },
      treesitter = { suffix = 't', options = {} },
      undo = { suffix = 'u', options = {} },
      window = { suffix = 'w', options = {} },
      yank = { suffix = 'y', options = {} },
    },
  },
  {
    'echasnovski/mini.starter',
    version = false,
    enabled = false,
    -- No need to copy this inside `setup()`. Will be used automatically.
    opts = {
      autoopen = true,
      evaluate_single = true,
      -- Items to be displayed. Should be an array with the following elements:
      -- - Item: table with <action>, <name>, and <section> keys.
      -- - Function: should return one of these three categories.
      -- - Array: elements of these three types (i.e. item, array, function).
      -- If `nil` (default), default items will be used (see |mini.starter|).
      -- items = require('mini.starter').sections.recent_files(5, false, true),
      -- Header to be displayed before items. Converted to single string via
      -- `tostring` (use `\n` to display several lines). If function, it is
      -- evaluated first. If `nil` (default), polite greeting will be used.
      header = [[                               __
  ___      __    ___   __  __ /\_\    ___ ___
/' _ `\  /'__`\ / __`\/\ \/\ \\/\ \ /' __` __`\
/\ \/\ \/\  __//\ \L\ \ \ \_/ |\ \ \/\ \/\ \/\ \
\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\
 \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/

]], -- string.format('%33s v%d.%d.%d-%s', ' ', v.major, v.minor, v.patch, (v.prerelease and 'dev' or 'stable')),
      footer = '',
      -- Array  of functions to be applied consecutively to initial content.
      -- Each function should take and return content for 'Starter' buffer (see
      -- |mini.starter| and |MiniStarter.content| for more details).
      content_hooks = nil,
      query_updaters = 'abcdefghijklmnopqrstuvwxyz0123456789_-.',
      silent = true,
    },
  },
}
