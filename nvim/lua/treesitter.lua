vim.api.nvim_create_autocmd('User', {
  pattern = 'TSUpdate',
  callback = function()
    require('nvim-treesitter.parsers').kanata = {
      install_info = {
        -- path = '~/repos/tree-sitter-kanata',
        url = 'https://github.com/AminurAlam/tree-sitter-kanata',
        queries = 'queries/',
      },
      tier = 2,
    }
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  desc = 'automatically start treesitter',
  callback = function(args)
    -- https://github.com/MeanderingProgrammer/treesitter-modules.nvim#implementing-yourself
    local buf = args.buf
    local filetype = args.match

    local language = vim.treesitter.language.get_lang(filetype) or filetype
    if not vim.treesitter.language.add(language) then
      return
    end

    vim.bo[args.buf].syntax = 'on'
    vim.wo.foldmethod = 'expr'
    vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    vim.treesitter.start(buf, language)
    vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    -- vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})

vim.api.nvim_create_autocmd({ 'PackChanged' }, {
  callback = function(args)
    local spec = args.data.spec
    if spec and spec.name == 'nvim-treesitter' and args.data.kind == 'update' then
      vim.schedule(function()
        vim.cmd('TSUpdate')
      end)
    end
  end,
})
