local M = {}

function M:peek(job)
  local args = { tostring(job.file.url) }

  local child = Command('viu'):args(args):stdout(Command.PIPED):stderr(Command.PIPED):spawn()
  local limit = job.area.h
  local i, lines = 0, ''
  repeat
    local next, event = child:read_line()
    if event == 1 then
      return require('code').peek(job)
    elseif event ~= 0 then
      break
    end

    i = i + 1
    if i > job.skip then lines = lines .. next end
  until i >= job.skip + limit

  child:start_kill()
  if job.skip > 0 and i < job.skip + limit then
    ya.manager_emit('peek', {
      tostring(math.max(0, i - limit)),
      only_if = job.file.url,
      upper_bound = true,
    })
  else
    ya.preview_widgets(job, { ui.Text.parse(lines):area(job.area) })
  end
end

function M:seek(job)
  local h = cx.active.current.hovered
  if not h or h.url ~= job.file.url then return end
  ya.manager_emit('peek', {
    math.max(0, cx.active.preview.skip + job.units),
    only_if = job.file.url,
  })
end

return M
