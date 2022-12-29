local g = vim.g
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
        'git',
        'clone',
        '--filter=blob:none',
        '--single-branch',
        'https://github.com/folke/lazy.nvim.git',
        lazypath,
    }
end

vim.opt.runtimepath:prepend(lazypath)

g.netrw_banner = 0
g.netrw_hide = 0
g.netrw_liststyle = 3
g.mapleader = ' '

-- require('core.plugins')
require('lazy').setup('plugins', {
    ui = {
        border = 'rounded',
        icons = {
            cmd = '',
            config = '',
            event = '',
            ft = '',
            init = '',
            keys = '',
            plugin = '',
            runtime = '',
            source = '',
            start = '',
            task = '',
            lazy = '',
            list = { '-', '-', '-', '‒' },
        },
        custom_keys = {},
    },
    change_detection = {
        enabled = true,
        notify = false, -- get a notification when changes are found
    },
})

require('core.options')
require('core.mappings')
require('core.autocommands')

vim.diagnostic.config {
    underline = { severity = vim.diagnostic.severity.ERROR },
    virtual_text = { spacing = 2, prefix = '' },
    signs = false,
    float = { border = 'rounded' },
    update_in_insert = true,
    severity_sort = true,
}
