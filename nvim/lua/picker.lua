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
        ['<c-Down>'] = 'cycle_history_next',
        ['<c-Up>'] = 'cycle_history_prev',
        ['<c-j>'] = 'move_selection_next',
        ['<c-k>'] = 'move_selection_previous',
        ['<s-Tab>'] = 'move_selection_next',
        ['<tab>'] = 'move_selection_previous',
      },
      n = {
        ['<c-q>'] = 'close',
        ['<esc>'] = 'close',
        ['<q>'] = 'close',
      },
    },
  },
}

local fmap = function(key, method)
  vim.keymap.set('n', '<leader>' .. key, require('telescope.builtin')[method], {
    noremap = true,
    silent = true,
  })
end
fmap('ff', 'find_files')
fmap('fg', 'live_grep')
fmap('fh', 'help_tags')
fmap('fr', 'oldfiles')
fmap('go', 'loclist')
