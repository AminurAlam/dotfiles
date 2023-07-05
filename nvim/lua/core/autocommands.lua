local autocmd = vim.api.nvim_create_autocmd
local set = vim.opt_local

autocmd('FileType', {
  desc = 'exit by pressing q or <esc>',
  pattern = { 'qf', 'help', 'lazy', 'lspinfo', 'DressingSelect', 'Trouble' },
  callback = function()
    vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = true })
    vim.keymap.set('n', '<esc>', function()
      if vim.v.hlsearch == 1 then
        vim.cmd 'nohlsearch'
      else
        vim.cmd 'close'
      end
    end, { buffer = true })
    set.buflisted = false
  end,
})

autocmd({ 'FileType', 'BufNewFile' }, {
  desc = 'reading mode for some filetypes',
  pattern = {
    'alpha',
    'article',
    'diff',
    'gitcommit',
    'help',
    'lazy',
    'lspinfo',
    'log',
    'man',
    'text',
    'netrw',
    'Trouble',
  },
  callback = function()
    set.wrap = true
    set.linebreak = true
    set.statuscolumn = ' '
    set.statusline = '%#stl_hl_a# %t %#stl_hl_cx#%#Normal# %=%{ g:stl.hlsearch() } %{ g:stl.progress() } '
  end,
})

-- https://github.com/mong8se/actually.nvim
autocmd('BufNewFile', {
  desc = 'when tab completion doesnt work',
  once = true,
  callback = function(details)
    if vim.fn.filereadable(details.file) == 1 then return end
    local possibles = vim.split(vim.fn.glob(details.file .. '*'), '\n', { trimempty = true })
    if #possibles == 0 then return end

    vim.ui.select(possibles, {}, function(choice)
      if not choice then return end
      local bufnr = vim.api.nvim_win_get_buf(0)
      vim.cmd('edit ' .. vim.fn.fnameescape(choice) .. ' | filetype detect')
      vim.api.nvim_buf_delete(bufnr, {})
    end)
  end,
})

autocmd('VimEnter', {
  desc = 'open directory in telescope',
  callback = function(details)
    if vim.fn.isdirectory(details.file) == 1 then
      vim.cmd.cd(details.file)
      vim.cmd('Telescope find_files')
    end
  end,
})

autocmd({ 'BufReadPost', 'BufWinEnter' }, {
  desc = 'restore cursor position',
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    if mark[1] > 0 and mark[1] <= vim.api.nvim_buf_line_count(0) then pcall(vim.api.nvim_win_set_cursor, 0, mark) end
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
  desc = 'save folds on exit',
  pattern = '?*',
  command = 'silent! mkview 1',
})

autocmd('BufEnter', {
  desc = 'auto load folds',
  pattern = '?*',
  command = 'silent! loadview 1',
})

autocmd('TextYankPost', {
  callback = function() vim.highlight.on_yank { higroup = 'IncSearch', timeout = 300 } end,
})

autocmd('BufEnter', {
  callback = function() set.formatoptions:remove { 'c', 'r', 'o' } end,
})

-- https://github.com/mawkler/modicator.nvim
-- vim.api.nvim_create_autocmd('ModeChanged', {
--   desc = 'change cursor line number based on mode',
--   callback = function()
--     local modes = {
--       ['i'] = '#7aa2f7',
--       ['c'] = '#e06c75',
--       ['cv'] = '#e06c75',
--       ['ce'] = '#e06c75',
--       ['R'] = '#e06c75',
--       ['v'] = '#c678dd',
--       ['V'] = '#c678dd',
--       ['\22'] = '#c678dd',
--       ['s'] = '#c678dd',
--       ['S'] = '#c678dd',
--       ['\19'] = '#c678dd',
--     }
--     vim.api.nvim_set_hl(0, 'CursorLineNr', {
--       foreground = modes[vim.api.nvim_get_mode().mode] or '#98c379',
--     })
--   end,
-- })
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
-- autocmd('VimLeave', {
--   callback = function() vim.opt.guicursor = 'a:hor25' end,
-- })
-- vim.api.nvim_create_autocmd({ 'VimResized' }, {
--     callback = function() vim.cmd('tabdo wincmd =') end,
-- })
-- vim.api.nvim_create_autocmd({ 'CmdWinEnter' }, {
--     callback = function() vim.cmd('quit') end,
-- })
-- vim.api.nvim_create_autocmd({ 'VimEnter' }, {
--     callback = function() vim.cmd('hi link illuminatedWord LspReferenceText') end,
-- })
-- vim.cmd("autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif")
