local set = vim.opt

-- indent & spacing
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

-- spell
set.spellcapcheck = ''
set.spelloptions = 'camel'
set.spellsuggest = { 'best', '10' }

-- scrolling
set.scroll = 20
set.scrolloff = 6
set.sidescroll = 4
set.sidescrolloff = 8

-- cmdline, statusline & statuscolumn
set.showmode = false
set.ruler = true
set.showcmd = true
set.showcmdloc = 'statusline' -- https://github.com/neovim/neovim/issues/20087
set.laststatus = 3
set.cmdheight = 0
set.numberwidth = 1
set.shortmess = 'acoOsSWIF'
set.number = false
set.relativenumber = false
set.statuscolumn = '%=%{ v:virtnum ? " " : v:lnum }%{ v:virtnum ? "…" : ( v:relnum ? "│" : "❯" ) }%s%C'
set.foldlevel = 5
set.foldlevelstart = 99
set.foldenable = true

-- terminal, cursor & gui
set.virtualedit = { 'onemore', 'block' }
set.belloff = 'showmatch'
set.winblend = 10
set.pumblend = 10
set.pumheight = 15
set.termguicolors = true
set.guicursor = 'n-sm:hor25,v-o-i-r-c-ci-cr:ver25'
set.startofline = true
set.cursorline = true
set.cursorlineopt = 'number'
set.mouse = 'a'
set.background = 'dark'
set.helpheight = 30
set.wrap = false
set.linebreak = true
set.breakindent = true

-- others
set.formatoptions = ''
set.showmatch = true -- briefly jump to the matching bracket
set.matchtime = 1
set.grepprg = 'rg --vimgrep '
set.timeout = false -- remove for which-key
set.timeoutlen = 1000 -- use 0 for which-key
set.swapfile = false
set.backup = false
set.writebackup = false
set.undofile = true
set.confirm = true
set.clipboard:append('unnamedplus')
set.list = true
set.listchars = {
  tab = '> ',
  trail = ' ',
  extends = '…',
  precedes = '…',
  conceal = '●',
  nbsp = '␣',
}
set.fillchars = {
  eob = ' ',
  fold = ' ',
  foldopen = '',
  foldclose = '',
  lastline = '.',
}
