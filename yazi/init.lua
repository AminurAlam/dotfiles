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

local pref_by_location = require('pref-by-location')
pref_by_location:setup({
  prefs = {
    -- location: String | Lua pattern (Required)
    --   - Support literals full path, lua pattern (string.match pattern): https://www.lua.org/pil/20.2.html
    --     And don't put ($) sign at the end of the location. %$ is ok.
    --   - If you want to use special characters (such as . * ? + [ ] ( ) ^ $ %) in "location"
    --     you need to escape them with a percent sign (%) or use a helper funtion `pref_by_location.is_literal_string`
    --     Example: "/home/test/Hello (Lua) [world]" => { location = "/home/test/Hello %(Lua%) %[world%]", ....}
    --     or { location = pref_by_location.is_literal_string("/home/test/Hello (Lua) [world]"), .....}

    -- sort: {}
    --   - extension: "none"|"mtime"|"btime"|"extension"|"alphabetical"|"natural"|"size"|"random", (Optional)
    --   - reverse: true|false (Optional)
    --   - dir_first: true|false (Optional)
    --   - translit: true|false (Optional)
    --   - sensitive: true|false (Optional)
    -- linemode: "none" |"size" |"btime" |"mtime" |"permissions" |"owner"
    -- show_hidden: true|false
    {
      location = '^/(home/fisher|sdcard)/Pictures/.*',
      sort = { 'mtime', reverse = true },
    },
    -- { location = '^/home/fisher', show_hidden = false },
  },
})
