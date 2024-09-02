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
  ['r'] = 'REPLACE',
  ['R'] = 'REPLACE',
  ['c'] = 'COMMAND',
  ['rm'] = 'MORE',
  ['r?'] = 'CONFIRM',
  ['!'] = 'SHELL',
  ['t'] = 'TERMINAL',
}
local buflogo = { [0] = '', '', '二 ', '三 ', '四 ', '五 ', '六 ', '七 ', '八 ', '九' }
local hl = vim.api.nvim_set_hl
local secondary = '#30354A'

vim.g.stl = {
  lsp_count = function() return #vim.lsp.get_clients() end,
  mode = function() return mode_names[vim.api.nvim_get_mode().mode] or '???' end,
  bufcount = function() return buflogo[#vim.fn.getbufinfo { buflisted = 1 }] or '十 ' end,
  hlsearch = function() -- https://github.com/nvim-lualine/lualine.nvim/pull/1088
    local ok, sc = pcall(vim.fn.searchcount, { maxcount = 99, timeout = 20 })
    if not ok then return '' end
    return string.format('[%d/%d]', sc.current, sc.total)
  end,
  progress = function(current, total)
    if current == 1 then
      return 'Top'
    elseif current == total then
      return 'End'
    end

    return string.format('%2d%%', math.floor(current / total * 100))
  end,
  diagnostics = function()
    local count = function(severity) return #vim.diagnostic.count(0, { severity = vim.diagnostic.severity[severity] }) end

    return (count 'ERROR' > 0 and '%#DiagnosticError# ' or '')
      .. (count 'WARN' > 0 and '%#DiagnosticWarn# ' or '')
      .. (count 'HINT' > 0 and '%#DiagnosticHint#󰌶 ' or '')
  end,
}

vim.api.nvim_create_autocmd({ 'ModeChanged' }, {
  pattern = '*',
  callback = function(_)
    local mode_color = mode_colors[vim.v.event.new_mode] -- mode_colors[vim.api.nvim_get_mode().mode]
    hl(0, 'stl_hl_a', { bg = mode_color, fg = secondary, bold = true })
    hl(0, 'stl_hl_b', { fg = mode_color, bg = secondary })
  end,
})

vim.api.nvim_create_autocmd({ 'FileType' }, {
  desc = 'turn off statusline',
  pattern = { 'TelescopePrompt', 'alpha' },
  command = 'setlocal statusline=%#Normal#',
})

hl(0, 'stl_hl_a', { bg = mode_colors.n, fg = secondary, bold = true })
hl(0, 'stl_hl_b', { fg = mode_colors.n, bg = secondary })
hl(0, 'stl_hl_to', { fg = secondary })

vim.opt.stl = '%#stl_hl_a# %{ g:stl.mode() } %#stl_hl_b#' -- a to b
  .. ' %{ g:stl.bufcount() }%t '
  .. '%{ &modified ? "󰆓 " : "" }'
  .. '%{ !empty(finddir(".git", expand("%:p:h") .. ";")) ? " " : "" }'
  -- .. '%{ &cb == "unnamedplus" ? "󰆒 " : "" }'
  .. '%{ &spell ? "󰓆 " : "" }'
  .. '%{ &readonly ? "󰌾 " : "" }'
  .. [[%{ search("\\s\\+$", "nwc") > 0 ? "󱁐 " : "" }]]
  .. '%#stl_hl_to#%#Normal# ' -- b to c
  .. '%{% g:stl.diagnostics() %}'
  .. '%{% get(b:, "gitsigns_status", "") %}'
  .. '%#Normal#%=%S ' -- middle seperator
  .. '%{ v:hlsearch ? g:stl.hlsearch() : "" } '
  .. '%{ g:stl.lsp_count() }'
  .. '%{ reg_recording() != "" ? " " .. reg_recording() : "" } '
  .. '%#stl_hl_to#%#stl_hl_b# ' -- c to b
  .. '%{ g:stl.progress(line("."), line("$")) } '
  .. '%#stl_hl_a#' -- b to a
  .. '%{ &fenc == "utf-8" ? "" : " " .. &fenc }'
  .. '%{ &fileformat == "dos" ? "  " : "" } %Y '
