local g = vim.g
g.tokyonight_style = 'storm'
g.tokyonight_terminal_colors = true
g.tokyonight_italic_comments = false
g.tokyonight_italic_keywords = false
g.tokyonight_italic_functions = false
g.tokyonight_italic_variables = false
g.tokyonight_transparent = false
g.tokyonight_hide_inactive_statusline = true
g.tokyonight_sidebars = {
    'TelescopePrompt',
    'TelescopePicker',
    'Trouble',
    'Mason',
    'mason',
    'LspInfo',
    'lspinfo',
}
g.tokyonight_transparent_sidebar = true
g.tokyonight_dark_sidebar = false
g.tokyonight_dark_float = false

vim.cmd([[
    highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080
    highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6
    highlight! CmpItemAbbrMatchFuzzy guibg=NONE guifg=#569CD6
    colorscheme tokyonight
]])
