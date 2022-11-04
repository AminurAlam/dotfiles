local icons = require('icons')
local v = vim.version()
local function button(sc, txt, keybind, keybind_opts)
    local opts = {
        position = 'center',
        shortcut = sc,
        cursor = 5,
        width = 50,
        align_shortcut = 'right',
        hl = 'Directory',
        hl_shortcut = 'Number',
    }
    if keybind then
        keybind_opts = vim.F.if_nil(keybind_opts, { noremap = true, silent = true, nowait = true })
        opts.keymap = { 'n', sc, keybind, keybind_opts }
    end

    local function on_press()
        local key = vim.api.nvim_replace_termcodes(keybind or sc .. '<Ignore>', true, false, true)
        vim.api.nvim_feedkeys(key, 't', false)
    end

    return {
        type = 'button',
        val = txt,
        on_press = on_press,
        opts = opts,
    }
end
local buttons = {
    button('f', icons.documents.Files .. '  Find file', '<cmd>:Telescope find_files<cr>'),
    button('g', icons.type.String .. '  Find word', '<cmd>:Telescope live_grep<cr>'),
    button('h', '?  Find help', '<cmd>:Telescope help_tags<cr>'),
    button('t', icons.documents.OpenFolder .. '  Explore directory', '<cmd>:Explore<cr>'),
    button('i', icons.ui.Pencil .. '  New file', '<cmd>:ene <BAR> startinsert<cr>'),
    button('u', icons.ui.Rotate .. '  Update plugins', '<cmd>:PackerUpdate<cr>'),
    button('q', icons.ui.RoundClose .. '  Quit', '<cmd>:qa<cr>'),
}

require('alpha').setup {
    layout = {
        { type = 'padding', val = 2 },
        {
            type = 'text',
            val = {
                [[                               __                ]],
                [[  ___      __    ___   __  __ /\_\    ___ ___    ]],
                [[/' _ `\  /'__`\ / __`\/\ \/\ \\/\ \ /' __` __`\  ]],
                [[/\ \/\ \/\  __//\ \L\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
                [[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
                [[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
            },
            opts = { position = 'center', hl = 'Type' },
        },
        { type = 'padding', val = 1 },
        {
            type = 'text',
            val = string.format('v%d.%d.%d', v.major, v.minor, v.patch),
            opts = { position = 'center' },
        },
        { type = 'padding', val = 2 },
        {
            type = 'group',
            val = buttons,
            opts = { spacing = 0 },
        },
        { type = 'padding', val = 2 },
        -- {
        --   type = "group",
        --   val = mru,
        --   opts = { spacing = 0 },
        -- },
        { type = 'padding', val = 3 },
        {
            type = 'text',
            val = require('alpha.fortune')(),
            opts = { hl = 'AlphaQuote', position = 'center' },
        },
    },
    --[[     opts = {
        setup = function()
            vim.api.nvim_create_autocmd('User', {
                pattern = 'AlphaReady',
                desc = 'Disable status and tabline for alpha',
                callback = function()
                    vim.go.laststatus = 0
                    vim.opt.showtabline = 0
                end,
            })
            vim.api.nvim_create_autocmd('BufUnload', {
                buffer = 0,
                desc = 'Enable status and tabline after alpha',
                callback = function()
                    vim.go.laststatus = 3
                    vim.opt.showtabline = 2
                end,
            })
        end,
        margin = 5,
    }, ]]
}
