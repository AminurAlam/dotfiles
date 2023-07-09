local M = {
  'nvim-telescope/telescope.nvim',
  keys = { '<leader>f' }, -- mapping
  cmd = 'Telescope', -- alpha
  dependencies = { 'nvim-lua/plenary.nvim' },
}

M.config = function()
  local nmap = function(lhs, rhs) vim.keymap.set('n', lhs, rhs, { noremap = true, silent = true }) end
  require('telescope').setup {
    defaults = {
      layout_strategy = 'flex',
      selection_strategy = 'follow',
      layout_config = {
        vertical = {
          height = 0.90,
          width = 0.80,
          prompt_position = 'bottom',
          preview_cutoff = 38,
          preview_height = 10,
        },
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
        -- 'build/',
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

  nmap('<leader>ff', require('telescope.builtin').find_files)
  nmap('<leader>fg', require('telescope.builtin').live_grep)
  nmap('<leader>fh', require('telescope.builtin').help_tags)
end

return M
