local sign_map = { ' ', ' ', ' ', ' ' }
local hl_map = {
  'DiagnosticError',
  'DiagnosticWarn',
  'DiagnosticInfo',
  'DiagnosticHint',
}

vim.diagnostic.config {
  float = { border = 'rounded', header = '', source = 'if_many' },
  jump = {}, -- TODDO
  severity_sort = true,
  signs = { text = { '', '', '', '' }, numhl = hl_map },
  status = {
    format = function(counts)
      local items = {}
      for k, v in pairs(counts) do
        table.insert(items, ('%%#%s#%s:%s'):format(hl_map[k], sign_map[k], v))
      end
      table.insert(items, '%#Normal#')
      return table.concat(items, ' ')
    end,
  },
  underline = { severity = { vim.diagnostic.severity.ERROR, vim.diagnostic.severity.WARN } },
  virtual_text = {},
  update_in_insert = true,
}

vim.keymap.set({ 'n' }, '<leader>d', function()
  vim.diagnostic.config { virtual_lines = not vim.diagnostic.config().virtual_lines }
end)
