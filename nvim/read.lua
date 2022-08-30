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
set.wrap = true
set.showbreak = ''
set.number = false
-- terminal
set.termguicolors = true
set.guicursor = { a = 'hor' }
-- gui
set.cmdheight = 0
set.laststatus = 3
set.cursorline = true
set.cursorlineopt = 'number'
set.background = 'dark'
set.helpheight = 150
-- others
set.swapfile = false
set.clipboard:append('unnamedplus')

require('remaps')
require('plugins')

require('configs.cybu')
require('configs.telescope')
require('configs.tokyonight')
require('configs.treesitter')

local color = {
    yellow = '#e0af68',
    purple = '#c678dd',
    blue   = '#7aa2f7',
    green  = '#98c379',
    grey   = '#3b4261',
    red    = '#f7768e',
    white  = '#a9b1d6',
    black  = '#1D202F',
}
local theme = {
    normal = {
        a = { fg = color.black,  bg = color.green, gui = 'bold' },
        b = { fg = color.green,  bg = color.grey },
        c = { fg = color.white,  bg = nil },
    },
    insert = {
        a = { fg = color.black,  bg = color.blue, gui = 'bold' },
        b = { fg = color.blue,   bg = color.grey },
    },
    command = {
        a = { fg = color.black,  bg = color.red, gui = 'bold' },
        b = { fg = color.white,  bg = color.grey },
    },
    visual = {
        a = { fg = color.black,  bg = color.purple, gui = 'bold' },
        b = { fg = color.purple, bg = color.grey },
    },
    terminal = {
        a = { fg = color.grey,   bg = '#56b6c2', gui = 'bold' } },
    inactive = {
        a = { fg = color.blue,   bg = '#1f2335', gui = 'bold' },
        b = { fg = color.grey,   bg = '#1f2335' },
    },
    replace = {
        a = { fg = color.black,  bg = color.yellow, gui = 'bold' },
        b = { fg = color.yellow, bg = color.grey },
    },
}

require('lualine').setup {
    options = { theme = theme },
    sections = {
        lualine_a = { { 'mode', padding = 1 } },
        lualine_b = { { 'progress' } },
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = { {'filename',
            filestatus = false,
            symbols = {
                modified = ' ●',
                readonly = ' ',
                unnamed = '[nil]',
                newfile = '[new]',
                alternate_file = '#',
            },
        } }
    },
}
