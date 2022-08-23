-- init.lua
require('nvim-toggler').setup({
    inverses = {
        ['vim'] = 'emacs',
        ['true'] = 'false',
        ['True'] = 'False',
        ['='] = '==',
        ['and'] = 'or',
        ['&&'] = '||',
        ['<='] = '>=',
        ['+'] = '-',
    },
    remove_default_keybinds = false,
})
