require('tokyonight').setup {
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
    day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
    hide_inactive_statusline = true, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
    dim_inactive = false, -- dims inactive windows
    lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold
}

vim.cmd.colorscheme { 'tokyonight' }

local hl = function(name, val) vim.api.nvim_set_hl(0, name, val) end

hl('CmpItemAbbrDeprecated', { bg = nil, strikethrough = true, fg = '#808080' })
hl('CmpItemAbbrMatch', { bg = nil, fg = '#569CD6' })
hl('CmpItemAbbrMatchFuzzy', { bg = nil, fg = '#569CD6' })
hl('Whitespace', { bg = '#364a82' })
