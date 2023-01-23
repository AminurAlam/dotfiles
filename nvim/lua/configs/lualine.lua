local status, lualine = pcall(require, 'lualine')
if not status then return end

local color = {
    red = '#e06c75',
    purple = '#c678dd',
    blue = '#7aa2f7',
    green = '#98c379',
    grey = '#30354A',
}

local icons = require('core.icons')

local theme = {
    normal = {
        a = { fg = color.grey, bg = color.green, gui = 'bold' },
        b = { fg = color.green, bg = color.grey },
        c = { fg = '#a9b1d6', bg = nil },
    },
    insert = {
        a = { fg = color.grey, bg = color.blue, gui = 'bold' },
        b = { fg = color.blue, bg = color.grey },
    },
    visual = {
        a = { fg = color.grey, bg = color.purple, gui = 'bold' },
        b = { fg = color.purple, bg = color.grey },
    },
    command = {
        a = { fg = color.grey, bg = color.red, gui = 'bold' },
        b = { fg = color.red, bg = color.grey },
    },
    replace = {
        a = { fg = color.grey, bg = color.red, gui = 'bold' },
        b = { fg = color.red, bg = color.grey },
    },
    terminal = {
        a = { fg = color.grey, bg = '#56b6c2', gui = 'bold' },
    },
}

local sections = {
    lualine_a = { { 'mode' } },
    lualine_b = {
        {
            'filename',
            filestatus = false,
            symbols = { modified = icons.ui.Pencil, readonly = icons.ui.Lock, unnamed = '…' },
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
    lualine_c = { { 'diagnostics', update_in_insert = true } },
    lualine_x = {
        -- { function() return '%S' end },
        { 'searchcount' },
        { function() return vim.fn.reg_recording() == '' and '' or '@' .. vim.fn.reg_recording() end },
    },
    lualine_y = { { 'progress' } },
    lualine_z = {
        { 'filetype' },
        { 'fileformat', symbols = { unix = '' } },
    },
}

local extensions = {
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
}

lualine.setup {
    options = {
        icons_enabled = true,
        theme = theme,
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
            statusline = { 'alpha', 'packer', 'TelescopePrompt' },
            winbar = {},
        },
        globalstatus = true,
    },
    sections = sections,
    inactive_sections = {},
    extensions = extensions,
}
