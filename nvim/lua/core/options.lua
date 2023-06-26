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
set.iskeyword:append('-')

-- spell
set.spellcapcheck = ''
set.spelloptions = 'camel'
set.spellsuggest = { 'best', '10' }

-- scrolling
set.scroll = 20
set.scrolloff = 6
set.sidescroll = 4
set.sidescrolloff = 8
-- if vim.version().minor >= 9 then set.smoothscroll = true end

-- cmdline, statusline & statuscolumn
set.showmode = false
set.ruler = true
set.showcmd = true
set.showcmdloc = 'statusline'
set.laststatus = 3
set.cmdheight = 0
set.numberwidth = 1
set.shortmess = 'acCoOsSWIF'
set.number = true
set.relativenumber = true
-- set.statuscolumn = vim.g.stc -- '%=%{ v:virtnum ? "…" : ( v:relnum ? "│" : "❯" ) }%-00.1s'
set.signcolumn = 'yes:1'

-- folding
set.foldenable = true
set.foldlevel = 3
set.foldnestmax = vim.o.foldlevel + 1
set.foldminlines = 3
set.foldmethod = 'expr'
set.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
set.foldtext = 'getline(v:foldstart) .. " ... " .. trim(getline(v:foldend)) .. " [" .. (v:foldend-v:foldstart+1) .. " lines]"'
set.foldcolumn = '1'

-- terminal, cursor & gui
set.belloff = 'showmatch'
set.winblend = 0
set.pumblend = 0
set.pumheight = 15
set.termguicolors = true
set.guicursor = 'n-sm:hor25,v-o-i-r-c-ci-cr:ver25'
set.startofline = true
set.cursorline = true
set.cursorlineopt = 'number'
set.mouse = 'a'
set.background = 'dark'
set.helpheight = 25
set.wrap = false
set.linebreak = true
set.breakindent = true

-- others
set.formatoptions:remove { 'c', 'r', 'o' }
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
  tab = '  ',
  leadmultispace = '│   ',
  trail = '󱁐',
  extends = '…',
  precedes = '…',
  conceal = '●',
  nbsp = '␣',
}
set.fillchars = {
  stl = ' ',
  fold = ' ',
  foldopen = '',
  foldclose = '',
  msgsep = '─',
  eob = ' ',
  lastline = '.',
}
