vim.filetype.add {
  pattern = {
    ['.*%.log'] = 'log',
    ['.*%.cue'] = 'cuesheet',
    ['.*%.note'] = 'note',
    ['.*%.conf'] = 'toml',
    ['newsboat%-article%..*'] = 'article',
  },
}
