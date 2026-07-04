local path = os.getenv('HOME') .. '/repos/tree-sitter-kanata'
local exists = vim.uv.fs_stat(path)

require('tree-sitter-manager').setup {
  ensure_installed = {
    'c',
    'lua',
    'luadoc',
    'markdown',
    'query',
    'vim',
    'vimdoc',
  },
  nohighlight = { 'glimmer', 'latex' },
  languages = {
    kanata = {
      install_info = {
        url = 'https://github.com/AminurAlam/tree-sitter-kanata',
        queries = 'queries',
        use_repo_queries = true,
      },
    },
  }, -- override or add new parser sources
}

local sel = require('vim.treesitter._select')
if vim.fn.has('nvim-0.12') then
  -- TODO: remove empty function after nvim is updated
  vim.keymap.set({ 'x' }, '<c-k>', sel.select_grow_prev or function() end)
  vim.keymap.set({ 'x' }, '<c-j>', sel.select_grow_next or function() end)

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
end

--[[
vim.api.nvim_create_autocmd('User', {
  pattern = 'TSUpdate',
  callback = function()
    local path = os.getenv('HOME') .. '/repos/tree-sitter-kanata'
    local exists = vim.uv.fs_stat(path)

    require('nvim-treesitter.parsers').kanata = {
      install_info = {
        path = exists and path or nil,
        url = exists and nil or 'https://github.com/AminurAlam/tree-sitter-kanata',
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
    if filetype == 'handlebars' then
      return -- TODO: remove when its fixed
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
--]]
