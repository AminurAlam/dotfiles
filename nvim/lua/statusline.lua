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
  ['nt'] = 'N-TERM',
  ['no'] = 'O-PENDING',
  ['o'] = 'O-PENDING',
  ['v'] = 'VISUAL',
  ['V'] = 'V-LINE',
  ['\22'] = 'V-BLOCK',
  ['s'] = 'SELECT',
  ['S'] = 'S-LINE',
  ['\19'] = 'S-BLOCK',
  ['i'] = 'INSERT',
  ['ic'] = 'INSERT',
  ['r'] = 'REPLACE',
  ['R'] = 'REPLACE',
  ['c'] = 'COMMAND',
  ['rm'] = 'MORE',
  ['r?'] = 'CONFIRM',
  ['!'] = 'SHELL',
  ['t'] = 'TERMINAL',
}
local hl = vim.api.nvim_set_hl
hl(0, 'stl_hl_a', { fg = '#30354A', bg = '#98c379', bold = true })
hl(0, 'stl_hl_b', { bg = '#30354A', fg = '#98c379', bold = false })
hl(0, 'stl_hl_to', { fg = '#30354A', bg = 'NONE', bold = false })

vim.g.stl = {
  mode = function()
    local mode = vim.api.nvim_get_mode().mode
    return mode_names[mode] or mode
  end,
  bufcount = function()
    local count = #vim.fn.getbufinfo { buflisted = 1 }
    return count == 1 and '' or count .. ' '
  end,
  hlsearch = function() -- https://github.com/nvim-lualine/lualine.nvim/pull/1088
    local ok, sc = pcall(vim.fn.searchcount, { timeout = 20 })
    if not ok or next(sc) == nil then
      return ''
    end
    return string.format('[%d/%d]', sc.current or 0, sc.total or 0)
  end,
}

vim.api.nvim_create_autocmd({ 'ModeChanged' }, {
  pattern = '*',
  callback = function(_)
    local mode_color = mode_colors[vim.v.event.new_mode]
    hl(0, 'stl_hl_a', { bg = mode_color, fg = '#30354A', bold = true })
    hl(0, 'stl_hl_b', { fg = mode_color, bg = '#30354A' })
  end,
})

vim.opt.stl = '%#stl_hl_a# %{ g:stl.mode() } %#stl_hl_b# ' -- a to b
    .. '%{ g:stl.bufcount() }%t '
    .. '%{ &modified ? "󰆓 " : "" }'
    -- .. '%{ &cb == "unnamedplus" ? "󰆒 " : "" }'
    .. '%{ &spell ? "󰓆 " : "" }'
    .. '%{ &readonly ? "󰌾 " : "" }'
    .. [[%{ search("\\s\\+$", "nwc") > 0 ? "󱁐 " : "" }]]
    .. [[%{ search("^\\t\\+", "nwc") > 0 ? " " : "" }]]
    .. '%#stl_hl_to#%#Normal# ' -- b to c
    .. '%{% get(b:, "minidiff_summary_string", "") %} '
    ..
    [[%{% luaeval('(package.loaded[''vim.diagnostic''] and next(vim.diagnostic.count()) and vim.diagnostic.status() .. '' '') or '''' ') %}]]
    .. '%#Normal#%=%S ' -- middle seperator
    ..
    "%{% luaeval('(package.loaded[''vim.ui''] and vim.api.nvim_get_current_win() == tonumber(vim.g.actual_curwin or -1) and vim.ui.progress_status()) or '''' ')%}"
    .. '%{ v:hlsearch ? g:stl.hlsearch() : "" } '
    .. '%{ reg_recording() != "" ? " " .. reg_recording() : "" } '
    .. '%#stl_hl_to#%#stl_hl_b# ' -- c to b
    .. '%P '
    .. '%#stl_hl_a#' -- b to a
    .. "%{% &busy > 0 ? '◐ ' : '' %}"
    .. '%{ &fenc == "utf-8" ? "" : " " .. &fenc }'
    .. '%{ &fileformat == "dos" ? "  " : "" } %Y '
