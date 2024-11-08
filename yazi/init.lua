---@diagnostic disable: undefined-global
-- tostring(cx.active.current.cwd):gsub('(%.?)([^/])[^/]+/', '%1%2/')

local old_layout = Tab.layout

Status.render = function() return {} end
Tab.layout = function(self, ...)
  self._area = ui.Rect {
    x = self._area.x,
    y = self._area.y,
    w = self._area.w,
    h = self._area.h + 1,
  }
  return old_layout(self, ...)
end

-- require('custom-shell').setup {
--   history_path = 'default',
--   save_history = true,
-- }
