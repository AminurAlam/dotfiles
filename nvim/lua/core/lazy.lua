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

require('lazy').setup({
    -- theme & design
    { 'folke/tokyonight.nvim', config = function() require('configs.tokyonight') end },
    { 'NvChad/nvim-colorizer.lua', cmd = 'ColorizerToggle' },
    { 'lewis6991/gitsigns.nvim', config = function() require('configs.gitsigns') end },
    { 'nvim-treesitter/nvim-treesitter', config = function() require('configs.treesitter') end },
    { 'lukas-reineke/indent-blankline.nvim', config = function() require('configs.indent') end },
    {
        'goolord/alpha-nvim',
        config = function() require('configs.alpha') end,
        dependencies = { 'nvim-tree/nvim-web-devicons' },
    },
    {
        'nvim-lualine/lualine.nvim',
        config = function() require('configs.lualine') end,
        dependencies = { 'nvim-tree/nvim-web-devicons' },
    },
    {
        'ghillb/cybu.nvim',
        config = function() require('configs.cybu') end,
        cmd = { 'CybuNext', 'CybuPrev' },
        dependencies = { 'nvim-tree/nvim-web-devicons', 'nvim-lua/plenary.nvim' },
    },
    {
        'nvim-telescope/telescope.nvim',
        config = function() require('configs.telescope') end,
        keys = { '<leader>f' },
        cmd = 'Telescope',
        dependencies = { 'nvim-lua/plenary.nvim' },
    },
    -- typing & correction
    { 'kylechui/nvim-surround', keys = { 'cs', 'ds', 'ys' }, config = true },
    { 'numToStr/Comment.nvim', keys = { 'gc' }, config = true },
    { 'windwp/nvim-autopairs', event = { 'InsertEnter' }, config = true },
    {
        'folke/trouble.nvim',
        cmd = { 'TroubleToggle' },
        config = function() require('configs.trouble') end,
    },
    {
        'monaqa/dial.nvim',
        keys = { '+', '-' },
        config = function() require('configs.dial') end,
    },
    -- lsp/cmp
    { 'neovim/nvim-lspconfig', ft = { 'python', 'lua' }, config = function() require('configs.lsp') end },
    {
        'hrsh7th/nvim-cmp',
        event = { 'CmdlineEnter', 'InsertEnter' },
        config = function() require('configs.cmp') end,
        dependencies = {
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },
            { 'hrsh7th/cmp-path' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-cmdline' },
            { 'mtoohey31/cmp-fish' },
            { 'f3fora/cmp-spell' },
            { 'L3MON4D3/LuaSnip' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'rafamadriz/friendly-snippets' },
        },
    },
}, {
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
            disabled_plugins = { 'gzip', 'tarPlugin', 'tohtml', 'tutor', 'zipPlugin' },
        },
    },
    readme = {
        root = vim.fn.stdpath('state') .. '/lazy/readme',
        files = { 'README.md', 'lua/**/README.md' },
        skip_if_doc_exists = true,
    },
    state = vim.fn.stdpath('state') .. '/lazy/state.json', -- state info for checker and other things
})
