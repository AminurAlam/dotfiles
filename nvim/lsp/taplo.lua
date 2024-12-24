---@type vim.lsp.Config
return {
  cmd = {
    'taplo',
    'lsp',
    '-c',
    (vim.env.XDG_CONFIG_HOME or vim.fn.expand '~/.config') .. '/taplo.toml',
    'stdio',
  },
  filetypes = { 'toml' },
  root_markers = { '.' }, -- taplo excludes files if ws doesnt exist
}
