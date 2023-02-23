local M = { 'goolord/alpha-nvim', dependencies = { 'nvim-tree/nvim-web-devicons' } }

M.config = function()
    local utils = require('core.utils')
    local dev_icon = require('nvim-web-devicons')

    local art = {
        [[                               __                ]],
        [[  ___      __    ___   __  __ /\_\    ___ ___    ]],
        [[/' _ `\  /'__`\ / __`\/\ \/\ \\/\ \ /' __` __`\  ]],
        [[/\ \/\ \/\  __//\ \L\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
        [[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
        [[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
    }

    local details = function()
        local v = vim.version()
        return string.format(
            '%s | %dms | v%s-%s',
            utils.fish_path(vim.fn.getcwd()),
            require('lazy').stats().startuptime,
            v.major .. '.' .. v.minor .. '.' .. v.patch,
            (v.prerelease and 'dev' or 'stable'))
    end

    local button = function(sc, text, keybind, icon_hl)
        return {
            type = 'button',
            val = text,
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
                hl = { { icon_hl or 'Normal', 0, 3 }, { 'Directory', 3, 47 } },
                hl_shortcut = { { 'Number', 1, 2 } },
                keymap = { 'n', sc, keybind, { noremap = true, silent = true, nowait = true } },
            },
        }
    end

    local oldfiles = function()
        local of_buttons = {}
        -- stylua: ignore
        for _, filename in pairs(vim.v.oldfiles) do
            if vim.fn.filereadable(filename) == 0 then goto continue end
            local len = #of_buttons + 1
            if len == 6 then break end
            local icon, hl = dev_icon.get_icon(utils.rsplit(filename, '/'), utils.rsplit(filename, '\\.'))
            filename = vim.fn.fnamemodify(filename, ':~')
            table.insert(of_buttons, button(
                tostring(len),
                (icon or '') .. '  ' .. utils.fish_path(filename),
                '<cmd>e ' .. filename .. ' <cr>',
                hl
            ));
            ::continue::
        end
        return of_buttons
    end

    local rep = ' | AlphaRedraw | Telescope find_files hidden=true<cr>'

    require('alpha').setup {
        layout = {
            { type = 'padding', val = 3 },
            { type = 'text',    val = art,     opts = { position = 'center', hl = 'Type' } },
            { type = 'padding', val = 1 },
            { type = 'text',    val = details, opts = { position = 'center' } },
            { type = 'padding', val = 1 },
            button('f', utils.icons.documents.Files .. '  Find file', '<cmd>Telescope find_files hidden=true<cr>'),
            button('g', utils.icons.type.String .. '  Find word', '<cmd>Telescope live_grep<cr>'),
            button('h', '?  Find help', '<cmd>Telescope help_tags<cr>'),
            button('i', utils.icons.ui.Pencil .. '  New file', '<cmd>enew <BAR> startinsert<cr>'),
            button('u', utils.icons.ui.Rotate .. '  Update plugins', '<cmd>Lazy update<cr>'),
            button('q', utils.icons.ui.RoundClose .. '  Quit', '<cmd>qa<cr>'),
            { type = 'padding', val = 1 },
            { type = 'group',   val = oldfiles },
            { type = 'padding', val = 1 },
            button('6', '  /s/m/notes/', '<cmd>cd /sdcard/main/notes/' .. rep),
            button('7', '  ~/r/musicbrainzpy/', '<cmd>cd ~/repos/musicbrainzpy/ ' .. rep),
            button('8', '  ~/.c/nvim/', '<cmd>cd ~/.config/nvim/' .. rep),
            button('9', '  ~/.c/fish/', '<cmd>cd ~/.config/fish/' .. rep),
        },
    }
end

return M
