if vim.uv.os_uname().sysname == 'Windows_NT' then
  return
end

local sel = require('vim.treesitter._select')
vim.keymap.set({ 'x' }, '<c-k>', sel.select_grow_prev)
vim.keymap.set({ 'x' }, '<c-j>', sel.select_grow_next)

vim.keymap.set({ 'x', 'o' }, 'n', function()
  if vim.treesitter.get_parser(nil, nil, { error = false }) then
    require 'vim.treesitter._select'.select_parent(vim.v.count1)
  else
    vim.lsp.buf.selection_range(vim.v.count1)
  end
end)

vim.keymap.set({ 'x', 'o' }, 'N', function()
  if vim.treesitter.get_parser(nil, nil, { error = false }) then
    require 'vim.treesitter._select'.select_child(vim.v.count1)
  else
    vim.lsp.buf.selection_range(-vim.v.count1)
  end
end)

vim.api.nvim_create_autocmd('FileType', {
  desc = 'automatically start treesitter',
  callback = function(args)
    -- https://github.com/MeanderingProgrammer/treesitter-modules.nvim#implementing-yourself
    local buf = args.buf
    local filetype = args.match
    if filetype == 'handlebars' then
      return
    end

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

vim.api.nvim_create_autocmd('User', {
  pattern = 'TSUpdate',
  callback = function()
    for _, name in ipairs({ 'kanata', 'newsraft', 'zathurarc' }) do
      local path = '~/repos/tree-sitter/' .. name
      -- local exists = vim.uv.fs_stat(path)
      require('nvim-treesitter.parsers')[name] = {
        install_info = {
          path = path,
          url = 'https://codeberg.org/AminurAlam/tree-sitter-' .. name,
          queries = 'queries/',
        },
        tier = 2,
      }
    end
  end,
})

vim.api.nvim_create_autocmd({ 'PackChanged' }, {
  desc = 'treesitter parser update',
  callback = function(args)
    local spec = args.data.spec
    if spec and spec.name == 'nvim-treesitter' and args.data.kind == 'update' then
      for _, name in ipairs({ 'kanata', 'newsraft', 'zathurarc' }) do
        local path = '~/repos/tree-sitter/' .. name
        -- local exists = vim.uv.fs_stat(path)
        require('nvim-treesitter.parsers')[name] = {
          install_info = {
            path = path,
            url = 'https://codeberg.org/AminurAlam/tree-sitter-' .. name,
            queries = 'queries/',
          },
          tier = 2,
        }
      end
      vim.schedule(function()
        vim.cmd('TSUpdate')
      end)
    end
  end,
})
