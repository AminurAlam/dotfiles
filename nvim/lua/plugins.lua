vim.cmd([[
    packadd packer.nvim
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerCompile
    augroup end
]])

local get = function(plugin) require(plugin).setup {} end

return require('packer').startup {
    function(use)
        -- main plugins
        use { 'wbthomason/packer.nvim' }
        use { 'nvim-lua/plenary.nvim' }
        use { 'kyazdani42/nvim-web-devicons' }
        use { 'folke/neodev.nvim' }
        use { 'nvim-telescope/telescope.nvim' }
        use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
        use { 'lewis6991/impatient.nvim' }

        -- theme & design
        use { 'lukas-reineke/indent-blankline.nvim' }
        use { 'folke/tokyonight.nvim' }
        use { 'nvim-lualine/lualine.nvim' }
        use { 'goolord/alpha-nvim' }
        use { 'stevearc/dressing.nvim' }
        use { 'ghillb/cybu.nvim' }
        use { 'rcarriga/nvim-notify' }
        use { 'yamatsum/nvim-cursorline' }
        use { 'MunifTanjim/nui.nvim' }
        use { 'gorbit99/codewindow.nvim', config = get('codewindow') }
        use { 'folke/noice.nvim' }
        use {
            'NvChad/nvim-colorizer.lua',
            opt = true,
            cmd = { 'ColorizerToggle' },
        }

        -- typing & correction
        use { 'mong8se/actually.nvim' }
        use { 'folke/which-key.nvim' }
        use { 'kylechui/nvim-surround', config = get('nvim-surround') }
        use { 'numToStr/Comment.nvim', config = get('Comment') }
        use { 'windwp/nvim-autopairs', config = get('nvim-autopairs') }
        use { 'folke/trouble.nvim', opt = true, cmd = { 'TroubleToggle' } }
        use {
            'akinsho/toggleterm.nvim',
            tag = '*',
            opt = true,
            cmd = { 'ToggleTerm' },
            config = 'require("configs.toggleterm")',
        }

        -- lsp
        use { 'neovim/nvim-lspconfig' }
        use { 'onsails/lspkind-nvim' }
        use { 'WhoIsSethDaniel/lualine-lsp-progress' }
        -- cmp
        use { 'hrsh7th/nvim-cmp' }
        use { 'hrsh7th/cmp-nvim-lsp' }
        use { 'hrsh7th/cmp-nvim-lua' }
        use { 'hrsh7th/cmp-path' }
        use { 'hrsh7th/cmp-buffer' }
        use { 'hrsh7th/cmp-cmdline' }
        -- snippets
        use { 'L3MON4D3/LuaSnip' }
        use { 'saadparwaiz1/cmp_luasnip' }
        use { 'rafamadriz/friendly-snippets' }
    end,
    config = {
        ensure_dependencies = true,
        plugin_package = 'packer',
        max_jobs = 8,
        auto_clean = true,
        compile_on_sync = true,
        disable_commands = false,
        opt_default = false,
        transitive_opt = true,
        transitive_disable = true,
        git = {
            cmd = 'git',
            subcommands = {
                update = 'pull --ff-only --progress --rebase=false',
                install = 'clone --depth %i --no-single-branch --progress',
                fetch = 'fetch --depth 999999 --progress',
                checkout = 'checkout %s --',
                update_branch = 'merge --ff-only @{u}',
                current_branch = 'branch --show-current',
                diff = 'log --color=never --pretty=format:FMT --no-show-signature HEAD@{1}...HEAD',
                diff_fmt = '%%h %%s (%%cr)',
                get_rev = 'rev-parse --short HEAD',
                get_msg = 'log --color=never --pretty=format:FMT --no-show-signature HEAD -n 1',
                submodules = 'submodule update --init --recursive --progress',
            },
            depth = 1,
            clone_timeout = 60,
            default_url_format = 'https://github.com/%s',
        },
        log = { level = 'warn' },
        display = {
            compact = true,
            non_interactive = false,
            open_fn = function() return require('packer.util').float { border = 'rounded' } end,
            open_cmd = '65vnew \\[packer\\]',
            working_sym = '↓',
            error_sym = '✗',
            done_sym = '✓',
            removed_sym = '-',
            moved_sym = '→',
            header_sym = '━',
            show_all_info = true,
            prompt_border = 'rounded',
            keybindings = {
                quit = 'q',
                toggle_info = '<CR>',
                diff = 'd',
                prompt_revert = 'r',
            },
        },
    },
}
