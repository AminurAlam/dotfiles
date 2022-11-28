local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local set = vim.o

autocmd({ 'TextYankPost' }, {
    callback = function() vim.highlight.on_yank { higroup = 'IncSearch', timeout = 300 } end,
})

autocmd({ 'FileType' }, {
    pattern = { 'qf', 'help', 'lspinfo', 'DressingSelect', 'Trouble' },
    callback = function()
        vim.keymap.set('n', 'q', '<cmd>:close<cr>', { silent = true, buffer = true })
        vim.keymap.set('n', '<esc>', '<cmd>:close<cr>', { silent = true, buffer = true })
        set.buflisted = false -- vim.cmd 'set nobuflisted'
    end,
})

autocmd({ 'FileType' }, {
    pattern = { 'help', 'text', 'markdown' },
    callback = function()
        set.number = false
        set.relativenumber = false
        set.wrap = true
        set.colorcolumn = ''
        vim.opt.listchars = {
            tab = '  ',
            trail = ' ',
            extends = '…',
            precedes = '…',
            conceal = 'x',
        }
        vim.cmd('hi Whitespace guibg=NONE')
    end,
})

-- autocmd({ 'UserGettingBored' }, { callback = function() print('user is bored') end })
-- autocmd({ 'BufEnter' }, {
--     pattern = { '' },
--     callback = function()
--         local buf_ft = vim.bo.filetype
--         if buf_ft == '' or buf_ft == nil then
--             vim.cmd([[
--       nnoremap <silent> <buffer> q :close<CR>
--       nnoremap <silent> <buffer> <c-j> j<CR>
--       nnoremap <silent> <buffer> <c-k> k<CR>
--       set nobuflisted
--     ]])
--         end
--     end,
-- })
-- vim.api.nvim_create_autocmd({ 'FileType' }, {
--     pattern = { 'gitcommit', 'markdown' },
--     callback = function()
--         vim.opt_local.wrap = true
--         vim.opt_local.spell = true
--     end,
-- })
-- vim.api.nvim_create_autocmd({ 'FileType' }, {
--     pattern = { 'lir' },
--     callback = function()
--         vim.opt_local.number = false
--         vim.opt_local.relativenumber = false
--     end,
-- })
-- vim.cmd(
--     "autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif"
-- )
-- vim.api.nvim_create_autocmd({ 'VimResized' }, {
--     callback = function() vim.cmd('tabdo wincmd =') end,
-- })
-- vim.api.nvim_create_autocmd({ 'CmdWinEnter' }, {
--     callback = function() vim.cmd('quit') end,
-- })
-- vim.api.nvim_create_autocmd({ 'BufWinEnter' }, {
--     callback = function() vim.cmd('set formatoptions-=cro') end,
-- })
-- vim.api.nvim_create_autocmd({ 'VimEnter' }, {
--     callback = function() vim.cmd('hi link illuminatedWord LspReferenceText') end,
-- })
-- vim.api.nvim_create_autocmd({ 'BufWinEnter' }, {
--     pattern = { '*' },
--     callback = function() vim.cmd('checktime') end,
-- })
