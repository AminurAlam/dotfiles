local M = {
  'jose-elias-alvarez/null-ls.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  ft = { 'lua', 'fish', 'c', 'cpp', 'sh' },
}

M.config = function()
  local null_ls = require('null-ls')
  local sources = {}

  local add = function(info)
    local name = info[1]
    local group = info[2]
    if vim.fn.executable(info.bin or name) == 0 then return end
    table.insert(sources, null_ls.builtins[group][name].with(info.config or {}))
  end

  add { 'ruff', 'diagnostics' }
  add {'stylua', 'formatting', config = { extra_args = {
    '-f', vim.fn.stdpath('config') .. '/stylua.toml',
  } } }
  add { 'fish', 'diagnostics' }
  add { 'fish_indent', 'formatting' }
  add { 'clang_check', 'diagnostics', bin = 'clang-check' }
  add { 'shellcheck', 'code_actions' }
  add { 'shellcheck', 'diagnostics' }

  null_ls.setup {
    border = 'rounded',
    sources = sources,
  }
end

return M
