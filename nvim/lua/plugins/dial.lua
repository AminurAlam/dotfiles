---@module "lazy"
---@type LazyPluginSpec
local M = {
  'https://github.com/monaqa/dial.nvim',
  keys = { { '+', '<plug>(dial-increment)' }, { '-', '<plug>(dial-decrement)' } },
  dependencies = { 'nvim-lua/plenary.nvim' },
}

M.config = function()
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
    },
  }
end

return M
