--[[ local lsp_progress = {
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
} --]]

local whitespace = {
    function() return vim.fn.search([[\s\+$]], 'nwc') ~= 0 and '␣ ' or '' end,
    padding = 0,
}

local filename = {
    'filename',
    filestatus = false,
    symbols = {
        modified = '', -- ' ●',
        readonly = '',
        unnamed = '[new]',
        newfile = '[new]',
        alternate_file = '#',
        directory = 'D',
    },
}

local diagnostics = {
    'diagnostics',
    update_in_insert = true,
    symbols = {
        error = require('core.icons').diagnostics.BoldError .. ' ',
        warn = require('core.icons').diagnostics.BoldWarning .. ' ',
        info = require('core.icons').diagnostics.BoldInformation .. ' ',
        hint = require('core.icons').diagnostics.BoldHint .. ' ',
    },
}

local check_git = {
    function()
        local root_dir = vim.fn.expand('%:p:h')
        while root_dir do
            local git_path = root_dir .. '/.git'
            if vim.loop.fs_stat(git_path) then return ' ' end
            root_dir = root_dir:match('(.*)' .. '/.-')
        end
        return ''
    end,
    padding = 0,
}

local trouble = { filetypes = { 'Trouble' },
    sections = { lualine_a = { function() return 'Trouble' end } }
}
local help = { filetypes = { 'help' },
    sections = {
        lualine_a = { function() return vim.fn.expand('%:t') end },
        lualine_z = { 'progress' }
    }
}

require('lualine').setup {
    options = {
        icons_enabled = true,
        theme = require('core.colors'),
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
            statusline = { 'alpha', 'packer', 'lspinfo', 'TelescopePrompt' },
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
        lualine_b = { filename, check_git, whitespace },
        lualine_c = { diagnostics },
        lualine_x = { { 'searchcount' } },
        lualine_y = { { 'progress' } },
        lualine_z = { { 'filetype', padding = 1 } },
    },
    inactive_sections = {},
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {
        'aerial',
        'chadtree',
        'fern',
        'fugitive',
        'fzf',
        'man',
        'mundo',
        'neo-tree',
        'nerdtree',
        'nvim-dap-ui',
        'nvim-tree',
        'quickfix',
        'symbols-outline',
        'toggleterm',
        trouble,
        help,
    },
}
