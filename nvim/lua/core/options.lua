local set = vim.o
local termux = vim.fn.has('termux') == 1

---@param opt_table table
---@return string
local dict2str = function(opt_table)
  local optstr = ''
  for k, v in pairs(opt_table) do
    optstr = optstr .. string.format(',%s:%s', k, v)
  end
  return string.sub(optstr, 2)
end

do -- indent & spacing
  set.autoindent = true
  set.smartindent = true
  set.tabstop = 4
  set.shiftwidth = 4
  set.smarttab = true
  set.softtabstop = 4
  set.expandtab = true
  set.shiftround = true
end

do -- words, searching
  set.hlsearch = true
  set.ignorecase = true
  set.smartcase = true
  set.incsearch = true
  set.iskeyword = set.iskeyword .. ',-'
  set.spellcapcheck = ''
  set.spelloptions = 'camel'
  set.spellsuggest = 'best,10'
end

do -- scrolling
  set.scrolloff = 6
  set.sidescroll = 4
  set.sidescrolloff = 8
  set.smoothscroll = true
  if termux then set.mousescroll = 'ver:1,hor:6' end
end

do -- cmdline, statusline & statuscolumn
  set.showmode = false
  set.ruler = false
  set.rulerformat = '%p%%'
  set.showcmd = true
  set.showcmdloc = 'statusline'
  set.laststatus = 3
  set.cmdheight = 0
  set.numberwidth = 1
  set.shortmess = 'acCoOsSWF'
  set.number = true
  set.relativenumber = false
  set.signcolumn = 'number'
end

do -- folding
  set.foldenable = true
  set.foldclose = ''
  set.foldlevel = 10
  set.foldnestmax = set.foldlevel + 1
  set.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
  -- set.foldmethod = 'expr'
  set.foldtext = ''
  -- .. [[substitute(getline(v:foldstart), "\\s\\(--\\|#\\).*", "", "" )]]
  -- .. [[ . " … " . trim(getline(v:foldend)) . ]]
  -- .. [[" [" . (v:foldend-v:foldstart+1) . " lines]"]]
  set.foldcolumn = 'auto'
  set.viewoptions = 'cursor,folds'
end

do -- terminal, cursor & gui
  set.belloff = termux and 'showmatch' or 'all'
  -- set.winborder = 'rounded' -- causes lot of unexpected behaviour
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
  set.guicursor = dict2str {
    ['n-sm-r'] = termux and 'hor100' or 'block',
    ['v-o-i-c-ci-cr'] = 'ver100',
  }
end

do -- others
  set.concealcursor = 'n'
  set.matchtime = 1
  set.grepprg = 'rg --vimgrep '
  set.timeout = false -- remove for which-key
  set.timeoutlen = 1000 -- use 0 for which-key
  set.swapfile = true
  set.backup = false
  set.writebackup = false
  set.undofile = true
  set.confirm = true
  set.clipboard = (termux and vim.env.SSH_CLIENT) and '' or 'unnamedplus'
  set.list = true
  set.listchars = dict2str {
    -- leadmultispace = '│   ',
    tab = '> ',
    trail = ' ',
    extends = '…',
    precedes = '…',
    conceal = '●',
    nbsp = '␣',
  }
  set.fillchars = dict2str {
    stl = ' ',
    fold = ' ',
    foldopen = '',
    foldclose = '',
    msgsep = '─',
    eob = ' ',
    lastline = '.',
    diff = '╱',
  }
end
