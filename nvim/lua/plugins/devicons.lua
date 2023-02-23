return {
    'nvim-tree/nvim-web-devicons',
    config = function()
        require("nvim-web-devicons").set_icon {
            fish = { icon = "󰈺", color = "#89e051", cterm_color = "113", name = "fish" },
            note = { icon = "", color = "#519aba", cterm_color = "67", name = "note" },
            nim = { icon = "", color = "#f3d400", cterm_color = "67", name = "nim" },
        }
    end
}
