return {
  'lukas-reineke/indent-blankline.nvim',
  enabled = false,
  opts = {
    show_first_indent_level = true,
    filetype_exclude = {
      'markdown',
      'note',
      'text',
      'lspinfo',
      'packer',
      'checkhealth',
      'help',
      'man',
      'log',
      'diff',
      '',
    },
  },
}
