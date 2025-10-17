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
  -- use null-ls bcz its faster and doesnt modify when no change is detected
  on_attach = function(client) client.server_capabilities.documentFormattingProvider = false end,
}
