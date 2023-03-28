local M = {
  'nvim-telescope/telescope.nvim',
  keys = { '<leader>f' }, -- mapping
  cmd = 'Telescope', -- alpha
  dependencies = { 'nvim-lua/plenary.nvim' },
}

M.config = function()
  require('telescope').setup {
    defaults = {
      prompt_prefix = '  ',
      selection_caret = '» ',
      entry_prefix = ' ',
      prompt_title = false,
      results_title = false,
      winblend = 10,
      file_ignore_patterns = {
        '.pdf',
        'node_modules',
        '.git/',
        '__pycache__',
        'stylua.toml',
      },
      path_display = { shorten = { len = 1, exclude = { 1, -1 } } },
      mappings = {
        i = {
          ['<C-q>'] = 'close',
          ['<esc>'] = 'close',
          ['<C-Down>'] = 'cycle_history_next',
          ['<C-Up>'] = 'cycle_history_prev',
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
