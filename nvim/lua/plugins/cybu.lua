return {
  'ghillb/cybu.nvim',
  cmd = { 'CybuNext', 'CybuPrev' },
  dependencies = { 'nvim-tree/nvim-web-devicons', 'nvim-lua/plenary.nvim' },
  opts = {
    position = {
      relative_to = 'win', -- win, editor, cursor
      anchor = 'bottomright',
      vertical_offset = 0,
      horizontal_offset = 0,
      max_win_height = 12,
      max_win_width = 0.70,
    },
    style = {
      path = 'relative',
      path_abbreviation = 'shortened',
      border = 'rounded',
      separator = ' ',
      prefix = '…',
      padding = 1,
      hide_buffer_id = false,
      devicons = { enabled = true, colored = true, truncate = false },
    },
    behavior = { -- set behavior for different modes
      mode = {
        default = { switch = 'immediate', view = 'paging' },
        last_used = { switch = 'immediate', view = 'paging' },
        auto = { view = 'paging' },
      },
    },
    show_on_autocmd = 'BufEnter',
    display_time = 1500, -- time the cybu window is displayed
    exclude = {},
    fallback = function(direction) vim.cmd.b(direction) end,
  },
}
