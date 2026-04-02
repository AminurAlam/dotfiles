---@type vim.pack.Spec
vim.pack.add({
  'https://github.com/nvim-lua/plenary.nvim',
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'main' },
  'https://github.com/0xAdk/full_visual_line.nvim',
  'https://github.com/altermo/ultimate-autopair.nvim',
  'https://github.com/catgoose/nvim-colorizer.lua',
  'https://github.com/folke/tokyonight.nvim',
  'https://github.com/kylechui/nvim-surround',
  'https://github.com/monaqa/dial.nvim',
  'https://github.com/nvim-mini/mini.completion',
  'https://github.com/nvim-mini/mini.diff',
  'https://github.com/nvim-mini/mini.pick',
  'https://github.com/nvimtools/none-ls.nvim',
})

require('full_visual_line').setup {}

local augend = require('dial.augend')
require('dial.config').augends:register_group {
  default = {
    augend.integer.alias.decimal, -- nonnegative decimal number (0, 1, 2, 3, ...)
    augend.constant.alias.bool, -- boolean value (true <-> false)
    augend.constant.new { elements = { 'yes', 'no' }, word = true, cyclic = true },
    augend.constant.new { elements = { 'and', 'or' }, word = true, cyclic = true },
    augend.constant.new { elements = { 'True', 'False' }, word = true, cyclic = true },
    augend.constant.new { elements = { '&&', '||' }, word = false, cyclic = true },
    augend.constant.new { elements = { '<', '>=' }, word = false, cyclic = true },
    augend.constant.new { elements = { '>', '<=' }, word = false, cyclic = true },
    augend.constant.new { elements = { '[ ]', '[x]' }, word = false, cyclic = true },
  },
}
