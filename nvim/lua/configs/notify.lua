require('notify').setup {
    level = 2,
    timeout = 5000,
    stages = 'slide',
    background_colour = 'Normal',
    render = 'minimal',
    minimum_width = 30,
    fps = 30,
    top_down = true,
}

vim.notify = require('notify')
