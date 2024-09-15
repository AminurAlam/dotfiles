return {
  'https://github.com/nvim-treesitter/nvim-treesitter',
  main = 'nvim-treesitter.configs',
  build = ':TSUpdate',
  opts = {
    ensure_installed = vim.fn.executable('clang') == 1 and {
      'bash',
      'c',
      'comment',
      'diff',
      'fish',
      'python',
      'rust',
    } or {},
    sync_install = true,
    indent = { enable = true },
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = 'gn',
        node_incremental = 'n',
        node_decremental = 'N',
      },
    },
    textobjects = {
      swap = { enable = false },
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
        },
        selection_modes = {
          ['@parameter.outer'] = 'v', -- charwise
          ['@function.outer'] = 'V', -- linewise
          ['@class.outer'] = '<c-v>', -- blockwise
        },
        include_surrounding_whitespace = true,
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          [']m'] = '@function.outer',
          [']]'] = { query = '@fold', query_group = 'folds' },
          -- [']o'] = '@loop.outer', -- used for olifiles
        },
        goto_previous_start = {
          ['[m'] = '@function.outer',
          ['[['] = { query = '@fold', query_group = 'folds' },
          -- ['[o'] = '@loop.outer', -- used for olifiles
        },
        goto_next_end = { [']M'] = '@function.outer' },
        goto_previous_end = { ['[M'] = '@function.outer' },
      },
    },
  },
}
