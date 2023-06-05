local command = vim.api.nvim_create_user_command

-- TODO: run in a floating terminal
command('Run', function(opts)
  local fn = vim.fn
  local code = fn.shellescape(fn.join(fn.getline(opts.line1, opts.line2), '\n'))
  local ft = vim.o.filetype

  ---@param bins table[str]
  ---@param struct string
  local run = function(bins, struct)
    local bin = vim.tbl_filter(function(bin) return fn.executable(bin) == 1 and true or false end, bins)[1]

    if bin == nil then
      vim.notify(fn.join(bins, ', ') .. ' is not executable', 3)
      return
    end

    local cmd = string.format(struct, bin, code)
    vim.print(fn.system(cmd))
  end

  if ft == nil then
    vim.notify('ft is nil', 3)
  elseif ft == 'fish' then
    run({ 'fish' }, "%s -c '%s'")
  elseif ft == 'sh' or ft == 'bash' then
    run({ 'bash', 'sh' }, "%s -c '%s'")
  elseif ft == 'python' then
    run({ 'python' }, "%s -c '%s'")
  elseif ft == 'nim' then
    run({ 'nim' }, '%s --hints:off --eval:"%s"')
  elseif ft == 'lua' then
    run({ 'luajit', 'luvit' }, "%s -e '%s'")
  else
    vim.notify(ft .. ' doesnt have a runner implemented', 3)
  end
end, {
  desc = 'run selected code based on the filetype',
  range = true,
})

-- command('qn', function() vim.cmd('q!') end, { desc = 'alias to :q!' })
