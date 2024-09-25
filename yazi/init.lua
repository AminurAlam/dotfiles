---@diagnostic disable: undefined-global
Status = {
  LEFT = 0,
  RIGHT = 1,

  _id = 'status',
  _inc = 1000,
  _left = {
    { 'a', id = 1, order = 1000 },
    { 'b', id = 2, order = 2000 },
    { 'c', id = 3, order = 3000 },
  },
  _right = {
    { 'x', id = 4, order = 1000 },
    { 'y', id = 5, order = 2000 },
    { 'z', id = 6, order = 3000 },
  },
}

function Status:new(area, tab)
  return setmetatable({
    _area = area,
    _tab = tab,
  }, { __index = self })
end

function Status:style()
  if self._tab.mode.is_select then
    return THEME.status.mode_select
  elseif self._tab.mode.is_unset then
    return THEME.status.mode_unset
  else
    return THEME.status.mode_normal
  end
end

function Status:a()
  local mode = tostring(self._tab.mode):upper():gsub('SELECT', 'VISUAL')
  -- local mode = tostring(self._tab.mode):sub(1, 3):upper()

  local style = self:style()
  return ui.Line {
    -- ui.Span(THEME.status.separator_open):fg(style.bg),
    ui.Span(' ' .. mode .. ' '):style(style),
    ui.Span(THEME.status.separator_close):fg(style.bg):bg(THEME.status.separator_style.fg),
  }
end

function Status:b()
  local h = self._tab.current.hovered
  if not h then return ui.Line {} end

  local size = ya.readable_size(h:size() or h.cha.length)
  if h.cha.is_dir then
    size = '' -- tostring(self._tab:name() or 'nil')
  end

  local style = self:style()
  return ui.Line {
    ui.Span(' ' .. size .. ' '):fg(style.bg):bg(THEME.status.separator_style.bg),
    ui.Span(THEME.status.separator_close):fg(THEME.status.separator_style.fg),
  }
end

function Status:c()
  local h = self._tab.current.hovered
  if not h then return ui.Line {} end

  local link = ''
  local link_hl = '#7dcfff'

  if h.link_to ~= nil then
    link = ' -> ' .. tostring(h.link_to):gsub(os.getenv('HOME') or '', '~')
    if h.cha.is_orphan then link_hl = '#ff5555' end
  end

  return ui.Line {
    ui.Span(' ' .. h.name),
    ui.Span(link):fg(link_hl),
  }
end

function Status:x()
  local h = self._tab.current.hovered
  if not h then return ui.Line {} end

  local spans = {}

  local perm = h.cha:permissions()
  if not perm then return ui.Line {} end
  if perm:sub(2, 3):find('-') then
    spans = { ui.Span('󰌾'):fg('#ff5555') }
  else
    perm = perm:sub(1, 4)
    for i = 1, #perm do
      local c = perm:sub(i, i)
      local style = THEME.status.permissions_t
      if c == '-' or c == '?' then
        style = THEME.status.permissions_s
      elseif c == 'r' then
        style = THEME.status.permissions_r
      elseif c == 'w' then
        style = THEME.status.permissions_w
      elseif c == 'x' or c == 's' or c == 'S' or c == 't' or c == 'T' then
        style = THEME.status.permissions_x
      end
      spans[i] = ui.Span(c):style(style)
    end
  end

  -- if self._tab.mode.is_select then spans[#spans + 1] = ui.Span(#self._tab.selected) end

  return ui.Line(spans)
end

function Status:y()
  local percent = 0
  local cursor = self._tab.current.cursor
  local length = #self._tab.current.files
  if cursor ~= 0 and length ~= 0 then percent = math.floor((cursor + 1) * 100 / length) end

  if percent == 0 then
    percent = ' Top '
  elseif percent == 100 then
    percent = ' Bot '
  else
    percent = string.format(' %2d%% ', percent)
  end

  local style = self:style()
  return ui.Line {
    ui.Span(' ' .. THEME.status.separator_open):fg(THEME.status.separator_style.fg),
    ui.Span(percent):fg(style.bg):bg(THEME.status.separator_style.bg),
  }
end

function Status:z()
  -- local h = self._tab.current.hovered
  -- return ui.Line {
  --   ui.Span(h:name()),
  --   ui.Span('name'),
  -- }

  local cursor = self._tab.current.cursor
  local length = #self._tab.current.files

  local style = self:style()
  return ui.Line {
    ui.Span(THEME.status.separator_open):fg(style.bg):bg(THEME.status.separator_style.fg),
    ui.Span(string.format(' %2d/%-2d ', cursor + 1, length)):style(style),
  }
  -- ui.Span(THEME.status.separator_close):fg(style.bg),
end

function Status:render()
  local left = self:children_render(self.LEFT)
  local right = self:children_render(self.RIGHT)
  return {
    ui.Paragraph(self._area, { left }),
    ui.Paragraph(self._area, { right }):align(ui.Paragraph.RIGHT),
    table.unpack(Progress:render(self._area, right:width())),
  }
end

-- Mouse events
function Status:click(event, up) end
function Status:scroll(event, step) end
function Status:touch(event, step) end

-- Children
function Status:children_add(fn, order, side)
  self._inc = self._inc + 1
  local children = side == self.RIGHT and self._right or self._left

  children[#children + 1] = { fn, id = self._inc, order = order }
  table.sort(children, function(a, b) return a.order < b.order end)

  return self._inc
end

function Status:children_remove(id, side)
  local children = side == self.RIGHT and self._right or self._left
  for i, child in ipairs(children) do
    if child.id == id then
      table.remove(children, i)
      break
    end
  end
end

function Status:children_render(side)
  local lines = {}
  for _, c in ipairs(side == self.RIGHT and self._right or self._left) do
    lines[#lines + 1] = (type(c[1]) == 'string' and self[c[1]] or c[1])(self)
  end
  return ui.Line(lines)
end
