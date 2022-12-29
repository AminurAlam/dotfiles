local M = {
    'ghillb/cybu.nvim',
    lazy = true,
    keys = { '<c-left>', '<c-right>' },
    cmd = { 'CybuNext', 'CybuPrev' },
}

function M.config()
    require('cybu').setup {
        position = {
            relative_to = 'win', -- win, editor, cursor
            anchor = 'bottomright',
            vertical_offset = 1,
            horizontal_offset = 1,
            max_win_height = 10,
            max_win_width = 0.99,
        },
        style = {
            path = 'relative',
            path_abbreviation = 'shortened',
            border = 'rounded',
            separator = ' ',
            prefix = '…',
            padding = 1,
            hide_buffer_id = true,
            devicons = {
                enabled = true,
                colored = true,
                truncate = true,
            },
        },
        behavior = { -- set behavior for different modes
            mode = {
                default = {
                    switch = 'immediate', -- immediate, on_close
                    view = 'rolling', -- paging, rolling
                },
                last_used = {
                    switch = 'on_close', -- immediate, on_close
                    view = 'paging', -- paging, rolling
                },
            },
        },
        display_time = 1500, -- time the cybu window is displayed
        exclude = { 'neo-tree', 'fugitive', 'qf' },
        fallback = function() end, -- arbitrary fallback function
    }
    vim.keymap.set({ '', 'i' }, '<c-left>', '<cmd>:CybuPrev<cr>')
    vim.keymap.set({ '', 'i' }, '<c-right>', '<cmd>:CybuNext<cr>')
end

return M
