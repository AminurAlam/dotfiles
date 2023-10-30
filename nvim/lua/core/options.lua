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
set.cinkeys:remove { ':' }

-- search
set.hlsearch = true
set.ignorecase = true
set.smartcase = true
set.incsearch = true
set.iskeyword:append '-'

-- spell
set.spellcapcheck = ''
set.spelloptions = 'camel'
set.spellsuggest = { 'best', '10' }

-- scrolling
set.scroll = 20
set.scrolloff = 6
set.sidescroll = 4
set.sidescrolloff = 8
set.smoothscroll = true

-- cmdline, statusline & statuscolumn
set.showmode = false
set.ruler = false
set.rulerformat = '%p%%'
set.showcmd = true
set.showcmdloc = 'statusline'
set.laststatus = 3
set.cmdheight = 0
set.numberwidth = 1
set.shortmess = 'acCoOsSWIF'
set.number = true
set.relativenumber = true
-- set.statuscolumn = vim.g.stc -- '%=%{ v:virtnum ? "…" : ( v:relnum ? "│" : "❯" ) }%-00.1s'
set.signcolumn = 'number'

-- folding
set.foldenable = false
set.foldlevel = 3
set.foldnestmax = vim.o.foldlevel + 1
set.foldminlines = 3
set.foldmethod = 'manual'
set.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
set.foldtext =
  [[substitute(getline(v:foldstart), "\\s\\(--\\|#\\).*", "", "" ) .. " ... " .. trim(getline(v:foldend)) .. " [" .. (v:foldend-v:foldstart+1) .. " lines]"]]
set.foldcolumn = 'auto'
set.foldopen:append {}
set.viewoptions = 'cursor,folds'

-- terminal, cursor & gui
set.belloff = 'showmatch'
set.winblend = 0
set.pumblend = 0
set.pumheight = 15
set.termguicolors = true
set.startofline = true
set.cursorline = true
set.cursorlineopt = 'number,screenline'
set.mouse = 'a'
set.background = 'dark'
set.helpheight = 25
set.wrap = false
set.linebreak = true
set.breakindent = true
set.guicursor = 'n-sm-r:block,v-o-i-c-ci-cr:ver100'
if vim.fn.has('termux') == 1 then
  set.guicursor = 'n-sm-r:hor100,v-o-i-c-ci-cr:ver100'
  set.mousescroll = 'ver:1,hor:6'
end

-- others
set.concealcursor = 'n'
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
set.clipboard = '' -- see <leader>sr in mappings.lua
set.list = true
set.listchars = {
  tab = '  ',
  leadmultispace = '│   ',
  trail = ' ',
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
  diff = '╱',
}
