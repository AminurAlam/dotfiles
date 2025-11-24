vim.api.nvim_create_autocmd('FileType', {
  desc = 'automatically start treesitter',
  callback = function(details)
    if pcall(vim.treesitter.start) then
      vim.bo[details.buf].syntax = 'on'
      vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
      vim.wo.foldmethod = 'expr'
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
    -- if vim.bo[details.buf].buftype ~= '' then return end
    -- local ts = require('nvim-treesitter')
    -- local ft = vim.bo[details.buf].filetype
    -- local is_available = vim.list_contains(ts.get_available(2), ft)
    -- local is_installed = vim.list_contains(ts.get_installed(), ft)
    -- if is_available then
    --   if not is_installed then ts.install(ft) end
    --   vim.treesitter.start(details.buf)
    --   vim.wo.foldlevel = 2
    --   vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    --   vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    --   vim.wo.foldmethod = 'expr'
    -- end
  end,
})

vim.api.nvim_create_autocmd({ 'PackChanged' }, {
  callback = function(args)
    local spec = args.data.spec
    if spec and spec.name == 'nvim-treesitter' and args.data.kind == 'update' then
      vim.schedule(function() vim.cmd('TSUpdate') end)
    end
  end,
})
