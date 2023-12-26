return {
  'nvim-treesitter/nvim-treesitter',
  -- lazy = true,
  -- ft = { 'bash', 'diff', 'fish', 'help', 'lua', 'rust', 'vim' },
  build = ':TSUpdate',
  config = function()
    local parsers = {
      'bash',
      'c',
      'comment',
      'diff',
      'fish',
      'gitcommit',
      'gitignore',
      'lua',
      'luadoc',
      'python',
      'rust',
      'vim',
      'vimdoc',
    }

    require('nvim-treesitter.configs').setup {
      -- parser_install_dir = vim.fn.stdpath('data'),
      ensure_installed = vim.fn.executable('clang') == 1 and parsers or {},
      sync_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = 'gnn',
          node_incremental = 'grn',
          scope_incremental = 'grc',
          node_decremental = 'grm',
        },
      },
      textobjects = { enable = true },
      indent = { enable = true },
    }
  end,
}
