---@diagnostic disable: duplicate-set-field

do -- [=[ shorter header cwd or tabs
  function Header:cwd()
    local max = self._area.w - self._right_width

    if max <= 0 then
      return ''
    end

    local dir
    if #cx.tabs > 1 then
      dir = self:flags()
    else
      -- local dir = tostring(ya.readable_path(tostring(self._current.cwd))):gsub(
      --   '(%.?)([^/])[^/]+/',
      --   '%1%2/'
      -- ) .. self:flags()
      dir = ya.readable_path(tostring(self._current.cwd))
    end

    return ui.Span(ui.truncate(dir, { max = max, rtl = true })):style(th.mgr.cwd)
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

do -- [=[ show current zmx session
  Header:children_add(function()
    local sesh = os.getenv('ZMX_SESSION') or ''
    if sesh ~= '' then
      sesh = sesh .. ' '
    end
    return ui.Span(sesh):style(ui.Style():fg('yellow'))
  end, 500, Header.LEFT)
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

do -- [=[ count icons
  function Header:count()
    local selected = #self._tab.selected
    local yanked = selected > 0 and 0 or #cx.yanked

    local span
    if selected > 0 then
      span = ui.Span(' 󰻭 ' .. selected .. ' '):style(th.mgr.count_selected)
    elseif yanked <= 0 then
      return ''
    elseif cx.yanked.is_cut then
      span = ui.Span(' 󰆐 ' .. yanked .. ' '):style(th.mgr.count_cut)
    else
      span = ui.Span('  ' .. yanked .. ' '):style(th.mgr.count_copied)
    end

    return ui.Line { span, ' ' }
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
