vim.filetype.add {
  filename = {
    ['mihon_update_errors.txt'] = 'markdown',
    ['PKGBUILD'] = 'sh',
    ['qBittorrent.conf'] = 'ini',
  },
  extension = {
    log = 'log',
    kbd = 'kanata',
    service = 'systemd',
    cue = 'cuesheet',
    note = 'markdown',
    mdx = 'markdown',
    PKGBUILD = 'sh',
    handlebars = 'handlebars',
  },
}

vim.treesitter.language.register('scheme', 'keyboard')
