return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'







    -- basic plugins
    use {'airblade/vim-gitgutter'}
    use {'nvim-lua/plenary.nvim'}
    use {'nvim-telescope/telescope.nvim',
	     cmd = ":Telescope"}
    use {'nvim-treesitter/nvim-treesitter',
	     run = ':TSUpdate'}
    use {'numToStr/Comment.nvim',
	     event = "BufWinEnter",
		 config="require('Comment').setup({})"}
    use {'nvim-neo-tree/neo-tree.nvim', requires = {'MunifTanjim/nui.nvim'}}

    -- themes and design
    use {'nvim-lualine/lualine.nvim'}
    use {'akinsho/bufferline.nvim'}
    use {'kyazdani42/nvim-web-devicons'}
    use {'norcalli/nvim-colorizer.lua', cmd = ":ColorizerToggle"}
    use {'folke/tokyonight.nvim', event = "BufWinEnter"}

    -- correction stuff
    use {'williamboman/mason.nvim'}
    use {'williamboman/mason-lspconfig.nvim', event = "BufWinEnter"}
    use {'folke/trouble.nvim'}
    use {'folke/lua-dev.nvim'}
    use {'windwp/nvim-autopairs'}
    use {'onsails/lspkind-nvim'}
    use {'lukas-reineke/indent-blankline.nvim'}

    -- lsp
    use 'neovim/nvim-lspconfig'  -- Collection of configurations for built-in LSP client
    use 'hrsh7th/nvim-cmp'  -- Autocompletion plugin
    use 'hrsh7th/cmp-nvim-lsp'  -- LSP source for nvim-cmp
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-cmdline'
    use 'rafamadriz/friendly-snippets' -- found all snippet data

    -- use 'hrsh7th/cmp-nvim-lua'
    -- use 'hrsh7th/cmp-nvim-lsp-document-symbol'

    --[] For vsnip users. []
    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/vim-vsnip'
    --[] For luasnip users. []
    use 'L3MON4D3/LuaSnip'
    use 'saadparwaiz1/cmp_luasnip'
    --[] For ultisnips users. []
    -- use 'SirVer/ultisnips'
    -- use 'quangnguyen30192/cmp-nvim-ultisnips'
    --[] For snippy users. []
    -- use 'dcampos/nvim-snippy'
    -- use 'dcampos/cmp-snippy'
end)
