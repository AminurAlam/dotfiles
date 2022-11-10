_G.__luacache_config = {
  chunks = { enable = true, path = vim.fn.stdpath('data')..'/luacache_chunks' },
  modpaths = { enable = true, path = vim.fn.stdpath('data')..'/luacache_modpaths' }
}

local status, impatient = pcall(require, "impatient")
if status then impatient.enable_profile() end

require("core")
require('configs')

vim.g.tex_flavor = 'latex'
vim.diagnostic.config {
    underline = { severity = vim.diagnostic.severity.ERROR },
    virtual_text = { spacing = 4 },
    float = { border = 'rounded' },
    signs = false,
    update_in_insert = true,
    severity_sort = true,
}

vim.cmd([[
    function s:Help(subject) abort
        let mods = 'silent noautocmd keepalt'
        if !s:did_open_help
            execute mods .. ' help'
            execute mods .. ' helpclose'
            let s:did_open_help = v:true
        endif
        if !empty(getcompletion(a:subject, 'help'))
            execute mods .. ' edit ' .. &helpfile
            set buftype=help
        endif
        return 'help ' .. a:subject
    endfunction

    command -bar -nargs=? -complete=help Help execute s:Help(<q-args>)
    let s:did_open_help = v:false
]])
