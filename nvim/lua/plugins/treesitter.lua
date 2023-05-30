return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  config = function()
    require('nvim-treesitter.install').compilers = {
      'clang',
      'gcc',
      'zig',
      'gcc-12',
      'gcc-11',
      'gcc-10',
      'gcc-9',
    }

    require('nvim-treesitter.configs').setup {
      -- parser_install_dir = vim.fn.stdpath('data'),
      ensure_installed = {
        'bash',
        'diff',
        'fish',
        'lua',
        'luadoc',
        'python',
        'vim',
        'vimdoc',
      },
      -- sync_install = true,
      highlight = { enable = true },
      incremental_selection = { enable = true },
      textobjects = { enable = true },
      indent = { enable = true },
    }
  end,
}
