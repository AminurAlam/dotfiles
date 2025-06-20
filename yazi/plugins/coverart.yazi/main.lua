local M = {}

function M:peek(job)
  local start, cache = os.clock(), ya.file_cache(job)
  if not cache then return end

  local ok, err = self:preload(job)
  if not ok or err then return end

  ya.sleep(math.max(0, rt.preview.image_delay / 1000 + start - os.clock()))

  local _, err = ya.image_show(Url(fs.cwd() .. '/cover.jpg'), job.area)
  if err then
    _, err = ya.image_show(cache, job.area)
  end
  ya.preview_widget(job, err and ui.Text(err):area(job.area):wrap(ui.Wrap.YES))
end

function M:seek(job) end

function M:preload(job)
  if fs.cha(Url(fs.cwd() .. '/cover.jpg')) then return true end
  local cache = ya.file_cache(job)
  if not cache or fs.cha(cache) then return true end

  local output, err = Command('ffmpeg')
    :arg({
      '-hide_banner',
      '-loglevel',
      'warning',
      '-i',
      tostring(job.file.url),
      '-an',
      '-vcodec',
      'copy',
      string.format('%s.jpg', cache),
    })
    :stderr(Command.PIPED)
    :output()

  if not output then
    return true, Err('Failed to start `ffmpeg`, error: %s', err)
  elseif not output.status.success then
    return true, Err('Failed to get image, stderr: %s', output.stderr)
  end

  local ok, err = os.rename(string.format('%s.jpg', cache), tostring(cache))
  if ok then
    return true
  else
    return false, Err('Failed to rename: %s', err)
  end
end

return M
