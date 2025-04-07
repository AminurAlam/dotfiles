---@diagnostic disable: undefined-global

local old_layout = Tab.layout

Status.redraw = function() return {} end
Tab.layout = function(self, ...)
  self._area = ui.Rect {
    x = self._area.x,
    y = self._area.y,
    w = self._area.w,
    h = self._area.h + 1,
  }
  return old_layout(self, ...)
end

function Header:cwd()
  local max = self._area.w - self._right_width
  if max <= 0 then return '' end

  local s = tostring(ya.readable_path(tostring(self._current.cwd))):gsub(
    '(%.?)([^/])[^/]+/',
    '%1%2/'
  ) .. self:flags()
  return ui.Span(ya.truncate(s, { max = max, rtl = true })):style(th.mgr.cwd)
end

-- require('custom-shell').setup {
--   history_path = 'default',
--   save_history = true,
-- }

require('git'):setup()
