local M = {
  'jose-elias-alvarez/null-ls.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  ft = { 'lua', 'fish', 'c', 'cpp', 'sh' },
}

M.config = function()
  local null_ls = require('null-ls')
  local sources = {}

  ---@param name string
  ---@param group string
  ---@param info nil|table
  local add = function(name, group, info)
    local bin = info and info.bin
    local config = info and info.config

    if bin and vim.fn.executable(bin) == 0 then return end

    -- avoid indexing .with() when theres no config
    table.insert(
      sources,
      config and null_ls.builtins[group][name].with(config) or null_ls.builtins[group][name]
    )
  end

  add('stylua', 'formatting', {
    bin = 'stylua',
    config = { extra_args = {
      '-f',
      vim.fn.stdpath('config') .. '/stylua.toml',
    } },
  })
  add('ruff', 'diagnostics', { bin = 'ruff' })
  add('fish', 'diagnostics', { bin = 'fish' })
  add('fish_indent', 'formatting', { bin = 'fish_indent' })
  add('shellcheck', 'diagnostics', { bin = 'shellcheck' })
  add('clang_check', 'diagnostics', { bin = 'clang-check' })
  add('shellcheck', 'code_actions', { bin = 'shellcheck' })
  add('gitsigns', 'code_actions')
  -- add('ts_node_action', 'code_actions')
  -- add('spell', 'completion')

  null_ls.setup {
    border = 'rounded',
    sources = sources,
  }
end

return M
