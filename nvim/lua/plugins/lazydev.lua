return {
  'https://github.com/folke/lazydev.nvim',
  enabled = true,
  ft = 'lua',
  opts = {
    library = {
      { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
    },
    integrations = { lspconfig = false },
    setup_jsonls = false,
  },
}
