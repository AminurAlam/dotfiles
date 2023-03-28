return {
  'folke/tokyonight.nvim',
  priority = 100,
  opts = {
    style = 'storm', -- The theme comes in three styles, `storm`, a darker variant `night` and `day`
    transparent = false, -- Enable this to disable setting the background color
    terminal_colors = false, -- Configure the colors used when opening a `:terminal` in Neovim
    styles = { -- Value is any valid attr-list value `:help attr-list`
      comments = { italic = false },
      keywords = { italic = false, bold = true },
      functions = { italic = false },
      variables = { italic = false },
      -- Background styles. Can be "dark", "transparent" or "normal"
      sidebars = 'normal', -- style for sidebars, see below
      floats = 'transparent', -- style for floating windows
    },
    hide_inactive_statusline = true, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
    dim_inactive = false, -- dims inactive windows
  },
}
