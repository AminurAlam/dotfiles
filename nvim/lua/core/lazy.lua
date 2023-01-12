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
    { 'nvim-telescope/telescope.nvim', dependencies = { 'nvim-lua/plenary.nvim' } },
    { 'lukas-reineke/indent-blankline.nvim' },
    { 'folke/tokyonight.nvim' },
    { 'nvim-lualine/lualine.nvim', dependencies = { 'kyazdani42/nvim-web-devicons' } },
    { 'goolord/alpha-nvim', dependencies = { 'nvim-tree/nvim-web-devicons' } },
    { 'ghillb/cybu.nvim', dependencies = { 'nvim-tree/nvim-web-devicons', 'nvim-lua/plenary.nvim' } },
    { 'NvChad/nvim-colorizer.lua', cmd = 'ColorizerToggle' },
    {
        'lewis6991/gitsigns.nvim',
        cond = function()
            local filepath = vim.fn.expand('%:p:h')
            local gitdir = vim.fn.finddir('.git', filepath .. ';')
            return (gitdir and #gitdir > 0 and #gitdir < #filepath)
        end,
    },
    { 'karb94/neoscroll.nvim' },
    { 'rcarriga/nvim-notify' },
    -- typing & correction
    { 'kylechui/nvim-surround' },
    { 'numToStr/Comment.nvim' },
    { 'windwp/nvim-autopairs', event = 'InsertEnter' },
    { 'monaqa/dial.nvim' },
    -- lsp/cmp
    {
        'neovim/nvim-lspconfig',
        dependencies = { 'folke/trouble.nvim' },
        ft = { 'python', 'lua', 'json' },
    },
    { 'hrsh7th/nvim-cmp' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/cmp-nvim-lua' },
    { 'hrsh7th/cmp-path' },
    { 'hrsh7th/cmp-buffer' },
    { 'hrsh7th/cmp-cmdline' },
    -- snippets
    { 'L3MON4D3/LuaSnip' },
    { 'saadparwaiz1/cmp_luasnip' },
    { 'rafamadriz/friendly-snippets' },
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

    install = { colorscheme = { 'default' } },
    -- checker = { enabled = true },
})
