local M = {
  'https://github.com/hrsh7th/nvim-cmp',
  event = { 'CmdlineEnter', 'InsertEnter' },
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-nvim-lua',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-cmdline',
    'L3MON4D3/LuaSnip', -- helps create snippets
    'saadparwaiz1/cmp_luasnip', -- adds snippets to cmp
    { 'AminurAlam/friendly-snippets', dev = true }, -- provides multiple snippets
    {
      'mtoohey31/cmp-fish',
      ft = 'fish',
      dev = true,
      -- init = function() require('cmp').register_source('fish', require('cmp_fish').new()) end,
    },
  },
}

M.config = function()
  local cmp = require 'cmp'
  local luasnip = require 'luasnip'
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
    nvim_lsp = 'LSP',
    nvim_lua = 'LUA',
    path = 'PATH',
    buffer = 'BUF',
    dap = 'DAP',
    vsnip = 'VSN',
    luasnip = 'LSN',
    ultisnips = 'USN',
    snippy = 'SNP',
    snipmate = 'SNM',
    nvim_lsp_document_symbol = 'DOC',
    fish = 'FISH',
  }

  cmp.setup {
    view = { entries = 'custom' },
    experimental = { ghost_text = false },
    snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
    preselect = cmp.PreselectMode.None,
    window = {
      completion = {
        border = 'rounded',
        winhighlight = 'Normal:Normal,FloatBorder:Normal,CursorLine:Visual,Search:None',
        zindex = 3,
        scrolloff = 2,
        col_offset = 0,
        side_padding = 1,
        scrollbar = true,
      },
      documentation = {
        border = 'rounded',
        winhighlight = 'Normal:Normal,FloatBorder:Normal,CursorLine:Visual,Search:None',
        zindex = 1001,
        scrolloff = 2,
        col_offset = 0,
        side_padding = 1,
        scrollbar = true,
      },
    },
    formatting = {
      format = function(entry, vim_item)
        vim_item.abbr = string.sub(vim_item.abbr, 1, 20)
        vim_item.kind = kind_icons[vim_item.kind]
        vim_item.menu = buffer_text[entry.source.name]
        return vim_item
      end,
    },
    mapping = cmp.mapping.preset.insert {
      ['<c-e>'] = cmp.mapping.abort(),
      ['<cr>'] = cmp.mapping.confirm { select = true },
      ['<c-u>'] = cmp.mapping.scroll_docs(-4),
      ['<c-d>'] = cmp.mapping.scroll_docs(4),
      ['<tab>'] = cmp.mapping(function(fallback)
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
    sources = cmp.config.sources {
      { name = 'path' },
      { name = 'luasnip' },
      { name = 'fish' }, -- TODO: fix overload
      { name = 'nvim_lsp' },
      { name = 'nvim_lua' },
      { name = 'spell' },
      { name = 'buffer' },
    },
  }

  cmp.setup.cmdline({ '/', '?' }, {
    view = { entries = { name = 'custom', selection_order = 'near_cursor' } },
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
    view = { entries = { name = 'custom', selection_order = 'near_cursor' } },
    mapping = cmp.mapping.preset.cmdline {
      ['<tab>'] = {
        c = function(_)
          if not cmp.visible() then cmp.complete() end

          if #cmp.get_entries() == 1 then
            cmp.confirm({ select = true })
          else
            cmp.select_next_item()
          end
        end,
      },
    },
    sources = cmp.config.sources {
      { name = 'path', options = { trailing_slash = false } },
      { name = 'cmdline', option = { ignore_cmds = {} } },
    },
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
end

return M
