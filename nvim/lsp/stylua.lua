---@type vim.lsp.Config
return {
  cmd = { 'stylua', '-f', vim.fs.abspath('~/.config/stylua.toml'), '--lsp' },
  filetypes = { 'lua' },
  root_markers = {
    {
      '.emmyrc.json',
      '.luarc.json',
      '.luarc.jsonc',
    },
    {
      '.luacheckrc',
      '.stylua.toml',
      'stylua.toml',
      'selene.toml',
      'selene.yml',
    },
    '.git',
    'lua/',
  },
}
