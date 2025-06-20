local M = {}

function M:peek(job)
  if ya.target_os() == 'android' then
    local child, err = Command('unzip')
      :arg({ '-p', tostring(job.file.url), 'ComicInfo.xml' })
      :stdout(Command.PIPED)
      :output()

    if not err then
      text = child.stdout
      ya.preview_widget(job, ui.Text.parse(text):area(job.area):wrap(ui.Text.WRAP))
    else
      ya.preview_widget(job, ui.Text.parse(err):area(job.area):wrap(ui.Text.WRAP))
    end
    return
  end

  local start, cache = os.clock(), ya.file_cache(job)
  if not cache then return end

  local ok, err = self:preload(job)
  if not ok or err then return end

  ya.sleep(math.max(0, rt.preview.image_delay / 1000 + start - os.clock()))

  local _, err = ya.image_show(cache, job.area)
  ya.preview_widget(job, err and ui.Text(err):area(job.area):wrap(ui.Wrap.YES))
end

function M:seek(job)
  if ya.target_os() == 'android' then return true end
  local h = cx.active.current.hovered
  if h and h.url == job.file.url then
    ya.emit('peek', {
      math.max(0, cx.active.preview.skip + ya.clamp(-1, job.units, 1)),
      only_if = job.file.url,
    })
  end
end

function M:preload(job)
  local cache = ya.file_cache(job)
  if not cache or fs.cha(cache) then return true end
  if ya.target_os() == 'android' then return true end

  local output, err = Command('cbzcover')
    :arg({
      tostring(job.file.url),
      tostring(cache),
      job.skip + 1,
    })
    :stdout(Command.PIPED)
    :output()

  if not output then
    return true, Err('Failed to start `cbzcover`, error: %s', err)
  elseif not output.status.success then
    local max_pages = tonumber(output.stdout) or 0
    if job.skip > 0 and max_pages > 0 then
      ya.emit('peek', { max_pages - 1, only_if = job.file.url, upper_bound = true })
    end
    return true, Err('Failed to get image, stderr: %s', output.stdout)
  end

  return true
end

return M
