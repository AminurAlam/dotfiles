local ensure_packer = function()
    local fn = vim.fn
    local path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    local url = 'https://github.com/wbthomason/packer.nvim'
    if fn.empty(fn.glob(path)) > 0 then
        fn.system { 'git', 'clone', '--depth', '1', url, path }
        vim.cmd('packadd packer.nvim')
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

vim.cmd([[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerCompile
    augroup end
]])

local status, packer = pcall(require, 'packer')
if not status then return end

return packer.startup {
    function(use)
        -- main plugins
        use { 'wbthomason/packer.nvim' }
        use { 'nvim-lua/plenary.nvim' }
        use { 'kyazdani42/nvim-web-devicons' }
        use { 'nvim-telescope/telescope.nvim' }
        use { 'nvim-treesitter/nvim-treesitter' }
        -- theme & design
        use { 'lukas-reineke/indent-blankline.nvim' }
        use { 'folke/tokyonight.nvim' }
        use { 'nvim-lualine/lualine.nvim' }
        use { 'goolord/alpha-nvim' }
        use { 'ghillb/cybu.nvim' }
        use { 'NvChad/nvim-colorizer.lua' }
        use { 'lewis6991/gitsigns.nvim' }
        use { 'rcarriga/nvim-notify' }
        -- typing & correction
        use { 'kylechui/nvim-surround' }
        use { 'numToStr/Comment.nvim' }
        use { 'windwp/nvim-autopairs' }
        use { 'folke/trouble.nvim' }
        use { 'monaqa/dial.nvim' }
        -- lsp/cmp
        use { 'neovim/nvim-lspconfig' }
        use { 'hrsh7th/nvim-cmp' }
        use { 'hrsh7th/cmp-nvim-lsp' }
        use { 'hrsh7th/cmp-nvim-lua' }
        use { 'hrsh7th/cmp-path' }
        use { 'hrsh7th/cmp-buffer' }
        use { 'hrsh7th/cmp-cmdline' }
        use { 'mtoohey31/cmp-fish' }
        use { 'f3fora/cmp-spell' }

        -- snippets
        use { 'L3MON4D3/LuaSnip' }
        use { 'saadparwaiz1/cmp_luasnip' }
        use { 'rafamadriz/friendly-snippets' }
        if packer_bootstrap then require('packer').sync() end
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
