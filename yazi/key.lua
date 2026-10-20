---@param key string|string[]
---@param action string|string[]
---@param desc string?
local map = function(key, action, desc)
  km.mgr.rules:insert(1, { on = key, run = action, desc = desc })
end

---@param cmd string
---@return string
local sh = function(cmd)
  return 'shell --block --confirm -- ' .. cmd
end

km.help.rules:insert(1, { on = 'q', run = 'close' })
km.tasks.rules:insert(1, { on = 'q', run = 'close' })
km.spot.rules:insert(1, { on = 'q', run = 'close' })
km.input.rules:insert(1, { on = '<C-k>', run = 'recall -1' })
km.input.rules:insert(1, { on = '<C-j>', run = 'recall 1' })

-- pick
km.pick.rules:insert(1, { on = 'l', run = 'close --submit' })
km.pick.rules:insert(1, { on = '<right>', run = 'close --submit' })
km.pick.rules:insert(1, { on = '<C-m>', run = 'close --submit' })

map('g', 'arrow top', 'Move cursor to the top')
-- # plugins
map('F', 'plugin fzf')
map('z', 'plugin zoxide')
map('l', 'plugin smart-enter')
map('<right>', 'plugin smart-enter')
map({ 's', 's' }, { 'plugin sort-by-location size', 'linemode size' })
map('T', 'plugin trash')
-- # Operation
map('o', 'plugin pivot-or-open')
map('O', 'create')
map('d', 'remove')
map('D', sh 'fd -HI -td -d2 -x rmdir -p')
map({ 'y', 'y' }, 'yank', 'yank file')
map({ 'y', 'p' }, 'copy path', 'yank ENTIRE path')
map({ 'y', 'f' }, 'copy filename', 'yank filename')
map({ 'y', 'u' }, sh 'printf "file://%%s\n" %s | wl-copy -t text/uri-list', 'yank uri')
map('p', { 'paste', 'unyank' })
-- # Tabs
map('t', { 'tab_create --current', "tab_rename ''", 'plugin zoxide' })
map('<C-Left>', 'tab_switch -1 --relative')
map('<C-Right>', 'tab_switch 1 --relative')
-- # Help
map('?', 'help')
-- # rename
if ya.target_os() == 'android' then
  map('@', sh 'rat %h')
end
map('I', 'rename --cursor=start --hovered')
map('i', 'rename --cursor=before_ext --hovered')
map('a', 'rename --cursor=end --hovered')
map('r', 'rename --cursor=before_ext')
map('R', { 'toggle_all', 'rename', 'escape' })
map({ 'c', 'c' }, 'rename --empty=all')
map({ 'c', '0' }, 'rename --empty=stem --cursor=start')
map({ 'c', 'o' }, 'rename --empty=stem --cursor=start')
map({ 'c', '^' }, 'rename --empty=stem --cursor=start')
map({ 'c', '$' }, 'rename --empty=ext --cursor=end')
-- # other
map('e', sh [[$EDITOR %s]])
map('%', 'toggle_all --state=true')
map('<Esc>', { 'escape', 'unyank' }, 'Exit visual mode, clear selection, or cancel search')
