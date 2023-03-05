local command = vim.api.nvim_create_user_command

command('Run', function(opts)
    local code = vim.fn.join(vim.fn.getline(opts.line1, opts.line2), '\n')
    local ft = vim.o.filetype
    if ft == 'fish' then
        print(vim.fn.system("fish -c '" .. vim.fn.escape(code, "'") .. "'"))
    elseif ft == 'sh' or ft == 'bash' then
        print(vim.fn.system("bash -c '" .. vim.fn.escape(code, "'") .. "'"))
    elseif ft == 'python' then
        print(vim.fn.system("python -c '" .. vim.fn.escape(code, "'") .. "'"))
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
