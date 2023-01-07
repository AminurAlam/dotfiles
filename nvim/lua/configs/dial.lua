local status, dial = pcall(require, 'dial.config')
if not status then return end

local augend = require('dial.augend')
require('dial.config').augends:register_group {
    default = {
        augend.integer.alias.decimal, -- nonnegative decimal number (0, 1, 2, 3, ...)
        augend.constant.alias.bool, -- boolean value (true <-> false)
        augend.constant.new {
            elements = { 'and', 'or' },
            word = true, -- if false, "sand" is incremented into "sor", "doctor" into "doctand", etc.
            cyclic = true, -- "or" is incremented into "and".
        },
        augend.constant.new {
            elements = { '&&', '||' },
            word = false,
            cyclic = true,
        },
        augend.constant.new {
            elements = { 'true', 'false' },
            word = true,
            cyclic = true,
        },
    },
}

vim.keymap.set('n', '+', require('dial.map').inc_normal())
vim.keymap.set('n', '-', require('dial.map').dec_normal())
