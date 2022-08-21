require('lualine').setup({
    options = {theme = 'onedark'},
    sections = {
        lualine_a = {{'mode', padding = 1}},
        lualine_b = {{'branch'}},
        lualine_c = {{'filename'}},
        lualine_x = {{'diagnostics', update_in_insert = true}},
        lualine_y = {{'progress'}},
        lualine_z = {{'filetype', padding = 1}}
    },
})

