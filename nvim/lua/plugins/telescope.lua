local M = {
  'https://github.com/nvim-telescope/telescope.nvim',
  keys = { '<leader>f' },
  cmd = 'Telescope',
  dependencies = { 'nvim-lua/plenary.nvim' },
}

M.config = function()
  require('telescope').setup {
    defaults = {
      layout_strategy = 'flex',
      layout_config = {
        vertical = {
          height = 0.85,
          width = 0.85,
          prompt_position = 'bottom',
          preview_cutoff = 38,
          preview_height = 16,
        },
      },
      prompt_prefix = '  ',
      selection_caret = '» ',
      entry_prefix = ' ',
      dynamic_preview_title = false,
      results_title = false,
      prompt_title = false,
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
      path_display = vim.fn.has 'termux' == 1 and { shorten = { len = 1, exclude = { 1, -1 } } }
        or {},
      mappings = {
        i = {
          ['<esc>'] = 'close',
          ['<C-Down>'] = 'cycle_history_next',
          ['<C-Up>'] = 'cycle_history_prev',
          ['j'] = 'move_selection_next',
          ['k'] = 'move_selection_previous',
          ['<S-Tab>'] = 'move_selection_next',
          ['<Tab>'] = 'move_selection_previous',
        },
        n = {
          ['<C-q>'] = 'close',
          ['<esc>'] = 'close',
          ['<q>'] = 'close',
        },
      },
    },
  }

  local find_map = function(key, method)
    vim.keymap.set('n', '<leader>' .. key, require('telescope.builtin')[method], {
      noremap = true,
      silent = true,
    })
  end
  find_map('ff', 'find_files')
  find_map('fg', 'live_grep')
  find_map('fh', 'help_tags')
  find_map('fr', 'oldfiles')
end

return M
