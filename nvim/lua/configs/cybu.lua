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
        highlights = { -- see highlights via :highlight
            -- current_buffer = "CybuFocus",       -- current / selected buffer
            -- adjacent_buffers = "CybuAdjacent",  -- buffers not in focus
            -- background = "CybuBackground",      -- window background
            -- border = "CybuBorder",              -- border of the window
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
