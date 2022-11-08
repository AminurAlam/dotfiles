pcall(require, 'impatient')

local load_main = function()
    require('options')
    require('plugins')
    require('mappings')
    require('autocommands')
    require('colors')
end

local load_plugins = function()
    pcall(require, 'configs.ala')
    pcall(require, 'configs.cybu')
    pcall(require, 'configs.fold')
    pcall(require, 'configs.lsp')
    pcall(require, 'configs.lualine')
    pcall(require, 'configs.notify')
    pcall(require, 'configs.other')
    pcall(require, 'configs.telescope')
    pcall(require, 'configs.toggleterm')
    pcall(require, 'configs.treesitter')
    pcall(require, 'configs.trouble')
end

if not pcall(load_main) then
    vim.notify('main files couldnt be loaded')
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
