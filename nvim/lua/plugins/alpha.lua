local M = { 'goolord/alpha-nvim' }

M.config = function()
  local v = vim.version()
  local scratch = '<cmd>enew <bar> setl bt=nofile bh=hide <bar>'

  local button = function(sc, text, keybind, icon_hl)
    return {
      type = 'button',
      val = text,
      on_press = function() vim.api.nvim_feedkeys(vim.keycode(keybind or sc), 't', false) end,
      opts = {
        position = 'center',
        shortcut = '[' .. sc .. ']',
        cursor = 48,
        width = 50,
        align_shortcut = 'right',
        hl = { { icon_hl or 'Normal', 0, 2 }, { 'Directory', 2, 47 } },
        hl_shortcut = { { 'Number', 1, 2 } },
        keymap = { 'n', sc, keybind, { noremap = true, silent = true, nowait = true } },
      },
    }
  end

  local oldfiles = function()
    local of_buttons = {}
    for _, filename in pairs(vim.v.oldfiles) do
      if vim.fn.filereadable(filename) == 0 then goto continue end
      local len = #of_buttons + 1
      if len == 6 then break end
      table.insert(
        of_buttons,
        button(tostring(len), vim.fn.fnamemodify(filename, ':~'), '<cmd>e ' .. filename .. ' <cr>', 'Directory')
      )
      ::continue::
    end
    return of_buttons
  end

  vim.api.nvim_set_hl(0, 'AlphaIconTemp', { fg = '#fff3d7' })

  require('alpha').setup {
    layout = {
      {
        type = 'text',
        val = {
          '',
          '',
          '',
          [[                               __                ]],
          [[  ___      __    ___   __  __ /\_\    ___ ___    ]],
          [[/' _ `\  /'__`\ / __`\/\ \/\ \\/\ \ /' __` __`\  ]],
          [[/\ \/\ \/\  __//\ \L\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
          [[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
          [[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
          string.format('%33s v%d.%d.%d-%s', ' ', v.major, v.minor, v.patch, (v.prerelease and 'dev' or 'stable')),
        },
        opts = { position = 'center', hl = 'Type' },
      },
      { type = 'padding', val = 3 },
      button('f', '  Find file', '<cmd>Telescope find_files<cr>'),
      button('g', '  Find word', '<cmd>Telescope live_grep<cr>'),
      button('h', '  Find help', '<cmd>Telescope help_tags<cr>'),
      button('i', '󱇨  New file', scratch .. 'startinsert<cr>'),
      button('p', '󰆒  Paste in NF', scratch .. ' norm "*pi<cr>'),
      button('u', '󰚰  Update plugins', '<cmd>Lazy update<cr>', ''),
      button('q', '󰗼  Quit', '<cmd>qa<cr>', 'Error'),
      { type = 'padding', val = 2 },
      button('d', '  dotfiles', '<cmd>cd ~/repos/dotfiles/ | Telescope find_files<cr>', 'Comment'),
      button('n', '  notes', '<cmd>cd /sdcard/main/notes/ | Telescope find_files<cr>', 'Title'),
      { type = 'padding', val = 2 },
      { type = 'group', val = oldfiles },
    },
    opts = { setup = function() vim.opt_local.stl = '%#Normal#' end },
  }
end

return M
