_G.__luacache_config = {
    chunks = { enable = true, path = vim.fn.stdpath('data') .. '/luacache_chunks' },
    modpaths = { enable = true, path = vim.fn.stdpath('data') .. '/luacache_modpaths' },
}

local status, impatient = pcall(require, 'impatient')
if status then impatient.enable_profile() end

require('core')
require('configs')

vim.diagnostic.config {
    underline = { severity = vim.diagnostic.severity.ERROR },
    virtual_text = { spacing = 4 },
    float = { border = 'rounded' },
    signs = false,
    update_in_insert = true,
    severity_sort = true,
}
