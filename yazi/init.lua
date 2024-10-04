---@diagnostic disable: undefined-global

Status = {
  LEFT = 0,
  RIGHT = 1,
  _id = 'status',
  _inc = 1,
  _left = { { 'left', id = 1, order = 1 } },
  _right = { { 'perms', id = 2, order = 2 }, { 'right', id = 3, order = 3 } },
  children_render = function(self, side)
    local lines = {}
    for _, c in ipairs(side == self.RIGHT and self._right or self._left) do
      lines[#lines + 1] = (type(c[1]) == 'string' and self[c[1]] or c[1])(self)
    end
    return ui.Line(lines)
  end,
  new = function(self, area, tab)
    return setmetatable({
      _area = area,
      _tab = tab,
    }, { __index = self })
  end,
  style = function(self)
    return THEME.status[self._tab.mode.is_visual and 'mode_select' or 'mode_normal']
  end,
  render = function(self)
    local left = self:children_render(self.LEFT)
    local right = self:children_render(self.RIGHT)
    return {
      ui.Paragraph(self._area, { left }),
      ui.Paragraph(self._area, { right }):align(ui.Paragraph.RIGHT),
      table.unpack(Progress:render(self._area, right:width())),
    }
  end,
}

Status.left = function(self)
  local style = self:style()
  return ui.Line {
    ui.Span(' ' .. tostring(self._tab.mode):upper() .. ' '):style(style),
    ui.Span(
      THEME.status.separator_close
        .. ' '
        .. ya.readable_path(tostring(cx.active.current.cwd)):gsub('(%.?)([^/])[^/]+/', '%1%2/')
        .. ' '
    )
      :style(style)
      :reverse(),
    ui.Span(THEME.status.separator_close):fg(style.fg),
    -- ui.Span('ddddddddddddddddddddddddddddddddddddddddddddddddddddddd'),
  }
end

Status.perms = function(self)
  local h = self._tab.current.hovered
  if not h then return ui.Line {} end
  local spans = {}
  local perm = h.cha:permissions()
  local perm_fg = {
    ['d'] = '#8aadf4',
    ['x'] = '#a6da95',
    ['s'] = '#a6da95',
    ['S'] = '#a6da95',
    ['t'] = '#a6da95',
    ['T'] = '#a6da95',
    ['r'] = '#eed49f',
    ['w'] = '#ed8796',
    ['-'] = '#8087a2',
    ['?'] = '#8087a2',
  }
  if perm:sub(2, 3):find('-') then
    spans = { ui.Span('󰌾'):fg('#ff5555') }
  else
    for c in perm:gmatch('.') do
      spans[#spans + 1] = ui.Span(c):fg(perm_fg[c] or '#8aadf4')
    end
  end
  return ui.Line(spans)
end

Status.right = function(self)
  local percent = 0
  local cursor = self._tab.current.cursor
  local length = #self._tab.current.files
  if cursor ~= 0 and length ~= 0 then percent = math.floor((cursor + 1) * 100 / length) end
  local pos = ''
  if percent == 0 then
    pos = ' Top '
  elseif percent == 100 then
    pos = ' Bot '
  else
    pos = string.format(' %2d%% ', percent)
  end
  local style = self:style()
  return ui.Line {
    ui.Span(' ' .. THEME.status.separator_open):fg(style.fg),
    ui.Span(pos .. THEME.status.separator_open):style(style):reverse(),
    ui.Span(string.format(' %2d/%-2d ', cursor + 1, length)):style(style),
  }
end
