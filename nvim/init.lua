local g = vim.g

g.netrw_banner = 0
g.netrw_hide = 0
g.netrw_liststyle = 3

g.mapleader = ' '

g.loaded_gzip = 1
g.loaded_zip = 1
g.loaded_zipPlugin = 1
g.loaded_tar = 1
g.loaded_tarPlugin = 1

g.loaded_getscript = 1
g.loaded_getscriptPlugin = 1
g.loaded_vimball = 1
g.loaded_vimballPlugin = 1
g.loaded_2html_plugin = 1

g.loaded_matchit = 1
g.loaded_matchparen = 1
g.loaded_logiPat = 1
g.loaded_rrhelper = 1

-- [[ core ]]
require('core.packer') -- packer.nvim
-- require('core.lazy')  -- lazy.nvim
require('core.options')
require('core.mappings')
require('core.autocommands')
require('core.colors')

-- [[ plugin configs ]]
require('configs.alpha')
require('configs.cmp')
require('configs.cybu')
require('configs.dial')
require('configs.gitsigns')
require('configs.lsp')
require('configs.lualine')
require('configs.notify')
require('configs.telescope')
require('configs.treesitter')
require('configs.trouble')

local function setup_plugins()
    require('Comment').setup {}
    require('neoscroll').setup {}
    require('nvim-autopairs').setup {}
    require('nvim-surround').setup {}
    require('indent_blankline').setup { show_first_indent_level = false }
end

if not pcall(setup_plugins) then
    vim.notify('some plugins are not loaded')
end

vim.diagnostic.config {
    underline = { severity = vim.diagnostic.severity.ERROR },
    virtual_text = { spacing = 2, prefix = '' },
    signs = false,
    float = { border = 'rounded' },
    update_in_insert = true,
    severity_sort = true,
}
