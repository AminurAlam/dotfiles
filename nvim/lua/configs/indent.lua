local status, ib = pcall(require, 'indent_blankline')
if not status then return end

ib.setup {
    show_first_indent_level = false,
    filetype_exclude = {
        'markdown',
        'text',
        'lspinfo',
        'packer',
        'checkhealth',
        'help',
        'man',
        'log',
        '',
    },
}
