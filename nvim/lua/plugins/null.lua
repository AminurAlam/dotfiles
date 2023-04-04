return {
  'jose-elias-alvarez/null-ls.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local null_ls = require("null-ls")

    null_ls.setup {
      border = 'rounded',
      sources = {
        null_ls.builtins.diagnostics.ruff,
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.diagnostics.fish,
        null_ls.builtins.formatting.fish_indent,
        null_ls.builtins.diagnostics.clang_check,
      },
    }
  end
}
