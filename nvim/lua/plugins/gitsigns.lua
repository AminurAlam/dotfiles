return {
  'https://github.com/lewis6991/gitsigns.nvim', -- NOTE: https://github.com/lewis6991/gitsigns.nvim/issues/453
  opts = {
    signs = {
      add = { text = '┃' },
      change = { text = '┃' },
      delete = { text = '_' },
      topdelete = { text = '‾' },
      changedelete = { text = '~' },
      untracked = { text = '┆' },
    },
    signs_staged_enable = true,
    signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
    numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
    linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
    word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
    watch_gitdir = { follow_files = true },
    auto_attach = true,
    attach_to_untracked = false,
    current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
      delay = 1000,
      ignore_whitespace = false,
      virt_text_priority = 100,
    },
    current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
    sign_priority = 6,
    update_debounce = 100,
    max_file_length = 40000, -- Disable if file is longer than this (in lines)
    preview_config = {
      border = 'rounded',
      style = 'minimal',
      relative = 'cursor',
      row = 0,
      col = 1,
    },
    status_formatter = function(status)
      local added, changed, removed = status.added, status.changed, status.removed
      local status_txt = {}
      if added and added > 0 then table.insert(status_txt, '%#GitSignsAdd#+' .. added) end
      if changed and changed > 0 then table.insert(status_txt, '%#GitSignsChange#~' .. changed) end
      if removed and removed > 0 then table.insert(status_txt, '%#GitSignsDelete#-' .. removed) end
      return table.concat(status_txt, ' ') .. '%#Normal#'
    end,
  },
}
