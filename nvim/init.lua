pcall(require, 'impatient')

require('options')
require('mappings')
require('autocommands')
require('plugins')
require('snippets')
require('colors')

local function load_plugins()
    require('configs.alpha')
    require('configs.cybu')
    require('configs.fold')
    require('configs.lsp')
    require('configs.lualine')
    require('configs.noice')
    require('configs.notify')
    require('configs.other')
    require('configs.telescope')
    require('configs.toggleterm')
    require('configs.treesitter')
    require('configs.trouble')
end

load_plugins()

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
    function s:HelpCurwin(subject) abort
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

    command -bar -nargs=? -complete=help HelpCurwin execute s:HelpCurwin(<q-args>)
    let s:did_open_help = v:false
]])
