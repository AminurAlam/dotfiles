_G.__luacache_config = {
    chunks = { enable = true, path = vim.fn.stdpath('data') .. '/luacache_chunks' },
    modpaths = { enable = true, path = vim.fn.stdpath('data') .. '/luacache_modpaths' },
}

local status, impatient = pcall(require, 'impatient')
if status then impatient.enable_profile() end

local g = vim.g

g.netrw_banner = 0
g.netrw_hide = 0
g.netrw_liststyle = 3
g.mapleader = ' '

require('core.plugins')
require('core.options')
require('core.mappings')
require('core.autocommands')
require('core.colors')

require('configs.alpha')
require('configs.cmp')
require('configs.cybu')
require('configs.lsp')
require('configs.lualine')
require('configs.other')
require('configs.telescope')
require('configs.treesitter')
require('configs.trouble')

vim.diagnostic.config {
    underline = { severity = vim.diagnostic.severity.ERROR },
    virtual_text = { spacing = 2, prefix = '' },
    signs = false,
    float = { border = 'rounded' },
    update_in_insert = true,
    severity_sort = true,
}
