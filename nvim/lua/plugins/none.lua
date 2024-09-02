local M = {
  'https://github.com/nvimtools/none-ls.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    -- { 'gbprod/none-ls-shellcheck.nvim', ft = 'sh' },
  },
  -- ft = { 'lua', 'fish', 'make', 'sh' },
}

M.config = function()
  local null_ls = require 'null-ls'
  null_ls.setup {
    border = 'rounded',
    sources = {
      null_ls.builtins.formatting.prettier,
      null_ls.builtins.formatting.stylua,
      null_ls.builtins.diagnostics.fish,
      null_ls.builtins.formatting.fish_indent,
      -- require('none-ls-shellcheck.diagnostics'),
      -- require('none-ls-shellcheck.code_actions'),
    },
  }
end

return M
