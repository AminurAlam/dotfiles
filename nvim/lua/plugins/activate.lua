return {
  'https://github.com/roobert/activate.nvim', -- TODO: cleaner template
  enabled = false,
  keys = {
    { '<leader>pl', '<cmd>lua require("activate").list_plugins()<cr>' },
  },
}
