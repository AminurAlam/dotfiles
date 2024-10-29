return {
  'https://github.com/folke/tokyonight.nvim',
  opts = {
    style = 'storm',
    transparent = false,
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
    on_highlights = function(hl, c)
      hl.GitSignsAdd = { fg = hl.GitSignsAdd.fg, bg = c.bg }
      hl.GitSignsChange = { fg = hl.GitSignsChange.fg, bg = c.bg }
      hl.GitSignsDelete = { fg = hl.GitSignsDelete.fg, bg = c.bg }
      hl.stl_hl_a = { bg = '#98c379', fg = '#30354A', bold = true }
      hl.stl_hl_b = { fg = '#98c379', bg = '#30354A' }
      hl.stl_hl_to = { fg = '#30354A', bg = 'bg' }
      -- hl('Whitespace', { bg = '#364a82' })
      hl.DiagnosticFloatingError = { bg = nil }
      hl.DiagnosticFloatingWarn = { bg = nil }
      hl.DiagnosticFloatingInfo = { bg = nil }
      hl.DiagnosticFloatingHint = { bg = nil }
      hl.CursorLineNr = {}
      hl.LineNr = { fg = '#3b4261' }
      hl.Folded = { bg = '#3b4261' }
      hl.HighlightUndo = { link = 'IncSearch' }
      hl.HighlightRedo = { link = 'IncSearch' }
      hl.MsgSeparator = { link = 'TermCursorNC' }
      hl.WinSeparator = { link = 'TermCursorNC' }
      hl['@function.call.fish'] = { link = 'Special' }
      hl['@variable.fish'] = { link = 'Constant' }
      hl['@function.diff'] = { link = 'TabLineSel' }
      hl['@attribute.diff'] = { fg = '#7dcfff', bg = '#3b4261' }
      hl['@constant.fish'] = { link = '@punctuation.special' }
      hl['@punctuation.bracket.fish'] = { link = '@punctuation.special' }
    end,
  },
}
