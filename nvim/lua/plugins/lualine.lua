local M = {
  'https://github.com/nvim-lualine/lualine.nvim',
  enabled = false,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
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
        symbols = { modified = '󰆓', readonly = '󰌾', unnamed = '' },
      },
      {
        function() return '󱁐 ' end,
        cond = function() return vim.fn.search([[\s\+$]], 'nwc') ~= 0 end,
        padding = 0,
      },
      {
        function() return ' ' end,
        cond = function() return #vim.fn.finddir('.git', vim.fn.expand('%:p:h') .. ';') > 0 end,
        padding = 0,
      },
    },
    lualine_c = { { 'diff' }, { 'diagnostics', update_in_insert = false } },
    lualine_x = {
      { '%S' },
      { 'searchcount' },
      {
        function() return '@' .. vim.fn.reg_recording() end,
        cond = function() return vim.fn.reg_recording() ~= '' end,
      },
    },
    lualine_y = { { 'progress' } },
    lualine_z = {
      {
        'fileformat',
        symbols = { unix = '', dos = '', mac = '' },
      },
      { 'filetype', colored = false },
    },
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
      { filetypes = { 'alpha', 'lazy', 'lspinfo', 'TelescopePrompt' }, sections = {} },
      {
        filetypes = { 'man', 'help', 'article' },
        sections = {
          lualine_a = { { 'filename', symbols = { readonly = '' } } },
          lualine_x = { { 'searchcount' } },
          lualine_z = { { 'progress' } },
        },
      },
    },
  }
end

return M
