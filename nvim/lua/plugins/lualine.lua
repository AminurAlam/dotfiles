local M = {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
}

M.config = function()
  local color = {
    red = '#e06c75',
    purple = '#c678dd',
    blue = '#7aa2f7',
    green = '#98c379',
    grey = '#30354A',
  }

  local theme = {
    normal = {
      a = { fg = color.grey, bg = color.green, gui = 'bold' },
      b = { fg = color.green, bg = color.grey },
      c = { bg = nil },
    },
    insert = {
      a = { fg = color.grey, bg = color.blue, gui = 'bold' },
      b = { fg = color.blue, bg = color.grey },
    },
    visual = {
      a = { fg = color.grey, bg = color.purple, gui = 'bold' },
      b = { fg = color.purple, bg = color.grey },
    },
    command = {
      a = { fg = color.grey, bg = color.red, gui = 'bold' },
      b = { fg = color.red, bg = color.grey },
    },
    replace = {
      a = { fg = color.grey, bg = color.red, gui = 'bold' },
      b = { fg = color.red, bg = color.grey },
    },
    terminal = {
      a = { fg = color.grey, bg = '#56b6c2', gui = 'bold' },
    },
  }

  local sections = {
    lualine_a = { { 'mode' } },
    lualine_b = {
      {
        'filename',
        filestatus = false,
        symbols = { modified = '', readonly = '', unnamed = '...' },
      },
      {
        function() return '␣ ' end,
        cond = function() return vim.fn.search([[\s\+$]], 'nwc') ~= 0 end,
        padding = 0,
      },
      {
        function() return ' ' end,
        cond = require('core.utils').git,
        padding = 0,
      },
    },
    lualine_c = { { 'diagnostics', update_in_insert = true } },
    lualine_x = {
      -- { '%S' }, -- https://github.com/nvim-lualine/lualine.nvim/issues/949
      { 'searchcount' },
      {
        function() return '@' .. vim.fn.reg_recording() end,
        cond = function() return vim.fn.reg_recording() ~= '' end,
      },
    },
    lualine_y = { { 'progress' } },
    lualine_z = { { 'filetype' } },
  }

  require('lualine').setup {
    options = {
      theme = theme,
      globalstatus = true,
      component_separators = { left = '', right = '' },
      section_separators = { left = '', right = '' },
    },
    sections = sections,
    extensions = {
      { filetypes = { 'lazy', 'alpha', 'lspinfo' }, sections = {} },
    },
  }
end

return M
