local status, notify = pcall(require, 'notify')
if not status then return end

-- notify.config({
--     timeout = 2,
--     max_width = 40,
--     stages = ''
-- })

vim.notify = notify
