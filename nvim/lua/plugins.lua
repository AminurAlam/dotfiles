local M = {}

local base_plugins = {
    {'numToStr/Comment.nvim', config = 'require("Comment").setup({})'},
    {'windwp/nvim-autopairs', config = 'require("nvim-autopairs").setup({})'},
    {'kylechui/nvim-surround', config = 'require("nvim-surround").setup({})'},
    {'folke/tokyonight.nvim',
        config = function()
            vim.g.tokyonight_italic_comments = false
            vim.g.tokyonight_italic_functions = false
            vim.g.tokyonight_italic_keywords = false
            vim.cmd('colorscheme tokyonight')
        end},
}

local full_plugins = {

    -- no config needed
    {'wbthomason/packer.nvim'},
    {'nvim-lua/plenary.nvim'},
    {'kyazdani42/nvim-web-devicons'},
    {'lukas-reineke/indent-blankline.nvim'},
    {'folke/lua-dev.nvim'},
    {'mfussenegger/nvim-dap'},

    -- config in a custom file
    {'nvim-lualine/lualine.nvim', config = 'require("lualine-config")'},
    {'akinsho/toggleterm.nvim', config = 'require("toggleterm-config")'},

    -- default config
    {'williamboman/mason.nvim'},
    {'williamboman/mason-lspconfig.nvim'},
    {'rcarriga/nvim-dap-ui', requires = {'mfussenegger/nvim-dap'}},
    {'norcalli/nvim-colorizer.lua',
        config = 'require("colorizer").setup({})'},

    -- small ammount of config
    {'zakharykaplan/nvim-retrail',
        config = function ()
            require("retrail").setup({hlgroup = "Search"})
        end},
    {'folke/trouble.nvim',
        config = function() require("trouble").setup({
            position = "top", height = 8
        }) end},
    {'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function() require('nvim-treesitter.configs').setup({
            highlight = {enable = true},
            indent = {enable = false},
        }) end},
    {'nvim-telescope/telescope.nvim',
        config = function() require('telescope').setup({defaults = {
            prompt_prefix = '  ',
            file_ignore_patterns = {'node_modules'}}
        }) end},

    --[[ i hate lsp configuration ]]
    {'neovim/nvim-lspconfig'},
    {'hrsh7th/nvim-cmp'},
    {'hrsh7th/cmp-nvim-lsp'},
    {'onsails/lspkind-nvim'},
    {'hrsh7th/cmp-path'},
    {'hrsh7th/cmp-buffer'},
    {'hrsh7th/cmp-cmdline'},
    {'rafamadriz/friendly-snippets'},
    --[[ For vsnip users. ]]
    {'hrsh7th/cmp-vsnip'},
    {'hrsh7th/vim-vsnip'},
    --[[ For luasnip users. ]]
    {'L3MON4D3/LuaSnip'},
    {'saadparwaiz1/cmp_luasnip'},
}

function M.load(config)
    local plugins = {}

    -- first picks basic plugins
    for _, value in ipairs(base_plugins) do
        table.insert(plugins, value)
    end

    -- then picks full plugins
    if config == 'full' then
        for _, value in ipairs(full_plugins) do
            table.insert(plugins, value)
        end
    end

    -- using the plugims
    require('packer').startup({plugins, config = {
        display = {open_fn = require('packer.util').float},}
    })
end

return M
