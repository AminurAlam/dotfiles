require('telescope').setup({
    defaults = {
        prompt_prefix = '  ',
        selection_caret = ' » ',
        entry_prefix = '  ',
        prompt_title = false,
        file_ignore_patterns = {
            'node_modules',
            '.git',
            '__pycache__'
        },
        path_display = {
            shorten = {
                len = 1,
                exclude = {1, -1}
            }
        },
        mappings = {
            i = {
                ['<C-q>'] = require('telescope.actions').close,
                ['<esc>'] = require('telescope.actions').close,
            },
            n = {
                ['<C-q>'] = require('telescope.actions').close,
                ['<esc>'] = require('telescope.actions').close,
                ['<q>'] = require('telescope.actions').close,
            }
        }
    },
    -- pickers = {},
    -- extensions = {}
})
