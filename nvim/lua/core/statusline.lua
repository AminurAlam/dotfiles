local mode_colors = {
  ['n'] = '#98c379',
  ['no'] = '#98c379',
  ['nov'] = '#98c379',
  ['noV'] = '#98c379',
  ['no\22'] = '#98c379',
  ['niI'] = '#98c379',
  ['niR'] = '#98c379',
  ['niV'] = '#98c379',
  ['nt'] = '#98c379',
  ['ntT'] = '#98c379',
  ['v'] = '#c678dd',
  ['vs'] = '#c678dd',
  ['V'] = '#c678dd',
  ['Vs'] = '#c678dd',
  ['\22'] = '#c678dd',
  ['\22s'] = '#c678dd',
  ['s'] = '#c678dd',
  ['S'] = '#c678dd',
  ['\19'] = '#c678dd',
  ['i'] = '#7aa2f7',
  ['ic'] = '#7aa2f7',
  ['ix'] = '#7aa2f7',
  ['R'] = '#e06c75',
  ['Rc'] = '#e06c75',
  ['Rx'] = '#e06c75',
  ['Rv'] = '#e06c75',
  ['Rvc'] = '#e06c75',
  ['Rvx'] = '#e06c75',
  ['c'] = '#e06c75',
  ['cv'] = '#e06c75',
  ['ce'] = '#e06c75',
  ['r'] = '#e06c75',
  ['rm'] = '#e06c75',
  ['r?'] = '#e06c75',
  ['!'] = '#56b6c2',
  ['t'] = '#56b6c2',
}

local mode_names = {
  ['n'] = 'NORMAL',
  ['no'] = 'O-PENDING',
  ['o'] = 'O-PENDING',
  ['v'] = 'VISUAL',
  ['V'] = 'V-LINE',
  ['\22'] = 'V-BLOCK',
  ['s'] = 'SELECT',
  ['S'] = 'S-LINE',
  ['\19'] = 'S-BLOCK',
  ['i'] = 'INSERT',
  ['r'] = 'REPLACE',
  ['R'] = 'REPLACE',
  ['c'] = 'COMMAND',
  ['rm'] = 'MORE',
  ['r?'] = 'CONFIRM',
  ['!'] = 'SHELL',
  ['t'] = 'TERMINAL',
}

-- local buflogo = { '', '󰼐 ', '󰼑 ', '󰼒 ', '󰼓 ', '󰼔 ', '󰼕 ', '󰼖 ', '󰼗 ' }
local buflogo = { [0] = '', '', '二 ', '三 ', '四 ', '五 ', '六 ', '七 ', '八 ', '九' }

vim.g.stl = {
  mode = function() return mode_names[vim.api.nvim_get_mode().mode] or '???' end,
  bufcount = function() return buflogo[#vim.fn.getbufinfo { buflisted = 1 }] or '十 ' end, -- 󰼘
  hlsearch = function()
    if vim.v.hlsearch == 0 then return '' end
    local sc = vim.fn.searchcount()
    return string.format('[%s/%s]', sc.current, sc.total)
  end,
  progress = function()
    local cur = vim.fn.line('.')
    local total = vim.fn.line('$')
    if cur == 1 then
      return 'Top'
    elseif cur == total then
      return 'Bot'
    end
    return string.format('%2d%%', math.floor(cur / total * 100))
  end,
  diagnostics = function()
    local errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
    local warns = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
    local hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
    return (errors > 0 and '%#DiagnosticError# ' or '')
        .. (warns > 0 and '%#DiagnosticWarning# ' or '')
        .. (hints > 0 and '%#DiagnosticHint#󰌶 ' or '')
  end,
  gitsigns = function()
    local status = vim.b.gitsigns_status_dict
    if not status then return '' end

    local added = status.added
    local changed = status.changed
    local removed = status.removed
    return (added and added > 0 and '%#GitSignsAdd# +' .. added or '')
        .. (changed and changed > 0 and '%#GitSignsChange# ~' .. changed or '')
        .. (removed and removed > 0 and '%#GitSignsDelete# -' .. removed or '')
  end,
}

vim.api.nvim_set_hl(0, 'stl_hl_bc', { fg = '#30354A' })
vim.api.nvim_set_hl(0, 'stl_hl_cb', { fg = '#30354A' })
vim.api.nvim_create_autocmd({ 'VimEnter', 'ModeChanged' }, {
  pattern = '{*}{telescopeprompt}\\@<!', -- https://overflow.smnz.de/exchange/vi/questions/42696/negate-pattern-in-autocmd
  callback = function()
    local mode_color = mode_colors[vim.api.nvim_get_mode().mode]
    vim.api.nvim_set_hl(0, 'stl_hl_a', { bg = mode_color, fg = '#30354A', bold = true })
    vim.api.nvim_set_hl(0, 'stl_hl_b', { fg = mode_color, bg = '#30354A' })
    vim.api.nvim_set_hl(0, 'stl_hl_ba', { fg = mode_color, bg = '#30354A' })
    -- vim.cmd 'redrawstatus' -- slows down :Telescope help_tags
  end,
})

vim.opt.stl = '%#stl_hl_a# %{ g:stl.mode() } %#stl_hl_b#'
  .. ' %{ g:stl.bufcount() }%t ' -- a to b
  .. '%{ &modified ? "󰆓 " : "" }'
  -- .. '%{ !empty(finddir(".git", expand("%:p:h") .. ";")) ? " " : "" }'
  .. '%{ &cb == "unnamedplus" ? "󰆒 " : "" }'
  -- .. '%{ &spell ? " " : "" }'
  .. '%{ search("\\s\\+$", "nwc") > 0 ? "󱁐 " : "" }'
  .. '%#stl_hl_bc#%#Normal# ' -- b to c
  -- .. '%{ get(b:, "gitsigns_status", "") }'
  .. '%{% g:stl.diagnostics() %}'
  .. '%{% g:stl.gitsigns() %}'
  .. '%#Normal#%=%S ' -- middle seperator
  .. '%{ g:stl.hlsearch() } '
  .. '%{ reg_recording() != "" ? "@" .. reg_recording() : "" } '
  .. '%#stl_hl_cb#%#stl_hl_b# ' -- c to b
  .. '%{ g:stl.progress() } '
  .. '%#stl_hl_ba#%#stl_hl_a#' -- b to a
  .. '%{ &fenc == "utf-8" ? "" : " " .. &fenc }'
  .. '%{ &fileformat == "dos" ? "  " : "" } %Y '
