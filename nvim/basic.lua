local set = vim.opt
local g = vim.g

-- indent
set.autoindent = true
set.smartindent = true
set.tabstop = 4
set.shiftwidth = 4
set.smarttab = true
set.softtabstop = 4

-- search
set.hlsearch = false
set.ignorecase = true
set.smartcase = true
set.incsearch = true

-- scrolling
set.scroll = 10
set.scrolloff = 6
set.sidescroll = 8
set.sidescrolloff = 10

-- design
set.wrap = false
set.showbreak = ' …'
set.inccommand = 'split'
set.fillchars = 'fold: ,eob: '
set.mouse = 'nvic'
set.number = true

-- terminal
set.termguicolors = true
set.cmdheight = 0

-- oters
set.cursorline = true
set.laststatus = 3
set.numberwidth = 2
set.cursorlineopt = 'number'
set.helpheight = 200
set.swapfile = false
set.clipboard:append('unnamedplus')

g.tokyonight_italic_comments = false
g.tokyonight_italic_functions = false
g.tokyonight_italic_keywords = false
g.tokyonight_sidebars = {'terminal', 'packer', 'Trouble'}
g.tokyonight_colors = {hint = 'orange', error = '#ff0000'}

vim.cmd [[
    colorscheme tokyonight
	set guicursor=n-v-c-i-ci-ve-r-cr-o-a-sm:hor1,v:block
]]

require("remaps")
require("lualine").setup({})
require('Comment').setup({})
require('nvim-autopairs').setup({})
require('indent_blankline').setup({})
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'onedark',
    always_divide_middle = true,
    globalstatus = true,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {{'mode', padding = 1}},
    lualine_b = {{'filename'}},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {{'progress'}},
    lualine_z = {{'filetype', padding = 1}}
  },
}


