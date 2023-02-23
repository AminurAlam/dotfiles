local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable',
        lazypath,
    }
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup('plugins', {
    root = vim.fn.stdpath('data') .. '/lazy',
    defaults = { lazy = false, version = nil },
    spec = nil,
    lockfile = vim.fn.stdpath('state') .. '/lazy/lazy-lock.json',
    concurrency = 8,
    git = { log = { '--since=3 days ago' } },
    dev = { path = '~/repos', patterns = {}, fallback = false },
    install = { missing = true, colorscheme = { 'default', 'tokyonight' } },
    ui = {
        size = { width = 0.9, height = 0.8 }, -- a number <1 is a percentage., >1 is a fixed size
        wrap = false, -- wrap the lines in the ui
        border = 'rounded',
        icons = {
            import = ' ',
            lazy = '鈴 ',
            loaded = '●',
            not_loaded = '○',
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
            list = { '-', '-', '-', '‒' },
        },
        custom_keys = {},
        browser = nil,
        throttle = 20, -- how frequently should the ui process render events
    },
    diff = { cmd = 'git' },
    checker = { enabled = false },
    change_detection = { enabled = false },
    performance = {
        cache = {
            enabled = true,
            path = vim.fn.stdpath('cache') .. '/lazy/cache',
            disable_events = { 'UIEnter', 'BufReadPre' },
            ttl = 3600 * 24 * 5, -- keep unused modules for up to 5 days
        },
        reset_packpath = true, -- reset the package path to improve startup time
        rtp = {
            reset = true, -- reset the runtime path to $VIMRUNTIME and your config directory
            paths = {}, -- add any custom paths here that you want to includes in the rtp
            disabled_plugins = {
                'gzip',
                'tarPlugin',
                'tohtml',
                'tutor',
                'netrwPlugin',
                'zipPlugin',
                'matchparen',
            },
        },
    },
    readme = {
        root = vim.fn.stdpath('state') .. '/lazy/readme',
        files = { 'README.md', 'lua/**/README.md' },
        skip_if_doc_exists = true,
    },
    state = vim.fn.stdpath('state') .. '/lazy/state.json', -- state info for checker and other things
})
