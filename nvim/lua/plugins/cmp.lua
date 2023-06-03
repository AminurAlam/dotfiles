local M = {
  'hrsh7th/nvim-cmp',
  event = { 'CmdlineEnter', 'InsertEnter' },
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-nvim-lua',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-cmdline',
    'uga-rosa/cmp-dictionary',
    'f3fora/cmp-spell',
    'L3MON4D3/LuaSnip', -- helps create snippets
    'saadparwaiz1/cmp_luasnip', -- adds snippets to cmp
    'rafamadriz/friendly-snippets', -- provides multiple snippets
    { 'mtoohey31/cmp-fish', ft = 'fish' },
  },
}

M.config = function()
  local cmp = require('cmp')
  local luasnip = require('luasnip')
  local kind_icons = {
    Text = '',
    Method = '󰆧',
    Function = '󰊕',
    Constructor = '',
    Field = '󰇽',
    Variable = '󰂡',
    Class = '󰠱',
    Interface = '',
    Module = '',
    Property = '󰜢',
    Unit = '',
    Value = '󰎠',
    Enum = '',
    Keyword = '󰌋',
    Snippet = '',
    Color = '󰏘',
    File = '󰈙',
    Reference = '',
    Folder = '󰉋',
    EnumMember = '',
    Constant = '󰏿',
    Struct = '',
    Event = '',
    Operator = '󰆕',
    TypeParameter = '󰅲',
  }
  local buffer_text = {
    nvim_lsp = '[LSP]',
    nvim_lua = '[LUA]',
    path = '[PATH]',
    buffer = '[BUF]',
    dap = '[DAP]',
    vsnip = '[VSN]',
    luasnip = '[LSN]',
    ultisnips = '[USN]',
    snippy = '[SNP]',
    snipmate = '[SNM]',
    nvim_lsp_document_symbol = '[DOC]',
    fish = '[FISH]',
  }

  cmp.setup {
    view = { entries = 'custom' },
    experimental = { ghost_text = { hl_group = 'Comment' } },
    snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
    preselect = cmp.PreselectMode.None,
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    formatting = {
      format = function(entry, vim_item)
        vim_item.kind = kind_icons[vim_item.kind]
        vim_item.menu = (buffer_text)[entry.source.name]
        return vim_item
      end,
    },
    mapping = cmp.mapping.preset.insert {
      ['<C-e>'] = cmp.mapping.abort(),
      ['<cr>'] = cmp.mapping.confirm { select = true },
      ['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end, { 'i', 's' }),
      ['<S-Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { 'i', 's' }),
    },
    sources = cmp.config.sources({
      { name = 'path' },
      { name = 'luasnip' },
      { name = 'fish' },
      { name = 'nvim_lsp' },
      { name = 'nvim_lua' },
      { name = 'dictionary' },
      { name = 'spell' },
    }, { { name = 'buffer' } }),
  }

  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources { { name = 'buffer' } },
    formatting = {
      format = function(_, vim_item)
        vim_item.kind = ''
        return vim_item
      end,
    },
  })

  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({ { name = 'path' } }, { { name = 'cmdline' } }),
    formatting = {
      format = function(_, vim_item)
        vim_item.kind = ''
        return vim_item
      end,
    },
  })

  require('luasnip.loaders.from_lua').lazy_load()
  require('luasnip.loaders.from_vscode').lazy_load()
  require('luasnip.loaders.from_snipmate').lazy_load()
  require('cmp_dictionary').switcher {
    filetype = { -- lua = { '/path/to/lua.dict' },
    },
    filepath = { -- ['.*xmake.lua'] = { '/path/to/xmake.dict', '/path/to/lua.dict' },
    },
    spelllang = { -- en = '/path/to/english.dict',
    },
  }
end

return M
