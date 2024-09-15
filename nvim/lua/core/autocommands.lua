local set = vim.opt_local
local autocmd = vim.api.nvim_create_autocmd

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
    set.linebreak = true
    set.number = false
    set.relativenumber = false
    set.signcolumn = 'no'
    set.foldcolumn = '0'
    set.statusline =
      '%#stl_hl_b# %t %{ &modified ? "󰆓 " : "" }%#stl_hl_to#%#Normal# %=%{ v:hlsearch ? g:stl.hlsearch(searchcount()) : "" } %{ g:stl.progress(line("."), line("$")) } '
  end,
})

autocmd('SwapExists', {
  desc = 'handle swapfile',
  callback = function()
    vim.ui.select({
      'quit vim (default)',
      'delete swapfile and edit anyway',
      'open file in read-only mode',
    }, {
      prompt = 'a swapfile already exists!',
    }, function(choice)
      -- vim.v.swapchoice = choice and string.sub(choice, 1, 1) or 'q'
      if choice == 'delete swapfile and edit anyway' then
        vim.opt_local.readonly = false
      elseif choice == 'open file in read-only mode' then
        vim.opt_local.readonly = true
        vim.opt_local.modifiable = false
      else
        vim.cmd(#vim.fn.getbufinfo({ buflisted = 1 }) == 1 and 'q' or 'bd')
      end
    end)
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
      vim.cmd.edit(vim.fn.fnameescape(choice))
      vim.cmd 'filetype detect'
      vim.api.nvim_buf_delete(details.buf, {})
    end)
  end,
})

autocmd('VimEnter', {
  desc = 'intro screen',
  once = true,
  group = vim.api.nvim_create_augroup('IntroScreen', {}),
  callback = function()
    if vim.fn.argc() == 0 then
      local nmap = function(lhs, rhs) vim.keymap.set('n', lhs, rhs, { buffer = true, silent = true }) end
      set.bufhidden = 'hide'
      set.buftype = 'nofile'
      nmap('f', '<cmd>Telescope find_files<cr>')
      nmap('g', '<cmd>Telescope live_grep<cr>') -- FIX: doesnt start right away
      nmap('h', '<cmd>Telescope help_tags<cr>')
      nmap('o', '<cmd>Telescope oldfiles<cr>')
      nmap('u', '<cmd>Lazy update<cr>')
      nmap('q', '<cmd>q!<cr>')
      -- TODO
      -- autocmd('CursorMoved', {
      --   once = true,
      --   command = 'nmapc <buffer>',
      -- })
    end
  end,
})

-- https://github.com/stevearc/oil.nvim
autocmd('VimEnter', {
  desc = 'open directory in telescope',
  callback = function(details)
    if vim.fn.isdirectory(details.file) == 1 then
      vim.opt_local.buftype = 'nofile'
      vim.opt_local.bufhidden = 'delete'
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

autocmd('TextYankPost', {
  callback = function() vim.highlight.on_yank { higroup = 'IncSearch', timeout = 250 } end,
})

autocmd('FileType', { pattern = { 'qf' }, command = 'nmap <buffer> <cr> <cr>' })
autocmd('BufEnter', { command = 'set formatoptions-=cro' })

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
--       fg = modes[vim.api.nvim_get_mode().mode] or '#98c379',
--     })
--   end,
-- })
-- https://github.com/ibhagwan/smartyank.nvim
-- autocmd({ 'TextYankPost' }, {
--   desc = 'stop certain stuff from going to clipboard',
--   callback = function()
--     local ok, yank_data = pcall(vim.fn.getreg, '0')
--     if ok and #yank_data > 1 then pcall(vim.fn.setreg, '+', yank_data) end
--   end,
-- })
-- autocmd('BufReadPost', {
--   desc = 'restore cursor position',
--   callback = function()
--     local mark = vim.api.nvim_buf_get_mark(0, '"')
--     if mark[1] > 0 and mark[1] <= vim.api.nvim_buf_line_count(0) then pcall(vim.api.nvim_win_set_cursor, 0, mark) end
--   end,
-- })
-- autocmd('VimLeave', { command = 'set guicursor=a:hor25' })
