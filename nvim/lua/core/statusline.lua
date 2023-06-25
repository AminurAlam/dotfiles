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
  ['v'] = 'VISUAL',
  ['vs'] = 'VISUAL',
  ['V'] = 'V-LINE',
  ['Vs'] = 'V-LINE',
  ['\22'] = 'V-BLOCK',
  ['\22s'] = 'V-BLOCK',
  ['s'] = 'SELECT',
  ['S'] = 'S-LINE',
  ['\19'] = 'S-BLOCK',
  ['i'] = 'INSERT',
  ['ic'] = 'INSERT',
  ['ix'] = 'INSERT',
  ['R'] = 'REPLACE',
  ['Rc'] = 'REPLACE',
  ['Rx'] = 'REPLACE',
  ['Rv'] = 'V-REPLACE',
  ['Rvc'] = 'V-REPLACE',
  ['Rvx'] = 'V-REPLACE',
  ['c'] = 'COMMAND',
  ['cv'] = 'EX',
  ['ce'] = 'EX',
  ['r'] = 'REPLACE',
  ['rm'] = 'MORE',
  ['r?'] = 'CONFIRM',
  ['!'] = 'SHELL',
  ['t'] = 'TERMINAL',
}

vim.g.stl = {
  mode = 'NORMAL',
  hlsearch = function()
    local sc = vim.fn.searchcount()
    if vim.v.hlsearch == 0 then return '' end
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
}

vim.api.nvim_set_hl(0, 'stl_hl_bc', { fg = '#30354A' })
vim.api.nvim_create_autocmd({ 'VimEnter', 'ModeChanged' }, {
  callback = function()
    local mode = vim.api.nvim_get_mode().mode
    local mode_color = mode_colors[mode]
    vim.api.nvim_set_hl(0, 'stl_hl_a', { bg = mode_color, fg = '#30354A', bold = true })
    vim.api.nvim_set_hl(0, 'stl_hl_b', { fg = mode_color, bg = '#30354A' })
    vim.api.nvim_set_hl(0, 'stl_hl_cx', { fg = mode_color })
    vim.g.stl.mode = mode_names[mode] or 'NORMAL'
  end,
})

vim.opt.stl = '%#stl_hl_a# %{ g:stl.mode } %#stl_hl_b# %t %{ &modified ? "󰆓 " : "" }%{ !empty(finddir(".git", expand("%:p:h") .. ";")) ? "" : "" } %#stl_hl_bc#%#Normal# %{ get(b:, "gitsigns_status", "") } %=%S %{ g:stl.hlsearch() } %{ reg_recording() != "" ? "@" .. reg_recording() : "" } %#stl_hl_cx#%#stl_hl_a# %{ g:stl.progress() } %{ &filetype } '
