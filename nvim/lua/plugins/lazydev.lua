return {
  'https://github.com/folke/lazydev.nvim',
  enabled = true,
  ft = 'lua',
  opts = {
    library = {},
    integrations = { lspconfig = false },
    setup_jsonls = false,
  },
}
