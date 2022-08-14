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

vim.cmd [[
    colorscheme tokyonight
	set guicursor=n-v-c-i-ci-ve-r-cr-o-a-sm:block,v:block
]]

require('remaps')
require('nvim-autopairs').setup({})
require('nvim-treesitter.configs').setup({
	highlight = {enable = true},
	indent = {enabled = false}
})
require('lualine').setup({
	options = {
		theme = 'onedark',
		section_separators = {left = '', right = ''},
	},
	sections = {
		lualine_a = {{'mode', padding = 2}},
		lualine_b = {},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = {{'filename', padding = 2}}
    },
})
