return {
  'https://github.com/saghen/blink.cmp',
  enabled = false,
  {
    'AminurAlam/friendly-snippets',
    dev = vim.uv.fs_stat(vim.fn.expand('~/repos/friendly-snippets')) and true or false,
  }, -- provides multiple snippets
  version = '*',
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = { preset = 'default' },
    appearance = { use_nvim_cmp_as_default = false, nerd_font_variant = 'mono' },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
      providers = { buffer = { opts = { get_bufnrs = vim.api.nvim_list_bufs } } },
      -- cmdline = {},
    },
    signature = { enabled = true, window = { border = 'rounded' } },
    completion = {
      menu = {
        auto_show = true,
        border = 'rounded',
        draw = {
          columns = {
            { 'label', 'label_description', gap = 1 },
            { 'kind_icon', 'kind' },
          },
        },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 500,
        window = { border = 'rounded' },
      },
      keyword = { range = 'prefix' },
      accept = { auto_brackets = { enabled = false } },
      list = { selection = { preselect = true, auto_insert = true } },
      ghost_text = { enabled = true },
    },
    snippets = { preset = 'default' },
  },
  opts_extend = { 'sources.default' },
}
