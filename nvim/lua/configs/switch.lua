local status, nvim_toggler = pcall(require, 'nvim-toggler')
if not status then return end

-- init.lua
nvim_toggler.setup {
    inverses = {
        -- ['vim'] = 'emacs',
        -- ['true'] = 'false',
        -- ['True'] = 'False',
        -- ['='] = '==',
        -- ['and'] = 'or',
        -- ['&&'] = '||',
        -- ['<='] = '>=',
        -- ['+'] = '-',
    },
    remove_default_keybinds = false,
}
