require('colorizer').setup {
  filetypes = {},
  user_default_options = {
    names = false,
    names_custom = false,
    RGB = true,
    RGBA = true,
    RRGGBB = true,
    RRGGBBAA = true,
    AARRGGBB = true,
    rgb_fn = true,
    hsl_fn = false,
    css = true,
    css_fn = false,
    tailwind = false,
    sass = { enable = false, parsers = { 'css' } },
    xterm = true,
    mode = 'virtualtext',
    virtualtext = '███',
  },
}

vim.keymap.set('n', '<leader>co', '<cmd>ColorizerToggle<cr>')

require('tokyonight').setup {
  style = 'storm',
  transparent = true,
  terminal_colors = false,
  styles = {
    comments = { italic = false },
    keywords = { italic = false, bold = true },
    functions = { italic = false },
    variables = { italic = false },
    sidebars = 'normal',
    floats = 'transparent',
  },
  hide_inactive_statusline = true,
  dim_inactive = false,
  lualine_bold = true,
  cached = true,
  on_colors = function(c)
    c.bg_statusline = c.none
  end,
  on_highlights = function(hl, c)
    hl.DiagnosticError = { fg = c.error, bg = c.none }
    hl.DiagnosticWarn = { fg = c.warning, bg = c.none }
    hl.DiagnosticInfo = { fg = c.info, bg = c.none }
    hl.DiagnosticHint = { fg = c.hint, bg = c.none }
    hl.DiagnosticFloatingError = { bg = c.bg }
    hl.DiagnosticFloatingWarn = { bg = c.bg }
    hl.DiagnosticFloatingInfo = { bg = c.bg }
    hl.DiagnosticFloatingHint = { bg = c.bg }
    -- hl('Whitespace', { bg = '#364a82' })
    -- hl.CursorLineNr = {}
    hl.MsgSeparator = { link = 'TermCursorNC' }
    hl.WinSeparator = { link = 'TermCursorNC' }
    hl.Pmenu = { link = 'Normal' }
    hl.PmenuBorder = { link = 'FloatBorder' }
    hl.PmenuMatch = { fg = '#2ac3de', bg = c.none }
    hl['@variable.fish'] = { link = 'Constant' }
    hl['@function.diff'] = { link = 'TabLineSel' }
    hl['@attribute.diff'] = { fg = '#7dcfff', bg = '#3b4261' }
    hl['@constant.fish'] = { link = '@punctuation.special' }
    hl['@punctuation.bracket.fish'] = { link = '@punctuation.special' }
  end,
}

vim.cmd.colorscheme 'tokyonight'
