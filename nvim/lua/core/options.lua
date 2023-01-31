local set = vim.opt

-- indent and spacing
set.autoindent = true
set.smartindent = true
set.tabstop = 4
set.shiftwidth = 4
set.smarttab = true
set.softtabstop = 4
set.expandtab = true
set.shiftround = true

-- search
set.hlsearch = true
set.ignorecase = true
set.smartcase = true
set.incsearch = true
set.iskeyword:append('-,$')

-- scrolling
set.scroll = 20
set.scrolloff = 6
set.sidescroll = 4
set.sidescrolloff = 8

-- column
set.wrap = false
set.number = false
set.relativenumber = false
set.breakindent = true
set.statuscolumn = vim.g.stc_number .. vim.g.stc_symbol .. '%s%C'

-- design
set.showmode = false
set.ruler = false
set.showcmd = true
set.showmatch = true
set.matchtime = 2
set.showcmdloc = 'statusline' -- https://github.com/neovim/neovim/issues/20087
set.shortmess = 'acoOsSWIF'

-- terminal & cursor
set.virtualedit = 'onemore'
set.belloff = 'showmatch'
set.winblend = 10
set.pumblend = 10
set.termguicolors = true
set.guicursor = 'n-sm:hor25,v-o-i-r-c-ci-cr:ver25'
set.startofline = true

-- fold
set.foldlevel = 5
set.foldlevelstart = 99
set.foldenable = true

-- gui
set.laststatus = 3
set.cmdheight = 0
set.helpheight = 150
set.numberwidth = 1
set.cursorline = true
set.cursorlineopt = 'number'
set.mouse = 'a'
set.background = 'dark'

-- others
set.grepprg = 'rg --vimgrep '
set.timeout = false
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
    lastline = '.',
}
set.runtimepath = {
    '~/.config/nvim',
    '~/.local/share/nvim/site',
    '/data/data/com.termux/files/usr/share/nvim/runtime/',
}
