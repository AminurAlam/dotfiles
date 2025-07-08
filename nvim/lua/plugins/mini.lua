---@module "lazy"
---@type LazyPluginSpec[]
return {
  { 'echasnovski/mini.files', enabled = false, version = false },
  {
    'echasnovski/mini.splitjoin',
    enabled = false,
    version = false,
    keys = { '<leader>j' },
    opts = { mappings = { toggle = '<leader>j' } },
  },
  {
    'echasnovski/mini.bracketed',
    keys = { '[', ']' },
    version = false,
    opts = {
      buffer = { suffix = 'b', options = {} },
      comment = { suffix = 'c', options = {} },
      indent = { suffix = 'i', options = {} },
      jump = { suffix = 'j', options = {} },
      oldfile = { suffix = 'o', options = {} },
      quickfix = { suffix = 'q', options = {} },
      treesitter = { suffix = 't', options = {} },
      window = { suffix = 'w', options = {} },
      -- disabled
      undo = { suffix = '', options = {} },
      yank = { suffix = '', options = {} },
      conflict = { suffix = '', options = {} },
      diagnostic = { suffix = 'd', options = {} },
      file = { suffix = '', options = {} },
      location = { suffix = '', options = {} },
    },
  },
}
