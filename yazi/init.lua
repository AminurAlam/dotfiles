---@diagnostic disable: duplicate-set-field

-- shorter header cwd
function Header:cwd()
  local max = self._area.w - self._right_width
  if max <= 0 then
    return ''
  end

  local s = tostring(ya.readable_path(tostring(self._current.cwd))):gsub(
    '(%.?)([^/])[^/]+/',
    '%1%2/'
  ) .. self:flags()
  return ui.Span(ya.truncate(s, { max = max, rtl = true })):style(th.mgr.cwd)
end

-- show remaining storage
--[[
Header:children_add(function()
  local main = (ya.target_family() == 'android') and '/storage/emulated' or '/home'
  return os.execute(string.format("df -h '%s' | tail -n1 | awk '{print $4}'", main))
end, 500, Header.RIGHT) --]]

-- put progress in header
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

-- smaller progress layout
function Progress:layout()
  self._area = ui.Rect {
    x = math.max(0, self._area.w - self._offset - 5),
    y = self._area.y,
    w = ya.clamp(0, self._area.w - self._offset, 4),
    h = math.min(1, self._area.h),
  }
end

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

-- turn off statusline
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

-- start with cut if xdg-desktop-portal-termfilechooser
require('topaste'):setup {}

-- start with zoxide if launching as fileManager
if ya.id('app').value == 48937 then
  ya.emit('plugin', { 'zoxide' })
else
  require('session'):setup { sync_yanked = true }
end

-- plugins

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
require('git'):setup()

require('fchar'):setup {
  insensitive = true,
  keep_searching = { enable = false, limit = 10 },
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

require('spot'):setup {
  height = 25,
  width = 70,
  render_metadata = true,
  render_plugins = true,
}

require('font-sample'):setup {
  canvas_size = '750x800',
  font_size = 60,
  bg = 'white',
  fg = 'black',
}

require('sort-by-location'):setup({
  { pattern = '.*/Pictures/.*', sort = { 'mtime', reverse = true } },
})
