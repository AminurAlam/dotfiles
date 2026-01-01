---@diagnostic disable: duplicate-set-field

local trunc = ui.truncate and ui.truncate or ya.truncate

------------------ LAYOUT ---------------

do -- [=[ shorter header cwd
  function Header:cwd()
    local max = self._area.w - self._right_width

    if max <= 0 then
      return ''
    end

    if #cx.tabs > 1 then
      return ui.Span(trunc(self:flags(), { max = max, rtl = true })):style(th.mgr.cwd)
    end

    local s = tostring(ya.readable_path(tostring(self._current.cwd))):gsub(
      '(%.?)([^/])[^/]+/',
      '%1%2/'
    ) .. self:flags()
    return ui.Span(trunc(s, { max = max, rtl = true })):style(th.mgr.cwd)
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
      spans[#spans + 1] = ui.Span(' ' .. trunc(path, { max = 20, rtl = true }) .. ' ')
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
      ui.Line(right):area(self._area):align(ui.Align.RIGHT),
      table.unpack(ui.redraw(Progress:new(self._area, self._right_width))),
    }
  end
  --]=]
end

do -- [=[ smaller progress layout
  function Progress:layout()
    self._area = ui.Rect {
      x = math.max(0, self._area.w - self._offset - 5),
      y = self._area.y,
      w = ya.clamp(0, self._area.w - self._offset, 4),
      h = math.min(1, self._area.h),
    }
  end

  -- [[
  function Progress:redraw()
    -- ya.dbg(cx.tasks.summary, cx.tasks.progress)
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

    -- return gauge:percent(percent):label(ui.Span(label):style(th.status.progress_label))
    return ui.Line(label):area(self._area):fg('white'):bg('blue')
    -- :bg(th.status[progress.failed == 0 and 'progress_normal' or 'progress_error'].fg)
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

------------------ STARTUP ---------------

-- start with zoxide if launching as fileManager
if os.getenv('YAZI_START_PICKING') then
  ya.emit('plugin', { 'zoxide' })
else
  require('session'):setup { sync_yanked = true }
end

-- git icon theming
th.git = {
  modified = ui.Style():fg('red'),
  modified_sign = 'M',
  added = ui.Style():fg('green'),
  added_sign = 'A',
  untracked = ui.Style():fg('red'),
  untracked_sign = '?',
  ignored_sign = 'I',
  deleted_sign = 'D',
  updated_sign = 'U',
}

------------------ PLUGIN ---------------

require('git'):setup {}

require('topaste'):setup {}

require('sort-by-location'):setup {
  { pattern = '.*/Pictures/.*', sort = { by = 'mtime', reverse = true } },
  { pattern = '.*/DCIM/.*', sort = { by = 'mtime', reverse = true } },
}

require('spot'):setup {
  height = 25,
  width = 70,
  plugins_section = { enable = true },
  metadata_section = {
    -- hash_cmd = 'md5sum', -- other hashing commands can be slower
    hash_filesize_limit = 100, -- in MB, set 0 to disable
  },
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
  skip_prefix = { 'yazi-', 'spot-', 'preview-', 'dot-', 'WhatsApp ' },
  search_location = 'start',
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
