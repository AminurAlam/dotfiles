-- vim.treesitter.start()
-- require('nvim-treesitter').setup {}
-- -- vim.print(vim.treesitter.language.get_filetypes('glimmer'))
-- local tsft = {}
--
-- for f in vim.fs.dir(vim.fn.stdpath('data') .. '/site/parser') do
--   -- if f == 'glimmer.so' then
--   --   vim.print(vim.treesitter.language.get_filetypes(vim.fn.fnamemodify(f, ':r')))
--   -- end
--   for _, ft in ipairs(vim.treesitter.language.get_filetypes(vim.fn.fnamemodify(f, ':r'))) do
--     table.insert(tsft, ft)
--   end
-- end

vim.api.nvim_create_autocmd('FileType', {
  desc = 'automatically start treesitter',
  pattern = '*',
  callback = function(details)
    -- if #tsft == 0 then return end
    if pcall(vim.treesitter.start) then
      vim.bo[details.buf].syntax = 'on'
      vim.wo.foldmethod = 'expr'
      vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    end
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
