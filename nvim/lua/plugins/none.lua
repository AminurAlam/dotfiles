local M = {
  'nvimtools/none-ls.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  ft = { 'lua', 'fish', 'c', 'cpp', 'sh' },
}

M.config = function()
  local null_ls = require 'null-ls'
  local sources = {}

  ---@param name string
  ---@param group 'diagnostics'|'formatting'|'code_actions'|'hover'|'completion'
  ---@param config table?
  local add = function(name, group, config)
    if name and vim.fn.executable(name) == 0 then return end

    -- avoid indexing .with() when theres no config
    table.insert(sources, config and null_ls.builtins[group][name].with(config) or null_ls.builtins[group][name])
  end

  add('stylua', 'formatting', {
    extra_args = { '-f', os.getenv('XDG_CONFIG_HOME') .. '/stylua.toml' },
  })
  add('ruff', 'diagnostics')
  add('fish', 'diagnostics')
  add('fish_indent', 'formatting')
  add('shellcheck', 'code_actions')
  add('shellcheck', 'diagnostics')
  -- add('ts_node_action', 'code_actions')
  -- add('spell', 'completion')
  -- add('clang_check', 'clang-check', 'diagnostics') -- comes with clangd

  null_ls.setup {
    border = 'rounded',
    sources = sources,
  }
end

return M
