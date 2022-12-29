local status, tokyonight = pcall(require, 'tokyonight')
if not status then return end

tokyonight.setup {
    style = 'storm', -- The theme comes in three styles, `storm`, a darker variant `night` and `day`
    transparent = false, -- Enable this to disable setting the background color
    terminal_colors = false, -- Configure the colors used when opening a `:terminal` in Neovim
    styles = { -- Value is any valid attr-list value `:help attr-list`
        comments = { italic = false },
        keywords = { italic = false, bold = true },
        functions = { italic = false },
        variables = { italic = false },
        -- Background styles. Can be "dark", "transparent" or "normal"
        sidebars = 'normal', -- style for sidebars, see below
        floats = 'transparent', -- style for floating windows
    },
    hide_inactive_statusline = true, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
    dim_inactive = false, -- dims inactive windows
}

vim.cmd.colorscheme { 'tokyonight' }

local hl = function(name, val) vim.api.nvim_set_hl(0, name, val) end

hl('Whitespace', { bg = '#364a82' })

-- vim.cmd([[
--     " gray
--     highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080
--     " blue
--     highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6
--     highlight! link CmpItemAbbrMatchFuzzy CmpItemAbbrMatch
--     " light blue
--     highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE
--     highlight! link CmpItemKindInterface CmpItemKindVariable
--     highlight! link CmpItemKindText CmpItemKindVariable
--     " pink
--     highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0
--     highlight! link CmpItemKindMethod CmpItemKindFunction
--     " front
--     highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4
--     highlight! link CmpItemKindProperty CmpItemKindKeyword
--     highlight! link CmpItemKindUnit CmpItemKindKeyword
-- ]])
