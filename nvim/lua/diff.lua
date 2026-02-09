require('mini.diff').setup({
  view = {
    style = 'sign',
    signs = { add = '┃', change = '┃', delete = '_' },
  },
  delay = { text_change = 200 },
  mappings = {
    apply = '',
    reset = 'U',
    textobject = 'H',
    goto_first = '',
    goto_last = '',
    goto_prev = '[h',
    goto_next = ']h',
  },
})

vim.keymap.set('n', 'H', require('mini.diff').toggle_overlay, { desc = 'preview hunk' })
vim.api.nvim_create_autocmd('User', {
  pattern = 'MiniDiffUpdated',
  callback = function(args)
    local summary = vim.b[args.buf].minidiff_summary
    local t = {}

    if summary.add > 0 then
      table.insert(t, '%#GitSignsAdd#+' .. summary.add)
    end
    if summary.change > 0 then
      table.insert(t, '%#GitSignsChange#~' .. summary.change)
    end
    if summary.delete > 0 then
      table.insert(t, '%#GitSignsDelete#-' .. summary.delete)
    end
    vim.b[args.buf].minidiff_summary_string = table.concat(t, ' ')
  end,
})
