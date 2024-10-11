return {
  'https://github.com/folke/trouble.nvim',
  enabled = true,
  keys = { { '<leader>tr', '<cmd>Trouble diagnostics<cr>' } },
  cmd = 'Trouble',
  opts = {
    auto_close = true, -- auto close when there are no items
    auto_open = false, -- auto open when there are items
    auto_preview = true, -- automatically open preview when on an item
    auto_refresh = true, -- auto refresh when open
    auto_jump = false, -- auto jump to the item when there's only one
    focus = true, -- Focus the window when opened
    restore = true, -- restores the last location in the list when opening
    follow = true, -- Follow the current item
    indent_guides = true, -- show indent guides
    max_items = 50, -- limit number of items that can be displayed per section
    multiline = false, -- render multi-line messages
    pinned = false, -- When pinned, the opened trouble window will be bound to the current buffer
    warn_no_results = true, -- show a warning when there are no results
    open_no_results = false, -- open the trouble window when there are no results
    win = {}, -- window options for the results window. Can be a split or a floating window.
    preview = { type = 'main', scratch = true }, -- Window options for the preview window. Can be a split, floating window,
    -- Throttle/Debounce settings. Should usually not be changed.
    throttle = {
      refresh = 20,
      update = 10,
      render = 10,
      follow = 100,
      preview = { ms = 100, debounce = true },
    },
    keys = {
      ['?'] = 'help',
      r = 'refresh',
      q = 'close',
      o = 'jump_close',
      ['<esc>'] = 'close',
      ['<cr>'] = 'jump_close',
      ['<2-leftmouse>'] = 'jump_close',
      -- j = "next", -- go down to next item (accepts count)
      ['}'] = 'next',
      [']]'] = 'next',
      -- k = "prev", -- go up to prev item (accepts count)
      ['{'] = 'prev',
      ['[['] = 'prev',
      i = 'inspect',
      p = 'preview',
      P = 'toggle_preview',
      zo = 'fold_open',
      zc = 'fold_close',
      za = 'fold_toggle',
      zm = 'fold_more',
      zM = 'fold_close_all',
      zr = 'fold_reduce',
      zR = 'fold_open_all',
      zx = 'fold_update_all',
      zi = 'fold_toggle_enable',
    },
    modes = {
      symbols = {
        desc = 'document symbols',
        mode = 'lsp_document_symbols',
        focus = false,
        win = { position = 'right' },
        filter = {
          -- remove Package since luals uses it for control flow structures
          ['not'] = { ft = 'lua', kind = 'Package' },
          any = {
            -- all symbol kinds for help / markdown files
            ft = { 'help', 'markdown' },
            -- default set of symbol kinds
            kind = {
              'Class',
              'Constructor',
              'Enum',
              'Field',
              'Function',
              'Interface',
              'Method',
              'Module',
              'Namespace',
              'Package',
              'Property',
              'Struct',
              'Trait',
            },
          },
        },
      },
    },
    -- stylua: ignore
    icons = {
      indent = {
        top           = "│ ",
        middle        = "├╴",
        last          = "└╴",
        -- last          = "-╴",
        -- last       = "╰╴", -- rounded
        fold_open     = " ",
        fold_closed   = " ",
        ws            = "  ",
      },
      folder_closed   = " ",
      folder_open     = " ",
      kinds = {
        Array         = " ",
        Boolean       = "󰨙 ",
        Class         = " ",
        Constant      = "󰏿 ",
        Constructor   = " ",
        Enum          = " ",
        EnumMember    = " ",
        Event         = " ",
        Field         = " ",
        File          = " ",
        Function      = "󰊕 ",
        Interface     = " ",
        Key           = " ",
        Method        = "󰊕 ",
        Module        = " ",
        Namespace     = "󰦮 ",
        Null          = " ",
        Number        = "󰎠 ",
        Object        = " ",
        Operator      = " ",
        Package       = " ",
        Property      = " ",
        String        = " ",
        Struct        = "󰆼 ",
        TypeParameter = " ",
        Variable      = "󰀫 ",
      },
    },
  },
}
