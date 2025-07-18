---@module "lazy"
---@type LazyPluginSpec
return {
  'https://github.com/nvim-tree/nvim-web-devicons',
  lazy = true,
  config = function()
    require('nvim-web-devicons').set_icon {
      fish = {
        icon = '󰈺',
        color = '#89e051',
        cterm_color = '113',
        name = 'fish',
      },
      note = {
        icon = '',
        color = '#519aba',
        cterm_color = '67',
        name = 'note',
      },
      cue = {
        icon = '',
        name = 'cue',
      },
    }
  end,
}
