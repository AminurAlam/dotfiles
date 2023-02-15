local status, alpha = pcall(require, 'alpha')
if not status then return end

local icons = require('core.icons')
local file_icons = require('nvim-web-devicons')

local function get_extension(fn)
    local match = fn:match('^.+(%..+)$')
    local ext = ''
    if match ~= nil then ext = match:sub(2) end
    return ext
end

local button = function(sc, txt, keybind, icon_hl)
    icon_hl = icon_hl or 'Directory'
    return {
        type = 'button',
        val = txt,
        on_press = function()
            local key = vim.api.nvim_replace_termcodes(keybind or sc .. '<Ignore>', true, false, true)
            vim.api.nvim_feedkeys(key, 't', false)
        end,
        opts = {
            position = 'center',
            shortcut = '[' .. sc .. ']',
            cursor = 5,
            width = 45,
            align_shortcut = 'right',
            hl = { { icon_hl, 0, 3 }, { 'Directory', 3, 47 } },
            hl_shortcut = { { 'Number', 1, 2 } },
            keymap = { 'n', sc, keybind, { noremap = true, silent = true, nowait = true } },
        },
    }
end

local buttons = {
    button('f', icons.documents.Files .. '  Find file', '<cmd>:Telescope find_files<cr>'),
    button('g', icons.type.String .. '  Find word', '<cmd>:Telescope live_grep<cr>'),
    button('h', '?  Find help', '<cmd>:Telescope help_tags<cr>'),
    button('i', icons.ui.Pencil .. '  New file', '<cmd>:enew <BAR> startinsert<cr>'),
    button('u', icons.ui.Rotate .. '  Update plugins', '<cmd>:Lazy update<cr>', 'String'),
    button('q', icons.ui.RoundClose .. '  Quit', '<cmd>:qa<cr>', 'Error'),
}

local of_button = function()
    local oldfiles = {}
    -- stylua: ignore
    for _, filename in pairs(vim.v.oldfiles) do
        if vim.fn.filereadable(filename) == 0 then goto continue end
        local len = #oldfiles + 1
        if len == 6 then break end
        local icon, hl = file_icons.get_icon(filename, get_extension(filename), { default = true })
        filename = vim.fn.fnamemodify(filename, ':~')
        oldfiles[len] = button(
            len .. '',
            icon .. '  ' .. string.gsub(
                filename,
                '/(%.?.)[^/]*',
                '/%1',
                vim.fn.count(filename, '/') - 1
            ),
            '<cmd>e ' .. filename .. ' <cr>',
            hl
        );
        ::continue::
    end
    return oldfiles
end

local details = function()
    local v = vim.version()
    local filename = vim.fn.fnamemodify(vim.fn.getcwd(), ':~')
    filename = string.gsub(filename, '/(%.?.)[^/]*', '/%1', vim.fn.count(filename, '/') - 1)
    return string.format('%s | v%d.%d.%d', filename, v.major, v.minor, v.patch)
end

alpha.setup {
    layout = {
        { type = 'padding', val = 3 },
        {
            type = 'text',
            opts = { position = 'center', hl = 'Type' },
            val = {
                [[                               __                ]],
                [[  ___      __    ___   __  __ /\_\    ___ ___    ]],
                [[/' _ `\  /'__`\ / __`\/\ \/\ \\/\ \ /' __` __`\  ]],
                [[/\ \/\ \/\  __//\ \L\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
                [[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
                [[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
            },
        },
        { type = 'padding', val = 1 },
        { type = 'text', val = details, opts = { position = 'center' } },
        { type = 'padding', val = 2 },
        { type = 'group', val = buttons, opts = { spacing = 0 } },
        { type = 'padding', val = 2 },
        { type = 'group', val = of_button },
    },
}
