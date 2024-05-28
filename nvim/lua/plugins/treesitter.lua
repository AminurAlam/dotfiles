return {
  'https://github.com/nvim-treesitter/nvim-treesitter',
  -- lazy = true,
  -- ft = { 'bash', 'diff', 'fish', 'help', 'lua', 'rust', 'vim' },
  build = ':TSUpdate',
  dependencies = { 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects' },
  config = function()
    local parsers = {
      'bash',
      'c',
      'comment',
      'diff',
      'fish',
      'gitcommit',
      'gitignore',
      'java',
      'kotlin',
      'lua',
      'luadoc',
      'python',
      'rust',
      'toml',
      'vim',
      'vimdoc',
    }

    require('nvim-treesitter.configs').setup {
      -- parser_install_dir = vim.fn.stdpath('data'),
      ensure_installed = vim.fn.executable('clang') == 1 and parsers or {},
      sync_install = true,
      indent = { enable = true },
      highlight = { enable = true, additional_vim_regex_highlighting = false },
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
            [']o'] = '@loop.outer',
            [']]'] = { query = '@fold', query_group = 'folds' },
          },
          goto_previous_start = {
            ['[m'] = '@function.outer',
            ['[o'] = '@loop.outer',
            ['[['] = { query = '@fold', query_group = 'folds' },
          },
          goto_next_end = { [']M'] = '@function.outer' },
          goto_previous_end = { ['[M'] = '@function.outer' },
        },
      },
    }
  end,
}
