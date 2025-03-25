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
  settings = {
    Lua = {
      library = vim.api.nvim_get_runtime_file('', true),
      typeFormat = { config = { auto_complete_end = true } },
      completion = { callSnippet = 'Replace', displayContext = 5 },
      diagnostics = {
        globals = { '_G', 'vim', 'love', 'drastic', 'ya', 'Command', 'cx' },
        libraryFiles = 'Disable',
        disable = { 'lowercase-global' },
      },
      format = { enable = false },
      hint = { enable = true },
      runtime = {
        version = 'LuaJIT',
        path = { 'lua/?.lua', 'lua/?/init.lua' },
      },
      semantic = { enable = false },
      telemetry = { enable = false },
      window = { progressBar = false },
      workspace = {
        checkThirdParty = false,
        library = { vim.env.VIMRUNTIME },
      },
    },
  },
}
