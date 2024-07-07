return {
  'https://github.com/lukas-reineke/indent-blankline.nvim',
  enabled = true,
  config = function()
    local hooks = require 'ibl.hooks'
    hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
    require('ibl').setup {
      whitespace = { remove_blankline_trail = true },
      scope = { enabled = false },
      exclude = {
        filetypes = { 'checkhealth', 'diff', 'help', 'lspinfo', 'man', '' },
      },
    }
  end,
}
