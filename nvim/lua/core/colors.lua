require('tokyonight').setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    style = 'dark', -- The theme comes in three styles, `storm`, a darker variant `night` and `day`
    transparent = false, -- Enable this to disable setting the background color
    terminal_colors = false, -- Configure the colors used when opening a `:terminal` in Neovim
    styles = { -- Value is any valid attr-list value `:help attr-list`
        comments = 'NONE',
        keywords = { bold = true, italic = false },
        functions = 'NONE',
        variables = 'NONE',
        -- Background styles. Can be "dark", "transparent" or "normal"
        sidebars = 'normal', -- style for sidebars, see below
        floats = 'transparent', -- style for floating windows
    },
    sidebars = { -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
        'TelescopePrompt',
        'TelescopePicker',
        'Trouble',
        'Mason',
        'mason',
        'LspInfo',
        'lspinfo',
    },
    day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
    hide_inactive_statusline = true, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
    dim_inactive = false, -- dims inactive windows
    lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold

    --- You can override specific color groups to use other groups or a hex color
    --- fucntion will be called with a ColorScheme table
    -- @param colors ColorScheme
    -- on_colors = function(colors) end,

    --- You can override specific highlights to use other groups or a hex color
    --- fucntion will be called with a Highlights and ColorScheme table
    -- @param highlights Highlights
    -- @param colors ColorScheme
    -- on_highlights = function(highlights, colors) end,
}

-- local function hl(name, val) vim.api.nvim_set_hl(0, name, val) end
-- hl('CmpItemAbbrDeprecated', { bg = nil, strikethrough = true, fg='#808080' } )
vim.cmd([[
    colorscheme tokyonight
    highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080
    highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6
    highlight! CmpItemAbbrMatchFuzzy guibg=NONE guifg=#569CD6
    hi Whitespace guibg=#364a82
    " hi FloatBorder guifg=#c0caf5
]])

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

return {
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
