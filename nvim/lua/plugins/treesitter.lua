return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  config = function()
    local parsers = {
      'bash',
      'comment',
      'diff',
      'fish',
      'lua',
      'luadoc',
      'markdown',
      'markdown_inline',
      'python',
      'rust',
      'vim',
      'vimdoc',
    }

    require('nvim-treesitter.configs').setup {
      -- parser_install_dir = vim.fn.stdpath('data'),
      ensure_installed = vim.fn.executable('clang') and parsers or {},
      sync_install = true,
      highlight = { enable = true },
      incremental_selection = { enable = true },
      textobjects = { enable = true },
      indent = { enable = false },
    }
  end,
}
