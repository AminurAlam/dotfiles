require('Comment').setup {}
require('nvim-autopairs').setup {}
require('nvim-surround').setup {}
require('esqueleto').setup { directory = '/sdcard/main/notes/templates' }
require('indent_blankline').setup {
    show_first_indent_level = false,
    filetype_exclude = { 'lspinfo', 'packer', 'checkhealth', 'help', 'man', '' },
}
