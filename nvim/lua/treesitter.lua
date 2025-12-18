vim.api.nvim_create_autocmd('FileType', {
  desc = 'automatically start treesitter',
  callback = function(args)
    --[[
    if pcall(vim.treesitter.start) then
      vim.bo[args.buf].syntax = 'on'
      vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
      vim.wo.foldmethod = 'expr'
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
    --]]

    --[[
    if vim.bo[args.buf].buftype ~= '' then return end
    local ts = require('nvim-treesitter')
    local ft = vim.bo[args.buf].filetype
    local is_available = vim.list_contains(ts.get_available(2), ft)
    local is_installed = vim.list_contains(ts.get_installed(), ft)
    if is_available then
      if not is_installed then ts.install(ft) end
      vim.treesitter.start(args.buf)
      vim.wo.foldlevel = 2
      vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      vim.wo.foldmethod = 'expr'
    end
    --]]

    -- [[ https://github.com/MeanderingProgrammer/treesitter-modules.nvim#implementing-yourself
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
    --]]
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
