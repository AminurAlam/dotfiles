-- https://vonheikemen.github.io/devlog/tools/configuring-neovim-using-lua/


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


-- vim.g.tokyonight_style = "night"
g.tokyonight_italic_comments = false
g.tokyonight_italic_functions = false
g.tokyonight_italic_keywords = false
g.tokyonight_sidebars = {'terminal', 'packer', 'Trouble'}
g.tokyonight_colors = {hint = 'orange', error = '#ff0000'}


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
