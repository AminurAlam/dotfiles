return {
  'nvim-treesitter/nvim-treesitter',
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
      ensure_installed = {
        -- 'bash',
        -- 'diff',
        -- 'fish',
        -- 'lua',
        -- 'luadoc',
        -- 'python',
        -- 'vim',
        -- 'vimdoc',
      },
      highlight = { enable = true },
      incremental_selection = { enable = true },
      textobjects = { enable = true },
    }
  end,
}
