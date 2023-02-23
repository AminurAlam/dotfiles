local command = vim.api.nvim_create_user_command

command('Run', function(opts)
    local code = vim.fn.join(vim.fn.getline(opts.line1, opts.line2), '\n')
    local ft = vim.o.filetype
    if ft == 'fish' or ft == 'bash' or ft == 'sh' then
        print(vim.fn.system(code))
    elseif ft == 'python' then
        code = vim.fn.escape(code, '"')
        print(vim.fn.system('python -c "' .. code .. '"'))
    elseif ft == 'nim' then
        code = vim.fn.escape(code, '"')
        print(vim.fn.system('nim --hints:off --eval:"' .. code .. '"'))
    elseif ft == 'lua' then
        code = vim.fn.escape(code, '"')
        print(vim.fn.system('luajit -e "' .. code .. '"'))
    else
        print(ft .. ' cant be run')
    end
end, {
    desc = 'run selected code based on the filetype',
    range = true,
})
-- command('qn', function() vim.cmd('q!') end, { desc = 'alias to :q!' })
