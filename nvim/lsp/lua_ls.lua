---@type vim.lsp.Config
return {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  root_markers = {
    'lua/',
    '.luarc.json',
    '.luarc.jsonc',
    '.luacheckrc',
    '.stylua.toml',
    'stylua.toml',
    'selene.toml',
    'selene.yml',
  },
  on_attach = function(client) client.server_capabilities.documentFormattingProvider = false end,
  settings = {
    Lua = {
      library = vim.api.nvim_get_runtime_file('', true),
      completion = { callSnippet = 'Replace', displayContext = 5 },
      format = { enable = false },
      semantic = { enable = false },
      telemetry = { enable = false },
      window = { progressBar = true },
      workspace = { checkThirdParty = false },
    },
  },
}
