require('Comment').setup {}
require('nvim-autopairs').setup {}
require('nvim-surround').setup {}
require('indent_blankline').setup {
    show_trailing_blankline_indent = false,
    show_current_context = false,
    show_current_context_start = false,
    show_first_indent_level = false,
    filetype_exclude = {
        'alpha',
        'Trouble',
        'packer',
        'lspinfo',
        'TelescopePrompt',
        'help',
        'checkhealth',
        'man',
        '',
    },
}
