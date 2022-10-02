require('impatient')

local set = vim.opt  -- opt might be depricated in the future
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
set.sidescroll = 4
set.sidescrolloff = 8
-- design
set.wrap = false
set.showbreak = ' …'
set.number = true
set.colorcolumn = '80'
-- terminal
set.termguicolors = true
set.guicursor = { n = 'hor' }
-- gui
set.cmdheight = 0
set.laststatus = 3
set.cursorline = true
set.cursorlineopt = 'number'
set.background = 'dark'
set.numberwidth = 2
set.helpheight = 150
-- others
set.swapfile = false
set.clipboard:append('unnamedplus')
set.list = true
set.listchars = {
    tab = '> ',
    trail = ' ',
    extends = '…',
    precedes = '…',
    conceal = 'x',
}

vim.g.tex_flavor = 'latex'
vim.opt.fillchars = {
    fold = " ",
}

require('remaps')
require('plugins')
require('snippets')

local function load()
    require('configs.alpha') -- startify
    -- require('configs.comments') -- only supports //
    require('configs.cybu')
    -- require('configs.dressing') -- doesnt work w/ lsp
    -- require('configs.fold')
    require('configs.lsp')
    require('configs.lualine')
    -- require('configs.mason')
    -- require('configs.retrail')
    -- require('configs.switch')
    require('configs.telescope')
    require('configs.tokyonight')
    require('configs.treesitter')
end

load()

-- vim.cmd([[
--     augroup AutoSaveFolds
--         autocmd!
--         autocmd BufWinLeave * mkview
--         autocmd BufWinEnter * silent loadview
--     augroup END
-- ]])

vim.diagnostic.config {
    underline = { severity = vim.diagnostic.severity.ERROR },
    virtual_text = { spacing = 4 },
    float = { border = 'rounded' },
    signs = false,
    update_in_insert = true,
    severity_sort = true,
}
