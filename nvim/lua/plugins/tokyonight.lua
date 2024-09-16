return {
  'https://github.com/folke/tokyonight.nvim', -- TODO: try catppuchin
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
  },
}
