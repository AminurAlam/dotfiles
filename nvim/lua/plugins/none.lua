local M = {
  'nvimtools/none-ls.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  ft = { 'lua', 'fish', 'c', 'cpp', 'sh' },
}

M.config = function()
  local null_ls = require 'null-ls'
  local sources = {}

  ---@param name string
  ---@param bin string
  ---@param group 'diagnostics'|'formatting'|'code_actions'|'hover'|'completion'
  ---@param config table?
  local add = function(name, bin, group, config)
    if bin and vim.fn.executable(bin) == 0 then return end

    -- avoid indexing .with() when theres no config
    table.insert(sources, config and null_ls.builtins[group][name].with(config) or null_ls.builtins[group][name])
  end

  add('stylua', 'stylua', 'formatting', { extra_args = { '-f', os.getenv('XDG_CONFIG_HOME') .. '/stylua.toml' } })
  add('ruff', 'ruff', 'diagnostics')
  add('fish', 'fish', 'diagnostics')
  add('fish_indent', 'fish_indent', 'formatting')
  add('clang_check', 'clang-check', 'diagnostics')
  add('shellcheck', 'shellcheck', 'code_actions')
  add('shellcheck', 'shellcheck', 'diagnostics')
  -- add('ts_node_action', 'code_actions')
  -- add('spell', 'completion')

  null_ls.setup {
    border = 'rounded',
    sources = sources,
  }
end

return M
