local M = {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
        { 'nvim-lua/plenary.nvim' },
    },
    cmd = { 'Telescope', 'Tel' }, -- lazy loads on these commands
    keys = { '<leader>f' }, -- lazy loads on this pattern
}

function M.config()
    require('telescope').setup {
        defaults = {
            prompt_prefix = '  ',
            selection_caret = '» ',
            entry_prefix = ' ',
            prompt_title = false,
            results_title = false,
            winblend = 10,
            file_ignore_patterns = { 'node_modules', '.git', '__pycache__' },
            path_display = {
                shorten = { len = 1, exclude = { 1, -1 } },
            },
            mappings = {
                i = {
                    ['<C-q>'] = require('telescope.actions').close,
                    ['<esc>'] = require('telescope.actions').close,
                    ['<C-Down>'] = require('telescope.actions').cycle_history_next,
                    ['<C-Up>'] = require('telescope.actions').cycle_history_prev,
                },
                n = {
                    ['<C-q>'] = require('telescope.actions').close,
                    ['<esc>'] = require('telescope.actions').close,
                    ['<q>'] = require('telescope.actions').close,
                },
            },
        },
    }

    local builtin = require('telescope.builtin')

    vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
    vim.keymap.set('n', '<leader>fr', builtin.oldfiles, {})
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
    vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
end

return M
