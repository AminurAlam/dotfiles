return {
  'glepnir/flybuf.nvim',
  keys = { { '<leader>fb', '<cmd>FlyBuf<cr>' } },
  config = {
    hotkey = 'aoeuidhtns', -- hotkye
    border = 'rounded', -- border
    quit = 'q', -- quit flybuf window
    mark = 'l', -- mark as delet or cancel delete
    delete = 'x', -- delete marked buffers or buffers which cursor in
  },
}
