return {
  'https://github.com/folke/neodev.nvim',
  enabled = false,
  ft = 'lua',
  opts = {
    library = {
      enabled = true,
      runtime = true,
      types = true,
      plugins = true,
    },
    setup_jsonls = false,
  },
}
