local M = { 'lukas-reineke/indent-blankline.nvim' }

function M.setup()
    require('indent_blankline').setup {
        show_first_indent_level = false,
    }
end

return M
