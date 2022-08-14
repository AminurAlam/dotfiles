-- https://vonheikemen.github.io/devlog/tools/configuring-neovim-using-lua/

--[[ sourcing ]]
require('plugins')  -- lua/plugins.lua
require('remaps')  -- lua/remaps.lua
require('settings') -- lua/settings.lua
require('setups') --lua/setups.lua



vim.cmd [[
    set colorcolumn=80
    set guicursor=n-v-c-i-ci-ve-r-cr-o-a-sm:hor1,v:block
	colorscheme tokyonight

    " gray
    highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080
    " blue
    highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6
    highlight! CmpItemAbbrMatchFuzzy guibg=NONE guifg=#569CD6
    " light blue
    highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE
    highlight! CmpItemKindInterface guibg=NONE guifg=#9CDCFE
    highlight! CmpItemKindText guibg=NONE guifg=#9CDCFE
    " pink
    highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0
    highlight! CmpItemKindMethod guibg=NONE guifg=#C586C0
    " front
    highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4
    highlight! CmpItemKindProperty guibg=NONE guifg=#D4D4D4
    highlight! CmpItemKindUnit guibg=NONE guifg=#D4D4D4
]]
