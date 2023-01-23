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
    { 'folke/tokyonight.nvim', init = function() require('core.colors') end },
    { 'nvim-treesitter/nvim-treesitter', config = require('configs.treesitter') },
    {
        'nvim-telescope/telescope.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        keys = { '<leader>f' },
        cmd = 'Telescope',
        config = function() require('configs.telescope') end,
    },
    { 'lukas-reineke/indent-blankline.nvim', config = require('configs.indent') },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'kyazdani42/nvim-web-devicons' },
        config = function() require('configs.lualine') end,
    },
    {
        'goolord/alpha-nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function() require('configs.alpha') end,
    },
    {
        'ghillb/cybu.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons', 'nvim-lua/plenary.nvim' },
        cmd = { 'CybuNext', 'CybuPrev' },
        config = function() require('configs.cybu') end,
    },
    { 'NvChad/nvim-colorizer.lua', cmd = 'ColorizerToggle' },
    -- { 'lewis6991/gitsigns.nvim', config = function() require('configs.gitsigns') end },
    { 'rcarriga/nvim-notify' },
    -- typing & correction
    { 'kylechui/nvim-surround', keys = { 'cs', 'ds', 'ys' }, config = true },
    { 'numToStr/Comment.nvim', keys = { 'gc' }, config = true },
    { 'windwp/nvim-autopairs', event = { 'InsertEnter' }, config = true },
    { 'folke/trouble.nvim', cmd = { 'TroubleToggle' } },
    { 'monaqa/dial.nvim', config = function() require('configs.dial') end },
    -- lsp/cmp
    { 'neovim/nvim-lspconfig', config = function() require('configs.lsp') end },
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

    install = { colorscheme = { 'tokyonight' } },
    -- checker = { enabled = true },
})
