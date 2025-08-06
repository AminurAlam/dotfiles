---@type vim.pack.Spec
vim.pack.add({
  'https://github.com/nvim-lua/plenary.nvim',
  {
    src = 'https://github.com/nvim-treesitter/nvim-treesitter',
    version = 'main',
    build = ':TSUpdate', -- TODO: implement autocmd
  },
  -- 'https://github.com/nvim-treesitter/nvim-treesitter-context',
  'https://github.com/folke/tokyonight.nvim',
  'https://github.com/lewis6991/gitsigns.nvim',
  'https://github.com/nvimtools/none-ls.nvim',
  'https://github.com/monaqa/dial.nvim',
  'https://github.com/nvim-telescope/telescope.nvim',
  'https://github.com/catgoose/nvim-colorizer.lua',
  -- 'https://github.com/lukas-reineke/indent-blankline.nvim',
  'https://github.com/folke/lazydev.nvim',
  'https://github.com/altermo/ultimate-autopair.nvim',
  'https://github.com/kylechui/nvim-surround',
})

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

require('nvim-surround').setup {
  move_cursor = false,
  surrounds = {
    ['('] = { add = { '(', ')' } },
    ['{'] = { add = { '{', '}' } },
    ['<'] = { add = { '<', '>' } },
    ['['] = { add = { '[', ']' } },
  },
}
require('ultimate-autopair').setup {
  bs = { indent_ignore = true },
  space = { check_box_ft = { 'markdown', 'note' } },
  tabout = { enable = false, hopout = false, map = '<s-tab>' },
  extensions = { cmdtype = { skip = { '@', '-' }, p = 100 } },
  fastwarp = {
    enable = true,
    enable_normal = true,
    enable_reverse = true,
    hopout = false,
    map = '<A-e>',
    rmap = '<A-E>',
    cmap = '<A-e>',
    rcmap = '<A-E>',
    multiline = true,
    nocursormove = true,
    do_nothing_if_fail = true,
    no_filter_nodes = { 'string', 'raw_string', 'string_literals', 'character_literal' },
    faster = false,
    conf = {},
    multi = false,
  },
}

vim.api.nvim_create_autocmd({ 'FileType' }, {
  desc = 'reading mode for some filetypes',
  pattern = { 'lua' },
  callback = function()
    require('lazydev').setup {
      library = { { path = '${3rd}/luv/library', words = { 'vim%.uv' } } },
      integrations = { cmp = false, lspconfig = false },
    }
  end,
})

-- nmap('<leader>pu', lazy.update, 'update plugins')
-- nmap('<leader>pp', lazy.profile, 'open profiler')
-- nmap('<leader>pa', lazy.home, 'plugins info')
