vim.filetype.add {
  pattern = {
    ['.*%.log'] = 'log',
    ['.*%.cue'] = 'cuesheet',
    ['.*%.note'] = 'note',
    ['.*%.conf'] = 'conf',
    ['mihon_update_errors.txt'] = 'markdown',
  },
}
