return {
  'nvim-treesitter/nvim-treesitter',
  -- lazy = true,
  -- ft = { 'bash', 'diff', 'fish', 'help', 'lua', 'rust', 'vim' },
  build = ':TSUpdate',
  config = function()
    local parsers = {
      'bash',
      'comment',
      'diff',
      'fish',
      'gitcommit',
      'gitignore',
      'lua',
      'luadoc',
      'rust',
      'vim',
      'vimdoc',
    }

    require('nvim-treesitter.configs').setup {
      -- parser_install_dir = vim.fn.stdpath('data'),
      ensure_installed = vim.fn.executable('clang') == 1 and parsers or {},
      sync_install = true,
      highlight = { enable = true },
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
      indent = { enable = false },
    }
  end,
}
