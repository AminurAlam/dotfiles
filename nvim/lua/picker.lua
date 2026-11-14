require('mini.pick').setup({
  delay = { async = 10, busy = 50 },
  mappings = {
    caret_left = '<Left>',
    caret_right = '<Right>',
    choose = '<CR>',
    choose_marked = '<M-CR>',
    delete_left = '<C-u>',
    delete_word = '<C-w>',
    move_down = '<C-j>',
    move_start = '<C-g>',
    move_up = '<C-k>',
    paste = '<C-r>',
    stop = '<Esc>',
    toggle_preview = '<Tab>',
  },
  options = { content_from_bottom = true, use_cache = false },
  window = {
    config = function()
      local height = math.floor(0.85 * vim.o.lines)
      local width = math.floor(0.85 * vim.o.columns)
      return {
        border = 'rounded',
        anchor = 'NW',
        height = height,
        width = width,
        row = math.floor(0.5 * (vim.o.lines - height)),
        col = math.floor(0.5 * (vim.o.columns - width)),
      }
    end,
    prompt_caret = '_',
    prompt_prefix = '  ',
  },
})

local fmap = function(key, method)
  vim.keymap.set('n', '<leader>' .. key, function()
    require('mini.pick').builtin[method]({}, { source = { cwd = vim.fs.root(0, '.git') } })
  end, {
    noremap = true,
    silent = true,
  })
end

fmap('f', 'files')
fmap('g', 'grep_live')
fmap('h', 'help')

vim.api.nvim_create_autocmd({ 'FileType' }, {
  desc = 'make selected line pop more',
  pattern = { 'minipick' },
  command = 'hi link MiniFilesCursorLine Visual',
})
