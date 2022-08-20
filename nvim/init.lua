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
set.background = 'dark'
-- oters
set.cursorline = true
set.laststatus = 3
set.numberwidth = 2
set.cursorlineopt = 'number'
set.helpheight = 200
set.swapfile = false
set.clipboard:append('unnamedplus')


require('remaps')
require('plugins')
require('configs.lsp-config')
-- require('configs.lualine-config')
require('configs.toggleterm-config')

vim.g.tokyonight_italic_comments = false
vim.g.tokyonight_italic_functions = false
vim.g.tokyonight_italic_keywords = false

vim.cmd [[
    set colorcolumn=80
    set guicursor=n-v-c-i-ci-ve-r-cr-o-a-sm:hor1,v:block
    colorscheme tokyonight
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerCompile
    augroup end
]]



vim.diagnostic.config({
    underline = false,
    signs = false,
    virtual_text = { spacing = 1 },
    float = {
      show_header = true,
      source = true,
      focus = false,
      width = 60,  -- border = border,
    },
    update_in_insert = true,
    severity_sort = true,
})
