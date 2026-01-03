---@type vim.lsp.Config
return {
  cmd = { 'ruff', 'server' },
  filetypes = { 'python' },
  root_markers = {
    'pyproject.toml',
    'ruff.toml',
    '.ruff.toml',
    '.git',
    'setup.py',
    'setup.cfg',
    'requirements.txt',
  },
  settings = {
    init_options = {
      settings = {
        configuration = (vim.env.XDG_CONFIG_HOME or vim.fn.expand '~/.config') .. 'ruff/ruff.toml',
      },
    },
  },
}
