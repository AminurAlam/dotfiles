---@type vim.lsp.Config
return {
  cmd = { 'ruff', 'server' },
  filetypes = { 'python' },
  root_markers = {
    'pyproject.toml',
    'setup.py',
    'setup.cfg',
    'requirements.txt',
    '.git',
  },
  settings = {
    init_options = {
      settings = { configuration = vim.fn.expand '~/repos/dotfiles/other/ruff.toml' },
    },
  },
}
