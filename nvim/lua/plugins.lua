vim.cmd([[
    packadd packer.nvim
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerCompile
    augroup end
]])

return require('packer').startup {
    function(use)
        -- main plugins
        use { 'wbthomason/packer.nvim' }
        use { 'nvim-lua/plenary.nvim' }
        use { 'kyazdani42/nvim-web-devicons' }
        use { 'folke/lua-dev.nvim' }
        use { 'nvim-telescope/telescope.nvim' }
        use { 'nvim-treesitter/nvim-treesitter' }
        use { 'akinsho/toggleterm.nvim', tag = 'v2.*' }
        use { 'lewis6991/impatient.nvim' }
        -- use {'winston0410/cmd-parser.nvim'}
        -- use { 'winston0410/range-highlight.nvim',
        --       config = 'require"range-highlight".setup({})',
        -- }

        -- theme & design
        use { 'lukas-reineke/indent-blankline.nvim' }
        use { 'folke/tokyonight.nvim' }
        use { 'nvim-lualine/lualine.nvim' }
        use { 'stevearc/dressing.nvim' }
        use { 'NvChad/nvim-colorizer.lua',
              opt = true,
              cmd = { 'ColorizerToggle' },
        }
        use { 'williamboman/mason.nvim' }
        use { 'Pocco81/true-zen.nvim',
              opt = true,
              cmd = { 'TZNarrow', 'TZFocus', 'TZMinimalist', 'TZAtaraxis' },
              config = 'require("true-zen").setup({})',
        }
        use { 'goolord/alpha-nvim' }
        use { 'ghillb/cybu.nvim' }
        use { 'Djancyp/better-comments.nvim' }

        -- typing & correction
        use { 'williamboman/mason-lspconfig.nvim' }
        use { 'zakharykaplan/nvim-retrail' }
        use { 'gaoDean/autolist.nvim',
              config = 'require("autolist").setup({})'
        }
        use { 'kylechui/nvim-surround',
              config = 'require("nvim-surround").setup({})',
        }
        use { 'numToStr/Comment.nvim',
              config = 'require("Comment").setup({})',
        }
        use { 'windwp/nvim-autopairs',
              config = 'require("nvim-autopairs").setup({})',
        }
        use { 'folke/trouble.nvim',
              opt = true,
              cmd = { 'TroubleToggle' },
              config = function()
                  require('trouble').setup { position = 'top', height = 8 }
              end,
        }

        -- lsp
        use { 'neovim/nvim-lspconfig' }
        use { 'onsails/lspkind-nvim' }
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
            non_interactive = false,
            open_fn = function()
                return require('packer.util').float { border = 'rounded' }
            end,
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
