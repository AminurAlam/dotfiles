local status, lualine = pcall(require, 'lualine')
if not status then return end

local color = {
    yellow = '#e0af68',
    purple = '#c678dd',
    blue = '#7aa2f7',
    green = '#98c379',
    grey = '#3b4261',
    black = '#1D202F',
}

local icons = require('core.icons')

lualine.setup {
    options = {
        icons_enabled = true,
        theme = {
            normal = {
                a = { fg = color.black, bg = color.green, gui = 'bold' },
                b = { fg = color.green, bg = color.grey },
                c = { fg = '#a9b1d6', bg = nil },
            },
            insert = {
                a = { fg = color.black, bg = color.blue, gui = 'bold' },
                b = { fg = color.blue, bg = color.grey },
            },
            visual = {
                a = { fg = color.black, bg = color.purple, gui = 'bold' },
                b = { fg = color.purple, bg = color.grey },
            },
            replace = {
                a = { fg = color.black, bg = color.yellow, gui = 'bold' },
                b = { fg = color.yellow, bg = color.grey },
            },
            terminal = {
                a = { fg = color.black, bg = '#56b6c2', gui = 'bold' },
            },
        },
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
            statusline = { 'alpha', 'packer', 'lspinfo', 'TelescopePrompt' },
            winbar = {},
        },
        globalstatus = true,
    },
    sections = {
        lualine_a = { { 'mode' } },
        lualine_b = {
            {
                'filename',
                filestatus = false,
                symbols = {
                    modified = icons.ui.Pencil,
                    readonly = icons.ui.Lock,
                    unnamed = icons.documents.File,
                    alternate_file = icons.documents.Files,
                },
            },
            {
                function() return vim.fn.search([[\s\+$]], 'nwc') ~= 0 and '␣ ' or '' end,
                padding = 0,
            },
            {
                function()
                    local filepath = vim.fn.expand('%:p:h')
                    local gitdir = vim.fn.finddir('.git', filepath .. ';')
                    return (gitdir and #gitdir > 0 and #gitdir < #filepath) and ' ' or ''
                end,
                padding = 0,
            },
        },
        lualine_c = {
            { 'diagnostics', update_in_insert = true },
        },
        lualine_x = {
            { 'searchcount' },
        },
        lualine_y = {
            { 'progress' },
        },
        lualine_z = {
            {
                function() return ' ' .. vim.bo.filetype end,
                padding = 0,
            },
            { 'fileformat' },
        },
    },
    inactive_sections = {},
    extensions = {
        'man',
        'neo-tree',
        'nerdtree',
        'toggleterm',
        {
            filetypes = { 'Trouble' },
            sections = { lualine_a = { function() return 'Trouble' end } },
        },
        {
            filetypes = { 'help' },
            sections = {
                lualine_a = { function() return vim.fn.expand('%:t') end },
                lualine_x = { 'searchcount' },
                lualine_z = { 'progress' },
            },
        },
    },
}
