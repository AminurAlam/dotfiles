---@module 'lazy.nvim'
---@type LazyPluginSpec
return { -- TODO: incremental selection
  'https://github.com/nvim-treesitter/nvim-treesitter',
  branch = 'main',
  build = ':TSUpdate',
}
