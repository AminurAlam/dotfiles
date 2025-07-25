local set = vim.opt_local
local autocmd = vim.api.nvim_create_autocmd

local tsft = {}

for f in vim.fs.dir(vim.fn.stdpath('data') .. '/site/parser') do
  for _, ft in ipairs(vim.treesitter.language.get_filetypes(vim.fn.fnamemodify(f, ':r'))) do
    table.insert(tsft, ft)
  end
end

autocmd('FileType', {
  desc = 'automatically start treesitter',
  pattern = tsft,
  callback = function(details)
    vim.treesitter.start()
    vim.bo[details.buf].syntax = 'on'
    vim.wo.foldmethod = 'expr'
    vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
  end,
})

autocmd({ 'FileType', 'BufNewFile' }, {
  desc = 'reading mode for some filetypes',
  pattern = { 'help', 'man' },
  callback = function()
    set.linebreak = true
    set.number = false
    set.relativenumber = false
    set.signcolumn = 'no'
    set.foldcolumn = '0'
    set.statusline = '%#stl_hl_b# %t %{ &modified ? "󰆓 " : "" }'
      .. '%#stl_hl_to#%#Normal# %='
      .. '%{ v:hlsearch ? g:stl.hlsearch(searchcount()) : "" } '
      .. '%{ g:stl.progress(line("."), line("$")) } '
  end,
})

vim.api.nvim_create_autocmd({ 'Filetype' }, {
  desc = 'helper commands for latex',
  pattern = { 'tex', 'plaintex', 'bib' },
  callback = function()
    vim.api.nvim_create_user_command('Tex', function() --
      vim.cmd('silent !latexmk -pdf -interaction=nonstopmode -synctex=1 % ; open %:r.pdf')
    end, { desc = 'Builds your tex file', bang = true })

    vim.api.nvim_create_user_command('TexClean', function() --
      vim.cmd('silent !latexmk -c')
    end, { desc = 'Builds your tex file', bang = true })
  end,
})

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
      set.buftype = 'nofile'
      set.bufhidden = 'delete'
      vim.cmd.cd(details.file)
      vim.cmd 'Telescope find_files'
    end
  end,
})

autocmd('FileType', {
  pattern = 'oil',
  command = 'nmap <buffer> <scrollwheelup> <up> | nmap <buffer> <scrollwheeldown> <down>',
})

autocmd('BufWritePre', {
  desc = 'automatically create missing directories when saving files',
  callback = function(details)
    local path = vim.fs.dirname(details.match)
    if vim.fn.isdirectory(path) == 0 then vim.fn.mkdir(path, 'p') end
  end,
})

autocmd('TermOpen', {
  desc = 'when opening a new terminal buffer',
  callback = function()
    set.number = false
    set.relativenumber = false
    vim.cmd.startinsert()
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
  callback = function() vim.hl.on_yank { higroup = 'IncSearch', timeout = 250 } end,
})

autocmd('FileType', { pattern = { 'qf' }, command = 'nmap <buffer> <cr> <cr>' })
autocmd('FileType', { pattern = { 'checkhealth' }, command = 'set bh=wipe nobl nonu nornu nowrap' })
autocmd('VimLeave', { pattern = '*.tex', command = '!latexmk -c' })
autocmd('BufEnter', { command = 'set formatoptions-=cro' })
autocmd('BufLeave', { command = 'set nocursorline' })
autocmd('BufEnter', { command = 'set cursorline' })

-- autocmd('VimEnter', {
--   desc = 'intro screen',
--   once = true,
--   group = vim.api.nvim_create_augroup('IntroScreen', {}),
--   callback = function()
--     if vim.fn.argc() == 0 then
--       local nmap = function(lhs, rhs)
--         vim.keymap.set('n', lhs, rhs, { buffer = true, silent = true })
--       end
--       set.bufhidden = 'hide'
--       set.buftype = 'nofile'
--       nmap('f', '<cmd>Telescope find_files<cr>')
--       nmap('g', '<cmd>Telescope live_grep<cr>')
--       nmap('h', '<cmd>Telescope help_tags<cr>')
--       nmap('o', '<cmd>Telescope oldfiles<cr>')
--       nmap('u', '<cmd>Lazy update<cr>')
--       nmap('q', '<cmd>q!<cr>')
--       -- TODO
--       -- autocmd('CursorMoved', {
--       --   once = true,
--       --   command = 'nmapc <buffer>',
--       -- })
--     end
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
