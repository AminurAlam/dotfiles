local autocmd = vim.api.nvim_create_autocmd

-- https://github.com/mong8se/actually.nvim
autocmd('BufNewFile', {
  desc = 'when tab completion doesnt finish',
  once = true,
  callback = function(details)
    if vim.fn.filereadable(details.file) == 1 then
      return
    end
    local possibles = vim.tbl_filter(function(file)
      return #file > 1
    end, vim.fn.glob(vim.fn.fnameescape(details.file) .. '*', false, true))
    if #possibles == 0 then
      return
    end

    vim.ui.select(possibles, {}, function(choice)
      if not choice then
        return
      end
      vim.cmd.edit(vim.fn.fnameescape(choice))
      vim.cmd 'filetype detect'
      vim.api.nvim_buf_delete(details.buf, {})
    end)
  end,
})

autocmd('VimEnter', {
  desc = 'open directory in telescope',
  once = true,
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
    if vim.fn.isdirectory(path) == 0 then
      vim.fn.mkdir(path, 'p')
    end
  end,
})

autocmd('FileType', {
  desc = 'use smaller indent lines',
  pattern = 'lua,toml,html,css,json',
  command = 'setl tabstop=2 shiftwidth=2 softtabstop=2 listchars+=leadmultispace:│\\ ',
})

autocmd('TextYankPost', {
  callback = function()
    vim.hl.on_yank { higroup = 'IncSearch', timeout = 250 }
  end,
})

autocmd('FileType', { pattern = 'checkhealth', command = 'set bh=wipe nobl nonu nornu nowrap' })
autocmd('FileType', { pattern = 'qf', command = 'nmap <buffer> <cr> <cr>' })
autocmd('FileType', { pattern = 'help', command = 'wincmd L' })

autocmd('UIEnter', { command = 'set clipboard=unnamedplus' })

autocmd('BufEnter', { command = 'set cursorline formatoptions-=cro' })
autocmd('BufLeave', { command = 'set nocursorline' })
autocmd('BufWinEnter', { pattern = '?*', command = 'silent! loadview 1' })
autocmd('BufWinLeave', { pattern = '?*', command = 'silent! mkview 1' })

-- autocmd('CmdlineEnter', { pattern = '[:/?]', command = 'set pumborder=rounded' })
-- autocmd('CmdlineChanged', { pattern = '[:/?]', command = 'call wildtrigger()' })
-- autocmd('CmdlineLeave', { pattern = '[:/?]', command = 'set pumborder&' })

-- TODO: disable numbers when diffing
