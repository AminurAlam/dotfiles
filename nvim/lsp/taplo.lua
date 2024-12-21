vim.lsp.config('taplo', {
  cmd = {
    'taplo',
    'lsp',
    '-c',
    (vim.env.XDG_CONFIG_HOME or vim.fn.expand '~/.config') .. '/taplo.toml',
    'stdio',
  },
  filetypes = { 'toml' },
})
