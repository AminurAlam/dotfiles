local status, telescope = pcall(require, 'telescope')
if not status then return end

telescope.setup {
    defaults = {
        prompt_prefix = '  ',
        selection_caret = '» ',
        entry_prefix = ' ',
        prompt_title = false,
        results_title = false,
        winblend = 10,
        file_ignore_patterns = { 'node_modules', '\\.git', '__pycache__', 'stylua.toml' },
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
