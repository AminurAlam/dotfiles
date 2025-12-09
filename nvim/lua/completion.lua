local loaded, blink = pcall(require, 'blink-cmp')
if not loaded then
  return
end

-- TODO: disable auto popup
blink.setup {
  keymap = {
    preset = 'none',
    ['<tab>'] = { 'select_next', 'fallback' },
    ['<s-tab>'] = { 'select_prev', 'fallback' },
    ['<C-e>'] = { 'cancel' },
    ['<C-y>'] = { 'select_and_accept' },
    ['<C-space>'] = {
      function(cmp)
        cmp.show({ providers = { 'snippets' } })
      end,
    },
    ['<C-n>'] = { 'select_next' },
    ['<C-p>'] = { 'select_prev' },
  },
  sources = {
    default = { 'path', 'lsp', 'snippets', 'buffer' },
    per_filetype = {
      lua = { inherit_defaults = true, 'lazydev' },
      fish = { inherit_defaults = true, 'fish' },
    },
    providers = {
      lazydev = {
        name = 'LazyDev',
        module = 'lazydev.integrations.blink',
        -- score_offset = 100, -- make lazydev completions top priority (see `:h blink.cmp`)
      },
      path = {
        opts = {
          trailing_slash = false,
          label_trailing_slash = true,
          show_hidden_files_by_default = true,
        },
      },
      snippets = {
        opts = {
          friendly_snippets = true,
          search_paths = { vim.fn.stdpath('config') .. '/snippets' },
          global_snippets = {},
          extended_filetypes = {},
          ignored_filetypes = {},
          -- Set to '+' to use the system clipboard, or '"' to use the unnamed register
          clipboard_register = nil,
        },
      },
      fish = { name = 'fish', module = 'blink.compat.source', min_keyword_length = 0, opts = {} },
      buffer = { opts = { get_bufnrs = vim.api.nvim_list_bufs } },
    },
  },
  completion = {
    menu = {
      auto_show = true,
      border = 'rounded',
      draw = {
        columns = {
          { 'label', 'label_description', gap = 1 },
          { 'kind_icon' },
        },
      },
    },
    documentation = {
      auto_show = false,
      auto_show_delay_ms = 0,
      window = { border = 'rounded' },
    },
    keyword = { range = 'prefix' },
    accept = { auto_brackets = { enabled = false } },
    list = { selection = { preselect = false, auto_insert = true } },
    ghost_text = { enabled = false },
  },
  fuzzy = {
    implementation = 'lua',
    frecency = { enabled = true },
    use_proximity = false,
    sorts = { 'score', 'sort_text' },
  },
  appearance = {
    use_nvim_cmp_as_default = false,
    nerd_font_variant = 'mono',
    kind_icons = {
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
    },
  },
  signature = { enabled = true, window = { border = 'rounded' } },
  snippets = { preset = 'default' },
  cmdline = {
    enabled = false,
    completion = {
      menu = {
        auto_show = true,
        draw = { columns = { { 'label', 'label_description', gap = 0 } } },
      },
      list = { selection = { preselect = false, auto_insert = true } },
    },
    keymap = {
      preset = 'inherit',
      ['<tab>'] = { 'select_next', 'fallback' },
      ['<s-tab>'] = { 'select_prev', 'fallback' },
      ['<C-e>'] = { 'cancel' },
      ['<C-y>'] = { 'select_and_accept' },
      ['<C-n>'] = { 'select_next' },
      ['<C-p>'] = { 'select_prev' },
    },
  },
}
--]]
