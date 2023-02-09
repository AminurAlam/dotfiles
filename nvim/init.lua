_G.__luacache_config = {
    chunks = { enable = true, path = vim.fn.stdpath('data') .. '/luacache_chunks' },
    modpaths = { enable = true, path = vim.fn.stdpath('data') .. '/luacache_modpaths' },
}

local status, impatient = pcall(require, 'impatient')
if status then impatient.enable_profile() end

local g = vim.g

g.mapleader = ' '
g.maplocalleader = ' '
g.stc_number = '%=%{ v:virtnum ? " " : v:lnum }'
g.stc_symbol = '%{ v:virtnum ? "…" : ( v:relnum ? "│" : "❯" ) }'
g.do_filetype_lua = 1
g.editorconfig = false
g.netrw_banner = 0
g.netrw_hide = 0
g.netrw_liststyle = 3

-- disabling plugins
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
require('core.lazy') -- require('core.packer')
require('core.options')
require('core.mappings')
require('core.autocommands')

vim.diagnostic.config {
    underline = { severity = vim.diagnostic.severity.ERROR },
    virtual_text = { spacing = 2, prefix = '' },
    signs = false,
    float = { border = 'rounded' },
    update_in_insert = true,
    severity_sort = true,
}

vim.filetype.add {
    pattern = {
        ['.*%.log'] = 'log',
        ['.*%.cue'] = 'cuesheet',
        ['.*%.note'] = 'note',
    },
}

vim.cmd.colorscheme { 'tokyonight' }

local hl = function(name, val) vim.api.nvim_set_hl(0, name, val) end

hl('Whitespace', { bg = '#364a82' })
hl('CursorLineNr', { fg = '#98c379' })
hl('LineNr', { fg = '#3b4261' })
