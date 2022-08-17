local M = {}

function M.setup(config)
    require('plugins').load(config)
    -- require('settings').setup(config)
end

return M
