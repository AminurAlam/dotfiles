local custom_onedark = require('lualine.themes.onedark')
custom_onedark.normal.c.bg = nil
-- custom_onedark.normal.x.bg = nil

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = custom_onedark,
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {'alpha'},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = true,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {{'mode', padding = 1,}},
    lualine_b = {
        {'filename', filestatus = false, symbols = {
            modified = ' ●',
            readonly = ' ',
            unnamed = '',
            newfile = '[new]',
            alternate_file = '#'}
        }
    },
    lualine_c = {{'branch'}},
    lualine_x = {{'diagnostics', update_in_insert = true}},
    lualine_y = {{'progress'}},
    lualine_z = {{'filetype', padding = 1}},
  },
  inactive_sections = {
    lualine_a = {{}},
    lualine_b = {{}},
    lualine_c = {{}},
    lualine_x = {{}},
    lualine_y = {{}},
    lualine_z = {{}},
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {'man', 'toggleterm'}
}
