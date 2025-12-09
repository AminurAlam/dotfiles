---@type vim.pack.Spec
vim.pack.add({
  'https://github.com/nvim-lua/plenary.nvim',
  {
    src = 'https://github.com/nvim-treesitter/nvim-treesitter',
    version = 'main',
  },
  'https://github.com/altermo/ultimate-autopair.nvim',
  'https://github.com/catgoose/nvim-colorizer.lua',
  'https://github.com/folke/tokyonight.nvim',
  'https://github.com/kylechui/nvim-surround',
  'https://github.com/lewis6991/gitsigns.nvim',
  'https://github.com/monaqa/dial.nvim',
  'https://github.com/nvim-telescope/telescope.nvim',
  'https://github.com/nvimtools/none-ls.nvim',
  'https://github.com/folke/lazydev.nvim',
  'https://github.com/saghen/blink.cmp', -- https://cmp.saghen.dev/
  'https://github.com/saghen/blink.compat',
  'https://github.com/mtoohey31/cmp-fish',
  'https://github.com/0xAdk/full_visual_line.nvim',
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

require('lazydev').setup {
  library = { { path = '${3rd}/luv/library', words = { 'vim%.uv' } } },
  integrations = { cmp = false, lspconfig = false },
}

vim.keymap.set('n', '<leader>pu', vim.pack.update, { desc = 'update plugins' })
vim.keymap.set('n', '<leader>pa', function()
  -- stylua: ignore
  vim.print(table.concat(vim.tbl_map(function(pack)
    return string.format('\n%s %s (%s)', pack.active and '󰸞' or ' ', pack.spec.name, pack.spec.version)
  end, vim.pack.get()), '') .. '\nTotal count: ' .. #vim.pack.get())
end, { desc = 'plugins info' })
