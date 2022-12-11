local set = vim.opt -- opt might be depricated in the future

-- indent
set.autoindent = true
set.smartindent = true
set.tabstop = 4
set.shiftwidth = 4
set.smarttab = true
set.softtabstop = 4
set.expandtab = true

-- search
set.hlsearch = true
set.ignorecase = true
set.smartcase = true
set.incsearch = true
set.iskeyword:append('-,$')

-- scrolling
set.scroll = 10
set.scrolloff = 6
set.sidescroll = 4
set.sidescrolloff = 8

-- design
set.showmode = false
set.showcmd = false
set.showtabline = 0
set.showbreak = ' …'
set.number = true
set.relativenumber = true
set.wrap = false
set.colorcolumn = '80'
set.shiftround = true
set.ruler = false
set.signcolumn = 'yes'
set.shortmess = 'acoOsSWIF'

-- terminal & cursor
set.virtualedit = 'onemore'
set.belloff = ''
set.winblend = 10
set.pumblend = 10
set.termguicolors = true
set.guicursor = { n = 'hor' }
set.startofline = true

-- fold
set.foldcolumn = '1'
set.foldlevel = 5
set.foldlevelstart = 99
set.foldenable = true

-- gui
set.cmdheight = 0
set.laststatus = 3
set.cursorline = true
set.cursorlineopt = 'number'
set.background = 'dark'
set.numberwidth = 1
set.helpheight = 150
set.mouse = 'a'

-- others
set.grepprg = 'rg --vimgrep '
set.timeoutlen = 500
set.swapfile = false
set.backup = false
set.undofile = true
set.confirm = true
set.clipboard:append('unnamedplus')
set.list = true
set.listchars = {
    tab = '> ',
    trail = ' ',
    extends = '…',
    precedes = '…',
    conceal = 'x',
}
set.fillchars = {
    eob = ' ',
    fold = ' ',
    foldopen = '',
    foldclose = '',
}
