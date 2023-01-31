local autocmd = vim.api.nvim_create_autocmd
-- local augroup = vim.api.nvim_create_augroup

local nmap = function(lhs, rhs, opts) vim.keymap.set('n', lhs, rhs, opts or { buffer = true, silent = true }) end
local set = vim.opt_local

-- stylua: ignore
autocmd({ 'FileType' }, {
    desc = 'exit by pressing q or <esc>',
    pattern = { 'qf', 'help', 'lspinfo', 'DressingSelect', 'Trouble' },
    callback = function()
        nmap('q', '<cmd>:close<cr>')
        nmap('<esc>', function() vim.cmd(vim.v.hlsearch == 1 and 'nohlsearch' or 'close') end)
        set.buflisted = false
    end,
})

autocmd({ 'TermOpen', 'TermEnter' }, {
    callback = function()
        set.colorcolumn = ''
        set.signcolumn = 'no'
        set.statuscolumn = ''
    end,
})

autocmd({ 'FileType', 'BufNewFile' }, {
    desc = 'reading mode for some filetypes',
    pattern = { 'alpha', 'man', 'text', 'markdown', 'gitcommit', 'log', 'Trouble' },
    callback = function()
        set.wrap = true
        set.linebreak = true
        set.statuscolumn = vim.g.stc_symbol
    end,
})

-- https://github.com/mong8se/actually.nvim
vim.api.nvim_create_autocmd('BufNewFile', {
    desc = 'when tab completion doesnt work',
    pattern = '*',
    callback = function(details)
        if vim.fn.filereadable(details.file) == 1 then return end
        local possibles = vim.split(vim.fn.glob(details.file .. '*'), '\n', { trimempty = true })

        if #possibles > 0 then
            vim.ui.select(possibles, { prompt = 'You probably meant:' }, function(choice)
                if choice then vim.cmd('edit ' .. vim.fn.fnameescape(choice)) end
            end)
        end
        vim.g.did_load_filetypes = 1
    end,
})

autocmd({ 'TermOpen' }, {
    callback = function()
        set.number = false
        set.relativenumber = false
    end,
})

-- https://github.com/mawkler/modicator.nvim
vim.api.nvim_create_autocmd('ModeChanged', {
    desc = 'change cursor line number based on mode',
    callback = function()
        local modes = {
            ['i'] = '#7aa2f7',
            ['c'] = '#e06c75',
            ['cv'] = '#e06c75',
            ['ce'] = '#e06c75',
            ['R'] = '#e06c75',
            ['v'] = '#c678dd',
            ['V'] = '#c678dd',
            ['\22'] = '#c678dd',
            ['s'] = '#c678dd',
            ['S'] = '#c678dd',
            ['\19'] = '#c678dd',
        }
        vim.api.nvim_set_hl(0, 'CursorLineNr', {
            foreground = modes[vim.api.nvim_get_mode().mode] or '#98c379',
        })
    end,
})

autocmd('BufReadPost', {
    desc = 'restore cursor position',
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local lcount = vim.api.nvim_buf_line_count(0)
        if mark[1] > 0 and mark[1] <= lcount then pcall(vim.api.nvim_win_set_cursor, 0, mark) end
    end,
})

autocmd('BufWritePre', {
    desc = 'automatically create missing directories when saving files',
    callback = function(event)
        local file = vim.loop.fs_realpath(event.match) or event.match

        vim.fn.mkdir(vim.fn.fnamemodify(file, ':p:h'), 'p')
        local backup = vim.fn.fnamemodify(file, ':p:~:h')
        backup = backup:gsub('[/\\]', '%%')
        vim.go.backupext = backup
    end,
})

autocmd({ 'TextYankPost' }, {
    callback = function() vim.highlight.on_yank { higroup = 'IncSearch', timeout = 300 } end,
})

autocmd({ 'FileType' }, {
    pattern = 'cuesheet',
    callback = function() vim.opt.syntax = 'cuesheet' end,
})
autocmd('VimLeave', {
    callback = function() vim.opt.guicursor = 'a:hor25' end,
})

-- https://github.com/ibhagwan/smartyank.nvim
-- autocmd({ "TextYankPost" }, {
--     desc = 'stop certain stuff from going to clipboard',
--     callback = function()
--         local ok, yank_data = pcall(vim.fn.getreg, "0")
--         if ok and #yank_data > 1 then
--             pcall(vim.fn.setreg, "+", yank_data)
--         end
--     end
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
