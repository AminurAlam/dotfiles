local M = {
  'goolord/alpha-nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
}

M.config = function()
  local utils = require('core.utils')
  local dev_icon = require('nvim-web-devicons')
  local scratch = '<cmd>enew <bar> setlocal buftype=nofile bufhidden=hide <bar>'
  local rep = ' | AlphaRedraw | Telescope find_files hidden=true<cr>'

  local banner = {
    [[                               __                ]],
    [[  ___      __    ___   __  __ /\_\    ___ ___    ]],
    [[/' _ `\  /'__`\ / __`\/\ \/\ \\/\ \ /' __` __`\  ]],
    [[/\ \/\ \/\  __//\ \L\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
    [[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
    [[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
  }

  local details = function()
    local v = vim.version()
    return string.format(
      '%s | v%s-%s',
      utils.fish_path(vim.fn.getcwd()),
      v.major .. '.' .. v.minor .. '.' .. v.patch,
      (v.prerelease and 'dev' or 'stable')
    )
  end

  local rsplit = function(str, sep)
    local parts = vim.fn.split(str, sep) ---@type table
    return parts[#parts] ---@type string
  end

  local button = function(sc, text, keybind, icon_hl)
    return {
      type = 'button',
      val = text,
      on_press = function()
        local key = vim.api.nvim_replace_termcodes(keybind or sc .. '<Ignore>', true, false, true)
        vim.api.nvim_feedkeys(key, 't', false)
      end,
      opts = {
        position = 'center',
        shortcut = '[' .. sc .. ']',
        cursor = 3,
        width = 50,
        align_shortcut = 'right',
        hl = { { icon_hl or 'Normal', 0, 3 }, { 'Directory', 4, 47 } },
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
      local icon, hl = dev_icon.get_icon(rsplit(filename, '/'), rsplit(filename, '\\.'))
      filename = vim.fn.fnamemodify(filename, ':~')
      -- stylua: ignore
      table.insert(of_buttons, button(
        tostring(len),
        (icon or '') .. '  ' .. utils.fish_path(filename),
        '<cmd>e ' .. filename .. ' <cr>',
        hl
      ))
      ::continue::
    end
    return of_buttons
  end

  vim.api.nvim_set_hl(0, 'AlphaIconImg', { fg = '#a074c4' })
  vim.api.nvim_set_hl(0, 'AlphaIconTemp', { fg = '#fff3d7' })

  require('alpha').setup {
    layout = {
      { type = 'padding', val = 3 },
      { type = 'text', val = banner, opts = { position = 'center', hl = 'Type' } },
      { type = 'padding', val = 1 },
      { type = 'text', val = details, opts = { position = 'center' } },
      { type = 'padding', val = 1 },
      button('f', '  Find file', '<cmd>Telescope find_files hidden=true<cr>'),
      button('g', '  Find word', '<cmd>Telescope live_grep<cr>'),
      button('h', '  Find help', '<cmd>Telescope help_tags<cr>'),
      button('i', '󱇨  New file', scratch .. 'startinsert<cr>'),
      button('p', '󰆒  Paste in NF', scratch .. ' norm pi<cr>'),
      button('u', '󰚰  Update plugins', '<cmd>Lazy update<cr>'),
      button('q', '󰗼  Quit', '<cmd>qa<cr>'),
      { type = 'padding', val = 1 },
      { type = 'group', val = oldfiles },
      { type = 'padding', val = 1 },
      button('6', '  ~/r/dotfiles/', '<cmd>cd ~/repos/dotfiles/' .. rep, 'Comment'),
      button('7', '  /s/m/notes/', '<cmd>cd /sdcard/main/notes/' .. rep, 'Title'),
      button('8', '  ~/r/musicbrainzpy/', '<cmd>cd ~/repos/musicbrainzpy/ ' .. rep, 'AlphaIconImg'),
      button('9', '󰖝  ~/.l/temp/', '<cmd>cd ~/.local/cache/temp/ ' .. rep, 'AlphaIconTemp'),
    },
  }
end

return M
