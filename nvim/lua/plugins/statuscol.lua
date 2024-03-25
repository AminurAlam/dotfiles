local M = {
  'https://github.com/luukvbaal/statuscol.nvim',
  enabled = false,
}

M.config = function()
  local builtin = require('statuscol.builtin')
  require('statuscol').setup({
    relculright = true,
    segments = {
      { text = { builtin.lnumfunc }, click = 'v:lua.ScFa' },
      { text = { builtin.foldfunc }, click = 'v:lua.ScFa' },
      { sign = { name = { '.*' }, maxwidth = 2, colwidth = 1, auto = true, wrap = true } },
      { text = { ' ' } },
    },
  })
end

return M
