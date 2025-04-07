return {
  {
    'saghen/blink.compat',
    version = '*',
    lazy = true,
    opts = {},
  },
  {
    'https://github.com/saghen/blink.cmp', -- https://cmp.saghen.dev/
    enabled = true,
    event = { 'CmdlineEnter', 'InsertEnter' },
    dependencies = {
      'AminurAlam/friendly-snippets',
      dev = vim.uv.fs_stat(vim.fn.expand('~/repos/friendly-snippets')) and true or false,
    }, -- provides multiple snippets
    version = '*',
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        preset = 'none',
        ['<tab>'] = { 'select_next', 'fallback' },
        ['<s-tab>'] = { 'select_prev', 'fallback' },
        ['<C-e>'] = { 'cancel' },
        ['<C-y>'] = { 'select_and_accept' },
        -- ['<cr>'] = { 'accept', 'fallback' },
        ['<C-space>'] = { function(cmp) cmp.show({ providers = { 'snippets' } }) end },
        ['<C-n>'] = { 'select_next' },
        ['<C-p>'] = { 'select_prev' },
      },
      sources = {
        -- TODO: cmp-fish
        -- TODO: sorting
        default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
        providers = {
          lazydev = {
            name = 'LazyDev',
            module = 'lazydev.integrations.blink',
            score_offset = 100, -- make lazydev completions top priority (see `:h blink.cmp`)
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
            score_offset = 50,
          },
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
          auto_show = true,
          auto_show_delay_ms = 0,
          window = { border = 'rounded' },
        },
        keyword = { range = 'prefix' },
        accept = { auto_brackets = { enabled = false } },
        list = { selection = { preselect = false, auto_insert = true } },
        ghost_text = { enabled = true },
      },
      fuzzy = {
        implementation = 'prefer_rust_with_warning',
        use_frecency = true,
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
        completion = {
          menu = {
            auto_show = true,
            draw = { columns = { { 'label', 'label_description', gap = 0 } } },
          },
          list = { selection = { preselect = false, auto_insert = true } },
        },
        keymap = {
          preset = 'none',
          ['<tab>'] = { 'select_next', 'fallback' },
          ['<s-tab>'] = { 'select_prev', 'fallback' },
          ['<C-e>'] = { 'cancel' },
          ['<C-y>'] = { 'select_and_accept' },
          ['<C-n>'] = { 'select_next' },
          ['<C-p>'] = { 'select_prev' },
        },
      },
    },
    opts_extend = { 'sources.default' },
  },
}
