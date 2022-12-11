_G.__luacache_config = {
    chunks = { enable = true, path = vim.fn.stdpath('data') .. '/luacache_chunks' },
    modpaths = { enable = true, path = vim.fn.stdpath('data') .. '/luacache_modpaths' },
}

local status, impatient = pcall(require, 'impatient')
if status then impatient.enable_profile() end
local g = vim.g

g.netrw_banner = 0
g.netrw_liststyle = 3

require('core.plugins')
require('core.options')
require('core.mappings')
require('core.autocommands')
require('core.colors')

require('configs.alpha')
require('configs.cybu')
-- require('configs.fold')
require('configs.lsp')
require('configs.lualine')
-- require('configs.notify')
require('configs.other')
require('configs.telescope')
-- require('configs.toggleterm')
require('configs.treesitter')
require('configs.trouble')
-- require('configs.yanky')

vim.diagnostic.config {
    underline = { severity = vim.diagnostic.severity.ERROR },
    virtual_text = { spacing = 4 },
    float = { border = 'rounded' },
    signs = false,
    update_in_insert = true,
    severity_sort = true,
}
