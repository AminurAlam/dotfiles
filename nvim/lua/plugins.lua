return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- basic plugins
    use 'airblade/vim-gitgutter'
    use 'nvim-lua/plenary.nvim'
    use 'yamatsum/nvim-cursorline'
    use 'nvim-telescope/telescope.nvim'
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

    -- themes and design
    use 'EdenEast/nightfox.nvim'
    -- use 'ojroques/nvim-hardline'
	use 'nvim-lualine/lualine.nvim'
    use 'akinsho/bufferline.nvim'
    use 'kyazdani42/nvim-web-devicons'
    use 'norcalli/nvim-colorizer.lua'
    use 'folke/todo-comments.nvim'
    use 'folke/tokyonight.nvim'

    -- correction stuff
    use 'williamboman/nvim-lsp-installer'
    use 'folke/trouble.nvim'
    use "folke/lua-dev.nvim"
    use 'windwp/nvim-autopairs'
    use 'onsails/lspkind-nvim'
    use 'neovim/nvim-lspconfig'
    use 'lukas-reineke/indent-blankline.nvim'

    -- cmp
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/vim-vsnip'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-nvim-lua'
    use 'hrsh7th/cmp-nvim-lsp-document-symbol'

    -- snippets
    use 'L3MON4D3/LuaSnip'
    use 'saadparwaiz1/cmp_luasnip'
    use 'dcampos/cmp-snippy'
    use 'dcampos/nvim-snippy'
    use 'rafamadriz/friendly-snippets'

    -- Lazy loading:
    -- use {'tpope/vim-dispatch', opt = true, cmd = {'Dispatch', 'Make', 'Focus', 'Start'}}

    -- Load on an autocommand event
    -- use {'andymass/vim-matchup', event = 'VimEnter'}

    -- Post-install/update hook with neovim command
end)
