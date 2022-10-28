require('impatient')

local set = vim.o -- opt might be depricated in the future
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
set.pumblend = 10
set.relativenumber = true
set.shiftround = true
-- terminal
set.termguicolors = true
vim.opt.guicursor = { n = 'hor' }
-- gui
set.cmdheight = 0
set.laststatus = 3
set.cursorline = true
set.cursorlineopt = 'number'
set.background = 'dark'
set.numberwidth = 2
set.helpheight = 150
-- set.mousescroll = { ver = 3 }
-- others
set.timeoutlen = 500
set.swapfile = false
set.list = true
set.confirm = true
vim.opt.clipboard:append('unnamedplus')
vim.opt.listchars = {
    tab = '> ',
    trail = ' ',
    extends = '…',
    precedes = '…',
    conceal = 'x',
}
vim.opt.fillchars = {
    fold = ' ',
    foldopen = '',
    foldclose = '',
}

require('mappings')
require('plugins')
require('snippets')
require('colors')

local function load_plugins()
    require('configs.alpha')
    require('configs.cybu')
    -- require('configs.dressing') -- doesnt work w/ lsp
    -- require('configs.fold')
    require('configs.lsp')
    require('configs.lualine')
    -- require('configs.mason')
    require('configs.noice')
    require('configs.notify')
    -- require('configs.switch')
    require('configs.telescope')
    require('configs.treesitter')
    require('configs.trouble')
    require('nvim-cursorline').setup {
        cursorline = { enable = false },
        cursorword = { enable = true },
    }
    require('indent_blankline').setup {
        show_trailing_blankline_indent = false,
        show_current_context = false,
        show_current_context_start = false,
        show_first_indent_level = false,
    }
end

load_plugins()

-- vim.cmd([[
--     augroup AutoSaveFolds
--         autocmd!
--         autocmd BufWinLeave * mkview
--         autocmd BufWinEnter * silent loadview
--     augroup END
-- ]])

vim.g.tex_flavor = 'latex'
vim.diagnostic.config {
    underline = { severity = vim.diagnostic.severity.ERROR },
    virtual_text = { spacing = 4 },
    float = { border = 'rounded' },
    signs = false,
    update_in_insert = true,
    severity_sort = true,
}
