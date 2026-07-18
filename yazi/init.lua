---@diagnostic disable: duplicate-set-field

------------------ LAYOUT ---------------

do -- [=[ shorter header cwd or tabs
  function Header:cwd()
    local max = self._area.w - self._right_width

    if max <= 0 then
      return ''
    end

    if #cx.tabs > 1 then
      return ui.Span(ui.truncate(self:flags(), { max = max, rtl = true })):style(th.mgr.cwd)
    end

    -- local s = tostring(ya.readable_path(tostring(self._current.cwd))):gsub(
    --   '(%.?)([^/])[^/]+/',
    --   '%1%2/'
    -- ) .. self:flags()
    local s = ya.readable_path(tostring(self._current.cwd))
    return ui.Span(ui.truncate(s, { max = max, rtl = true })):style(th.mgr.cwd)
  end

  --]=]
end

do -- [=[ hide fchar regex
  function Header:flags()
    local cwd = self._current.cwd
    local filter = self._current.files.filter
    local finder = self._tab.finder

    local t = {}
    if cwd.is_search then
      t[#t + 1] = string.format('search: %s', cwd.domain)
    end
    if filter then
      t[#t + 1] = string.format('filter: %s', filter)
    end
    if finder and not string.find(tostring(finder), 'preview') then
      t[#t + 1] = string.format('find: %s', finder)
    end
    return #t == 0 and '' or ' (' .. table.concat(t, ', ') .. ')'
  end

  --]=]
end

do --[=[ show remaining storage
  Header:children_add(function()
    local now = ya.time()
    local main = (ya.target_family() == 'android') and '/storage/emulated' or os.getenv('HOME')
    local url = cx.active.current.cwd
    local it = fs.calc_size(url)
    local size = 0

    while true do
      local next = it:recv()
      if next then
        size = size + next
      else
        break
      end
    end

    -- local op = fs.op('size', { url = url.parent, sizes = { [url.urn] = self.size } })
    -- ya.emit('update_files', { op = op })

    return tostring(url)
  end, 500, Header.RIGHT)
  --]=]
end

do -- [=[ put tabs in header
  function Tabs.height()
    return 0
  end

  Header:children_add(function()
    if #cx.tabs <= 1 then
      return ''
    end

    local active = ui.Style():fg('black'):bg('white')
    local inactive = ui.Style():fg('white'):bg('black')
    local spans = {}

    for i = 1, #cx.tabs do
      local path = tostring(ya.readable_path(cx.tabs[i].name)):gsub('(%.?)([^/])[^/]+/', '%1%2/')

      spans[#spans + 1] = ui.Span(' ' .. i .. ' ')
        :style(i == cx.tabs.idx and th.tabs.active or th.tabs.inactive)
      spans[#spans + 1] = ui.Span(' ' .. ui.truncate(path, { max = 20, rtl = true }) .. ' ')
        :style(i == cx.tabs.idx and active or inactive)
      spans[#spans + 1] = ' '
    end

    return ui.Line(spans)
  end, 500, Header.LEFT)
  --]=]
end

do -- [=[ put progress in header
  function Header:redraw()
    local right = self:children_redraw(self.RIGHT)
    self._right_width = right:width()

    local left = self:children_redraw(self.LEFT)

    return {
      ui.Line(left):area(self._area),
      ui.Line(right):align(ui.Align.RIGHT):area(self._area),
      table.unpack(ui.redraw(Progress:new(self._area, self._right_width))),
    }
  end

  --]=]
end

do --[=[ smaller progress layout
  function Progress:layout()
    self._area = ui.Rect {
      x = math.max(0, self._area.w - self._offset - 5),
      y = self._area.y,
      w = ya.clamp(0, self._area.w - self._offset, 4),
      h = 1,
    }
  end

  -- [[
  function Progress:redraw()
    local summary = cx.tasks.summary
    if summary.total == 0 then
      return {}
    end

    local label, percent = '', summary.percent
    if percent then
      label = string.format('%3d%%', math.floor(percent))
    else
      label = string.format('%3d', string.format('%d', summary.total))
    end

    return ui.Line(label)
      :style(th.status[summary.failed == 0 and 'progress_normal' or 'progress_error'])
      :area(self._area)
  end
  --]]

  --[[
  function Progress:redraw()
    local progress = cx.tasks.progress
    if progress.total == 0 then
      return {}
    end

    return ui.Line(string.format('%3d', progress.total))
      :area(self._area)
      :fg(th.status.progress_label.fg)
      :bg(th.status[progress.fail == 0 and 'progress_normal' or 'progress_error'].fg)
  end
  --]]
  --]=]
end

do -- [=[ turn off statusline
  local old_layout = Tab.layout

  Status.redraw = function()
    return {}
  end

  Tab.layout = function(self, ...)
    self._area = ui.Rect {
      x = self._area.x,
      y = self._area.y,
      w = self._area.w,
      h = self._area.h + 1,
    }
    return old_layout(self, ...)
  end
  --]=]
end

do -- [=[ turn off fancy rounded corners
  function Entity:padding()
    return ' '
  end

  function Linemode:padding()
    return ' '
  end

  --]=]
end

do -- [=[ fix drag making hidden pannel reappear
  function Rail:drag(event)
    if event.type ~= 'legacy' then
      return
    end

    local c, x, parent, current, preview = self._chunks, 0, 0, 0, 0
    if self._id == 'rail-left' then
      x = math.min(event.x, c[2].right - 2)
      parent = math.max(1, x - c[1].x)
      current = math.max(1, c[1].w + c[2].w - parent)
      -- preview = math.max(1, c[3].w)
      preview = c[3].w > 0 and math.max(1, c[3].w) or 0
    else
      x = math.max(event.x, c[2].x + 2)
      preview = math.max(1, c[3].right - x)
      current = math.max(1, c[2].w + c[3].w - preview)
      -- parent = math.max(1, c[1].w)
      parent = c[1].w > 0 and math.max(1, c[1].w) or 0
    end

    local r = rt.mgr.ratio
    if r.parent ~= parent or r.current ~= current or r.preview ~= preview then
      rt.mgr.ratio = { parent, current, preview }
      ui.render()
    end
  end

  -- ]=]
end

------------------ KEYBINDS ---------------

if km then
  ---@param key string|string[]
  ---@param action string|string[]
  ---@param desc string?
  local map = function(key, action, desc)
    km.mgr.rules:insert(1, { on = key, run = action, desc = desc })
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
  -- map('mgr',{ 's', 't' , 'plugin max-pane' })
  -- map('mgr','f', 'plugin fchar start' )
  map('F', 'plugin fzf')
  map('z', 'plugin zoxide')
  map('l', 'plugin smart-enter')
  map('{', 'plugin nextension bwd')
  map('}', 'plugin nextension fwd')
  map('<right>', 'plugin smart-enter')
  -- # Selection
  map('%', 'toggle_all --state=true')
  -- # Operation
  map('o', 'open --interactive')
  map('O', 'create')
  map('d', 'remove')
  map('D', 'shell --block --confirm -- fd -HI -td -d2 -x rmdir -p')
  map({ 'y', 'y' }, 'yank', 'yank file')
  map({ 'y', 'p' }, 'copy path', 'yank ENTIRE path')
  map({ 'y', 'f' }, 'copy filename', 'yank filename')
  map({ 'y', 'u' }, 'shell --confirm -- wl-copy -t text/uri-list file://%h', 'yank uri')
  map('p', { 'paste', 'unyank' })
  -- # Tabs
  map('t', { 'tab_create --current', "tab_rename ''", 'plugin zoxide' })
  map('T', 'tab_rename --interactive')
  map('<C-Left>', 'tab_switch -1 --relative')
  map('<C-Right>', 'tab_switch 1 --relative')
  -- # Help
  map('?', 'help')
  -- # rename
  if ya.target_family() == 'android' then
    map('@', 'shell --block --confirm -- rat "$0"')
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
  -- # sorting
  map({ 's', 'm' }, 'plugin sort-by-location mtime')
  map({ 's', 's' }, { 'plugin sort-by-location size', 'linemode size' })
  map({ 's', 'e' }, 'plugin sort-by-location extension')
  map({ 's', 'n' }, 'plugin sort-by-location natural')
  -- # other
  map('<C-g>', [[shell --block --confirm -- nvim +Pick\ grep_live]])
  map('<Esc>', { 'escape', 'unyank' }, 'Exit visual mode, clear selection, or cancel search')
end

------------------ PLUGIN ---------------

if rt.args.chooser_file then
  ya.emit('yank', { cut = true })
end

require('git'):setup {}

require('zoxide'):setup { update_db = false }

require('session'):setup { sync_yanked = true }

require('nextension'):setup { fwd = '}', bwd = '{' }

require('sort-by-location'):setup {
  default = { by = 'extension', reverse = false },
  { pattern = '.*/Pictures/.*', sort = { by = 'mtime', reverse = true } },
  { pattern = '.*/pic/.*', sort = { by = 'mtime', reverse = true } },
  { pattern = '.*/DCIM/.*', sort = { by = 'mtime', reverse = true } },
  { pattern = '.*/#lewd$', sort = { by = 'mtime', reverse = true } },
  { pattern = '.*/yt$', sort = { by = 'natural' } },
}

require('mime-ext.local'):setup {
  with_exts = {
    cbz = 'application/zip',
    mmd = 'text/plain',
    scm = 'text/plain',
    sql = 'text/plain',
    tex = 'text/plain',
    xml = 'text/plain',
  },
  fallback_file1 = true,
}

require('spot'):setup {
  metadata_section = { hash_filesize_limit = 100, relative_time = true },
  plugins_section = { enable = true },
}

require('font-sample'):setup {
  canvas_size = '750x800',
  font_size = 60,
  bg = 'white',
  fg = 'black',
}

require('fchar'):setup {
  insensitive = true,
  skip_symbols = true,
  skip_prefix = { 'yazi-', 'spot-', 'preview-', 'dot-', 'WhatsApp ', 'helix-', 'tree-sitter-' },
  keys = { start = 'f' },
  aliases = {
    a = 'あア',
    b = 'ばびぶべぼバビブベボ',
    c = 'ちチ',
    d = 'だぢづでどダヂヅデド',
    e = 'えエ',
    g = 'がぎぐげごガギグゲゴ',
    h = 'はひふへほハヒフヘホ',
    i = 'いイ',
    j = 'じジ',
    k = 'かきくけこカキクケコ',
    m = 'まみむめもマミムメモ',
    n = 'なにぬねのんナニヌネノン',
    o = 'おオ',
    p = 'ぱぴぷぺぽパピプペポ',
    r = 'らりるれろラリルレロ',
    s = 'さしすせそサシスセソ',
    t = 'たつてとタツテト',
    u = 'うウ',
    w = 'わをワヲ',
    y = 'やゆよヤユヨ',
    z = 'ざずぜぞザズゼゾ',
  },
}
