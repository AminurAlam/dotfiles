return {
  'roobert/activate.nvim', -- TODO: cleaner template
  keys = {
    { '<leader>pl', '<cmd>lua require("activate").list_plugins()<cr>' },
  },
}
