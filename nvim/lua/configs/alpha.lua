local alpha = require('alpha')
local startify = require('alpha.themes.startify')

startify.section.top_buttons.val = {
    startify.button('i', '  New file', ':ene <BAR> startinsert <CR>'),
}

startify.section.mru_cwd.val = { { type = 'padding', val = 0 } }
alpha.setup(startify.config)
