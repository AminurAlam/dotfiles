local autocmd = vim.api.nvim_create_autocmd

-- https://github.com/mong8se/actually.nvim
autocmd('BufNewFile', {
  desc = 'when tab completion doesnt finish',
  once = true,
  callback = function(details)
    if vim.fn.filereadable(details.file) == 1 then return end
    local possibles = vim.tbl_filter(
      function(file) return #file > 1 end,
      vim.fn.glob(vim.fn.fnameescape(details.file) .. '*', false, true)
    )
    if #possibles == 0 then return end

    vim.ui.select(possibles, {}, function(choice)
      if not choice then return end
      vim.cmd.edit(vim.fn.fnameescape(choice))
      vim.cmd 'filetype detect'
      vim.api.nvim_buf_delete(details.buf, {})
    end)
  end,
})

autocmd('VimEnter', {
  desc = 'open directory in telescope',
  callback = function(details)
    if vim.fn.isdirectory(details.file) == 1 then
      vim.bo.buftype = 'nofile'
      vim.bo.bufhidden = 'delete'
      vim.cmd.cd(details.file)
      vim.cmd 'Telescope find_files'
    end
  end,
})

autocmd('BufWritePre', {
  desc = 'automatically create missing directories when saving files',
  callback = function(details)
    local path = vim.fs.dirname(details.match)
    if vim.fn.isdirectory(path) == 0 then vim.fn.mkdir(path, 'p') end
  end,
})

autocmd('BufWinLeave', {
  desc = 'save folds & cursor on exit',
  pattern = '?*',
  command = 'silent! mkview 1',
})

autocmd('BufWinEnter', {
  desc = 'auto load folds & cursor',
  pattern = '?*',
  command = 'silent! loadview 1',
})

autocmd('FileType', {
  desc = 'use smaller indent linnes',
  pattern = 'lua,toml,html,css,json',
  command = 'setl listchars+=leadmultispace:│\\ ',
})

autocmd('TextYankPost', {
  callback = function() vim.hl.on_yank { higroup = 'IncSearch', timeout = 250 } end,
})

autocmd('FileType', { pattern = { 'checkhealth' }, command = 'set bh=wipe nobl nonu nornu nowrap' })
autocmd('FileType', { pattern = { 'qf' }, command = 'nmap <buffer> <cr> <cr>' })
autocmd('VimLeave', { pattern = '*.tex', command = '!latexmk -c' })
autocmd('BufEnter', { command = 'set formatoptions-=cro' })
autocmd('BufLeave', { command = 'set nocursorline' })
autocmd('BufEnter', { command = 'set cursorline' })

-- buggy pos
-- autocmd('VimEnter', {
--   desc = 'intro screen',
--   once = true,
--   callback = function()
--     if vim.fn.argc() > 0 then return end
--     local nmap = function(lhs, rhs) vim.keymap.set('n', lhs, rhs, { buffer = true, silent = true }) end
--     vim.bo.bufhidden = 'hide'
--     vim.bo.buftype = 'nofile'
--     nmap('f', '<cmd>Telescope find_files<cr>')
--     nmap('g', '<cmd>Telescope live_grep<cr>') -- TODO: del `gg`
--     nmap('h', '<cmd>Telescope help_tags<cr>')
--     -- TODO: reset mappings
--     -- autocmd('CursorMoved', {
--     --   once = true,
--     --   bufffer = 0,
--     --   command = 'nmapc <buffer>',
--     -- })
--   end,
-- })

-- https://github.com/ravibrock/regisfilter.nvim
-- https://github.com/ibhagwan/smartyank.nvim
-- autocmd({ 'TextYankPost' }, {
--   desc = 'stop certain stuff from going to clipboard',
--   callback = function()
--     local ok, yank_data = pcall(vim.fn.getreg, '0')
--     if ok and #yank_data > 1 then pcall(vim.fn.setreg, '+', yank_data) end
--   end,
-- })
