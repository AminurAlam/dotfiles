



return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- basic plugins
  use {'airblade/vim-gitgutter', opt=true}
  use 'nvim-lua/plenary.nvim'
  use 'yamatsum/nvim-cursorline'
  use {'nvim-telescope/telescope.nvim', opt = true}
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  -- themes and design
  use 'EdenEast/nightfox.nvim'
  use 'ojroques/nvim-hardline'
  use 'akinsho/bufferline.nvim'
  use 'kyazdani42/nvim-web-devicons'
  -- correction stuff
  use {'williamboman/nvim-lsp-installer', opt = true, cmd = {'LspInstall'}}
  use {'folke/trouble.nvim', opt = true, cmd = {'TroubleToggle'}}
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
