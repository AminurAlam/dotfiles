require('impatient')

local set = vim.opt
-- indent
set.autoindent = true
set.smartindent = true
set.tabstop = 4
set.shiftwidth = 4
set.smarttab = true
set.softtabstop = 4
set.expandtab = true
-- search
set.hlsearch = false
set.ignorecase = true
set.smartcase = true
set.incsearch = true
-- scrolling
set.scroll = 10
set.scrolloff = 6
set.sidescroll = 4
set.sidescrolloff = 8
-- design
set.wrap = false
set.showbreak = ' …'
-- set.fillchars = 'fold: ,eob: '
-- set.mouse = 'nvic'
set.number = true
set.colorcolumn = '80'
-- terminal
set.termguicolors = true
set.guicursor = { a = 'hor' }
-- gui
set.cmdheight = 0
set.laststatus = 3
set.cursorline = true
set.cursorlineopt = 'number'
set.background = 'dark'
set.numberwidth = 2
set.helpheight = 150
-- others
set.swapfile = false
set.clipboard:append('unnamedplus')

require('remaps')
require('plugins')

require('configs.alpha')
require('configs.cybu')
require('configs.lsp')
require('configs.lualine')
require('configs.mason')
-- require('configs.retrail')
require('configs.switch')
require('configs.telescope')
require('configs.toggleterm')
require('configs.tokyonight')
require('configs.treesitter')

vim.diagnostic.config({
    underline = false,
    signs = false,
    virtual_text = { spacing = 1 },
    float = {
        show_header = true,
        source = true,
        focus = false,
        width = 60,
        border = 'rounded',
    },
    update_in_insert = true,
    severity_sort = true,
})
