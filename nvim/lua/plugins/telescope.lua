local M = {
  'nvim-telescope/telescope.nvim',
  keys = { '<leader>f' }, -- mapping
  cmd = 'Telescope', -- alpha
  dependencies = { 'nvim-lua/plenary.nvim' },
}

M.config = function()
  require('telescope').setup {
    defaults = {
      layout_strategy = 'flex',
      layout_config = {
        height = 0.90,
        width = 0.80,
        -- mirror = true,
        -- prompt_position = 'top',
      },
      prompt_prefix = '  ',
      selection_caret = '» ',
      entry_prefix = ' ',
      prompt_title = false,
      results_title = false,
      winblend = 0,
      file_ignore_patterns = {
        '.pdf',
        'node_modules/',
        '.git/',
        '__pycache__',
        'stylua.toml',
        'Cargo.lock',
        'target/',
        'build/',
      },
      path_display = { shorten = { len = 1, exclude = { 1, -1 } } },
      mappings = {
        i = {
          ['<C-q>'] = 'close',
          ['<esc>'] = 'close',
          ['<C-Down>'] = 'cycle_history_next',
          ['<C-Up>'] = 'cycle_history_prev',
          ['<S-Tab>'] = 'move_selection_next',
          ['<Tab>'] = 'move_selection_previous',
          ['<ScrollWheelUp>'] = 'move_selection_previous',
          ['<ScrollWheelDown>'] = 'move_selection_next',
        },
        n = {
          ['<C-q>'] = 'close',
          ['<esc>'] = 'close',
          ['<q>'] = 'close',
        },
      },
    },
  }
end

return M
