local hl = function(name, val) vim.api.nvim_set_hl(0, name, val) end

hl('@function.call.fish', { link = 'Special' })
hl('@variable.fish', { link = 'Constant' })
