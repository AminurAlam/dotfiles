return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  config = function()
    local cc = vim.fn.executable('clang') + vim.fn.executable('clang') > 1
    local parsers = {
      'bash',
      'diff',
      'fish',
      'lua',
      'luadoc',
      'python',
      'vim',
      'vimdoc',
    }

    require('nvim-treesitter.configs').setup {
      -- parser_install_dir = vim.fn.stdpath('data'),
      ensure_installed = cc and parsers or {},
      sync_install = true,
      highlight = { enable = true },
      incremental_selection = { enable = true },
      textobjects = { enable = true },
      indent = { enable = false },
    }
  end,
}
