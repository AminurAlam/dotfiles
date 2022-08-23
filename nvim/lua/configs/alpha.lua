local alpha = require('alpha')
local startify = require('alpha.themes.startify')

startify.section.mru_cwd.val = { {
    type = 'padding',
    val = 0,
} }
alpha.setup(startify.config)
