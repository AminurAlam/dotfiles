local color = {
    yellow = '#e0af68',
    purple = '#c678dd',
    blue = '#7aa2f7',
    green = '#98c379',
    grey = '#3b4261',
    red = '#f7768e',
    white = '#a9b1d6',
    black = '#1D202F',
}
local theme = {
    normal = {
        a = { fg = color.black, bg = color.green, gui = 'bold' },
        b = { fg = color.green, bg = color.grey },
        c = { fg = color.white, bg = nil },
    },
    insert = {
        a = { fg = color.black, bg = color.blue, gui = 'bold' },
        b = { fg = color.blue, bg = color.grey },
    },
    command = {
        a = { fg = color.black, bg = color.red, gui = 'bold' },
        b = { fg = color.white, bg = color.grey },
    },
    visual = {
        a = { fg = color.black, bg = color.purple, gui = 'bold' },
        b = { fg = color.purple, bg = color.grey },
    },
    terminal = {
        a = { fg = color.grey, bg = '#56b6c2', gui = 'bold' },
    },
    inactive = {
        a = { fg = color.blue, bg = '#1f2335', gui = 'bold' },
        b = { fg = color.grey, bg = '#1f2335' },
    },
    replace = {
        a = { fg = color.black, bg = color.yellow, gui = 'bold' },
        b = { fg = color.yellow, bg = color.grey },
    },
}

local function whitespace()
    return vim.fn.search([[\s\+$]], 'nwc') ~= 0 and '[ ]' or ''
end

local filename = {
    'filename',
    filestatus = false,
    symbols = {
        modified = ' ●',
        readonly = ' ',
        unnamed = '[nil]',
        newfile = '[new]',
        alternate_file = '#',
    },
}

local lsp_progress = {
    'lsp_progress',
    separators = {
        component = ' ',
        progress = '',
        message = { pre = '', post = '' },
        title = { pre = '', post = ' ' },
        lsp_client_name = { pre = '[', post = ']' },
        spinner = { pre = '', post = '' },
    },
    display_components = { { 'title', 'message' } },
    timer = {
        progress_enddelay = 500,
        spinner = 1000,
        lsp_client_name_enddelay = 1000,
    },
    message = { commenced = '…', completed = '✓' },
    max_message_length = 30,
}

require('lualine').setup {
    options = {
        icons_enabled = true,
        theme = theme,
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
            statusline = { 'alpha' },
            winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = true,
        refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
        },
    },
    sections = {
        lualine_a = { { 'mode', padding = 1 } },
        lualine_b = { filename },
        lualine_c = { { 'branch' }, { whitespace }, lsp_progress },
        lualine_x = { { 'diagnostics', update_in_insert = true } },
        lualine_y = { { 'progress' } },
        lualine_z = { { 'filetype', padding = 1 } },
    },
    inactive_sections = {},
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = { 'man', 'toggleterm' },
}
