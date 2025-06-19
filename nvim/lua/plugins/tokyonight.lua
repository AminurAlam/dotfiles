return {
  'https://github.com/folke/tokyonight.nvim',
  opts = {
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
    on_colors = function(c) c.bg_statusline = c.none end,
    on_highlights = function(hl, c)
      hl.stl_hl_a = { bg = c.green, fg = '#30354A', bold = true }
      hl.stl_hl_b = { fg = c.green, bg = '#30354A' }
      hl.stl_hl_to = { fg = '#30354A', bg = c.none }
      hl.bg_statusline = c.none -- or "NONE"
      hl.GitSignsAdd = { fg = hl.GitSignsAdd.fg, bg = c.none }
      hl.GitSignsChange = { fg = hl.GitSignsChange.fg, bg = c.none }
      hl.GitSignsDelete = { fg = hl.GitSignsDelete.fg, bg = c.none }
      hl.DiagnosticError = { fg = c.error, bg = c.none }
      hl.DiagnosticWarn = { fg = c.warning, bg = c.none }
      hl.DiagnosticInfo = { fg = c.info, bg = c.none }
      hl.DiagnosticHint = { fg = c.hint, bg = c.none }
      hl.DiagnosticFloatingError = { bg = c.bg }
      hl.DiagnosticFloatingWarn = { bg = c.bg }
      hl.DiagnosticFloatingInfo = { bg = c.bg }
      hl.DiagnosticFloatingHint = { bg = c.bg }
      -- hl('Whitespace', { bg = '#364a82' })
      hl.CursorLineNr = {}
      hl.LineNr = { fg = '#3b4261' }
      hl.Folded = { bg = '#3b4261' }
      hl.HighlightUndo = { link = 'IncSearch' }
      hl.HighlightRedo = { link = 'IncSearch' }
      hl.MsgSeparator = { link = 'TermCursorNC' }
      hl.WinSeparator = { link = 'TermCursorNC' }
      hl.texEmphStyle = { link = 'Normal' }
      hl['@variable.fish'] = { link = 'Constant' }
      hl['@function.diff'] = { link = 'TabLineSel' }
      hl['@attribute.diff'] = { fg = '#7dcfff', bg = '#3b4261' }
      hl['@constant.fish'] = { link = '@punctuation.special' }
      hl['@punctuation.bracket.fish'] = { link = '@punctuation.special' }
    end,
  },
}
