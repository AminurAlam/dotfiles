vim.cmd [[packadd packer.nvim]]
local packer = require('packer')
packer.init({display = { open_fn = function()
	return require('packer.util').float({
        border = 'rounded'
    })
end,},})

return packer.startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- main plugins
    use {'nvim-lua/plenary.nvim'}
    use {'nvim-telescope/telescope.nvim'}
    use {'kyazdani42/nvim-web-devicons'}
    use {'folke/lua-dev.nvim'}
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', config = function()
        require('nvim-treesitter.configs').setup({
            highlight = {enable = true},
            indent = {enable = false},
        })
    end}
    use {'akinsho/toggleterm.nvim'}

    -- theme & design
    use {'norcalli/nvim-colorizer.lua'}
    use {'lukas-reineke/indent-blankline.nvim'}
    use {'folke/tokyonight.nvim'}
    use {'williamboman/mason.nvim',
        config = 'require("mason").setup({})'}
    use {"Pocco81/true-zen.nvim",
        config = 'require("true-zen").setup({})'}
    use {'nvim-lualine/lualine.nvim', config = function ()
        require('lualine').setup({
            options = {theme = 'onedark'},
            sections = {
                lualine_a = {{'mode', padding = 1}},
                lualine_b = {{'branch'}},
                lualine_c = {{'filename'}},
                lualine_x = {{'diagnostics', update_in_insert = true}},
                lualine_y = {{'progress'}},
                lualine_z = {{'filetype', padding = 1}}
            },
        })
    end}
    -- typing & correction
    use {'williamboman/mason-lspconfig.nvim'}
    use {'kylechui/nvim-surround',
        config = 'require("nvim-surround").setup({})'}
    use {'numToStr/Comment.nvim',
        config = 'require("Comment").setup({})'}
    use {'windwp/nvim-autopairs',
        config = 'require("nvim-autopairs").setup({})'}
    use {'folke/trouble.nvim', config = function()
        require("trouble").setup({
            position = "top", height = 8
        })
    end}
    use {'zakharykaplan/nvim-retrail', config = function ()
        require("retrail").setup({
            hlgroup = "Search"
        })
    end}
    use {'amrbashir/nvim-docs-view',
        opt = true, cmd = { "DocsViewToggle" }, config = function()
        require("docs-view").setup({
            position = "right",
            width = 60,
        })
    end}

    -- lsp
    use {'onsails/lspkind-nvim'}
    use {'neovim/nvim-lspconfig'}
    use {'hrsh7th/nvim-cmp'}
    use {'hrsh7th/cmp-nvim-lsp'}
    use {'hrsh7th/cmp-path'}
    use {'hrsh7th/cmp-buffer'}
    use {'hrsh7th/cmp-cmdline'}
    use {'rafamadriz/friendly-snippets'}
    --[[ For vsnip users. ]]
    -- use {'hrsh7th/cmp-vsnip'}
    -- use {'hrsh7th/vim-vsnip'}
    --[[ For luasnip users. ]]
    use {'L3MON4D3/LuaSnip'}
    use {'saadparwaiz1/cmp_luasnip'}



end)
