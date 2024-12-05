local M = {
  'https://github.com/nvimtools/none-ls.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    -- { 'gbprod/none-ls-shellcheck.nvim', ft = 'sh' },
  },
}

M.config = function()
  local null_ls = require 'null-ls'
  null_ls.setup {
    border = 'rounded',
    sources = {
      null_ls.builtins.diagnostics.ktlint,
      null_ls.builtins.formatting.ktlint,
      null_ls.builtins.formatting.prettier,
      null_ls.builtins.formatting.stylua,
      null_ls.builtins.diagnostics.fish,
      null_ls.builtins.formatting.fish_indent,
      null_ls.builtins.formatting.clang_format.with { extra_filetypes = { 'json' } },
      -- null_ls.builtins.diagnostics.yamllint,
      null_ls.builtins.diagnostics.sqlfluff.with { extra_args = { '--dialect', 'oracle' } },
      null_ls.builtins.formatting.sqlfluff.with { extra_args = { '--dialect', 'oracle' } },
      -- require('none-ls-shellcheck.diagnostics'),
      -- require('none-ls-shellcheck.code_actions'),
      null_ls.builtins.formatting.sqlfluff.with {
        extra_args = { '--dialect', 'oracle' },
        extra_filetypes = { 'sqloracle' },
      },
      null_ls.builtins.diagnostics.sqlfluff.with {
        extra_args = { '--dialect', 'oracle' },
        extra_filetypes = { 'sqloracle' },
      },
    },
  }
end

return M
