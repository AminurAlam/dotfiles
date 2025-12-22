require('mini.completion').setup({
  delay = { completion = 30, info = 100, signature = 50 },
  window = {
    info = { height = 25, width = 80, border = 'rounded' },
    signature = { height = 25, width = 80, border = 'rounded' },
  },
  lsp_completion = {
    source_func = 'omnifunc', -- `source_func` should be one of 'completefunc' or 'omnifunc'.
    auto_setup = false,
    process_items = function(args)
      for i, _ in ipairs(args) do
        args[i].labelDetails = ''
      end

      return args
    end,
  },
  mappings = {},
})

local imap_expr = function(lhs, rhs)
  vim.keymap.set('i', lhs, rhs, { expr = true })
end
imap_expr('<Tab>', [[pumvisible() ? "\<C-n>" : "\<Tab>"]])
imap_expr('<S-Tab>', [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]])

lsp_icons = {
  Array = '',
  Boolean = '󰔡',
  Enummember = '',
  Key = '󰌋',
  Namespace = '',
  Null = '',
  Number = '󰎠',
  Object = '',
  Package = '',
  String = '󰀬',
  Typeparameter = '',

  Text = '',
  Method = '󰊕',
  Function = '󰊕',
  Constructor = '󰒓',

  Field = '',
  Variable = '󰂡',
  Property = '󰜢',

  Class = '󰠱',
  Interface = '',
  Struct = '',
  Module = '',

  Unit = '',
  Value = '󰎠',
  Enum = '',
  EnumMember = '',

  Keyword = '󰌋',
  Constant = '󰏿',

  Snippet = '',
  Color = '󰏘',
  File = '󰈙',
  Reference = '',
  Folder = '󰉋',
  Event = '',
  Operator = '󰆕',
  TypeParameter = '',
}

local protocol = vim.lsp.protocol
for i, kind in ipairs(protocol.CompletionItemKind) do
  protocol.CompletionItemKind[i] = lsp_icons[kind] or '󰞋'
end
for i, kind in ipairs(protocol.SymbolKind) do
  protocol.SymbolKind[i] = lsp_icons[kind] or '󰞋'
end
