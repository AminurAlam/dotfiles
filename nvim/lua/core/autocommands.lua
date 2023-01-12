-- local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

autocmd({ 'TextYankPost' }, {
    callback = function() vim.highlight.on_yank { higroup = 'IncSearch', timeout = 300 } end,
})

autocmd({ 'FileType' }, {
    pattern = { 'qf', 'help', 'lspinfo', 'DressingSelect', 'Trouble' },
    callback = function()
        vim.keymap.set('n', 'q', '<cmd>:close<cr>', { silent = true, buffer = true })
        vim.keymap.set('n', '<esc>', function()
            if vim.v.hlsearch == 1 then
                vim.cmd('nohlsearch')
            else
                vim.cmd('close')
            end
        end, { silent = true, buffer = true })
        vim.opt.buflisted = false
    end,
})
autocmd({ 'FileType' }, {
    pattern = 'cuesheet',
    callback = function() vim.opt.syntax = 'cuesheet' end,
})

autocmd({ 'FileType' }, {
    pattern = { 'help', 'text', 'markdown', 'gitcommit', 'conf', 'log' },
    callback = function()
        local set = vim.opt_local
        set.number = false
        set.relativenumber = false
        set.wrap = true
        set.linebreak = true
        set.colorcolumn = ''
        set.signcolumn = 'no'
        set.spell = true
        set.listchars = {
            tab = '  ',
            trail = ' ',
            extends = '…',
            precedes = '…',
            conceal = 'x',
        }
        vim.cmd('hi Whitespace guibg=NONE')
    end,
})

-- https://github.com/mong8se/actually.nvim
vim.api.nvim_create_autocmd('BufNewFile', {
    pattern = '*',
    callback = function(details)
        if vim.fn.filereadable(details.file) == 1 then return end
        local possibles = vim.split(vim.fn.glob(details.file .. '*'), '\n', { trimempty = true })

        if #possibles > 0 then
            vim.ui.select(possibles, { prompt = 'You probably meant:' }, function(choice)
                if choice then vim.cmd('edit ' .. vim.fn.fnameescape(choice)) end
            end)
        end
    end,
})

-- https://github.com/mawkler/modicator.nvim
vim.api.nvim_create_autocmd('ModeChanged', {
    callback = function()
        local modes = {
            ['i'] = '#7aa2f7',
            ['c'] = '#e0af68',
            ['v'] = '#c678dd',
            ['V'] = '#c678dd',
            [''] = '#c678dd',
        }
        vim.api.nvim_set_hl(0, 'CursorLineNr', {
            foreground = modes[vim.api.nvim_get_mode().mode] or '#737aa2',
        })
    end,
})

-- restore cursor position
autocmd('BufReadPost', {
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local lcount = vim.api.nvim_buf_line_count(0)
        if mark[1] > 0 and mark[1] <= lcount then pcall(vim.api.nvim_win_set_cursor, 0, mark) end
    end,
})

autocmd('BufWritePre', {
    group = vim.api.nvim_create_augroup('auto_create_dir', { clear = true }),
    callback = function(event)
        local file = vim.loop.fs_realpath(event.match) or event.match

        vim.fn.mkdir(vim.fn.fnamemodify(file, ':p:h'), 'p')
        local backup = vim.fn.fnamemodify(file, ':p:~:h')
        backup = backup:gsub('[/\\]', '%%')
        vim.go.backupext = backup
    end,
})

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
