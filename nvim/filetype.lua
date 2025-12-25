vim.filetype.add {
  filename = {
    ['mihon_update_errors.txt'] = 'markdown',
    ['PKGBUILD'] = 'sh',
  },
  extension = {
    log = 'log',
    kbd = 'keyboard',
    service = 'systemd',
    cue = 'cuesheet',
    note = 'markdown',
    mdx = 'markdown',
    PKGBUILD = 'sh',
    handlebars = 'handlebars',
  },
}

vim.treesitter.language.register('scheme', 'keyboard')
