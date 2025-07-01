local M = {}

function M:peek(job)
  local start, cache = os.clock(), ya.file_cache(job)

  local ok, err = self:preload(job)

  if ya.target_os() == 'android' then
    local output

    output = Command('viu'):arg({ fs.cwd() .. '/cover.jpg' }):stdout(Command.PIPED):output()
    if not output.status.success then
      output = Command('viu'):arg({ tostring(cache) }):stdout(Command.PIPED):output()
      if not output.status.success then
        output = Command('mediainfo')
          :arg({
            tostring(job.file.name),
            [[--Output=General;%Performer% - %Track%\nAlbum: %Album%\n\nGenre: %Genre%\nReleased: %Recorded_Date%]],
          })
          :stdout(Command.PIPED)
          :output()
      end
    end

    ya.preview_widgets(job, { ui.Text.parse(output.stdout):area(job.area) })
  else
    local _, err = ya.image_show(Url(fs.cwd() .. '/cover.jpg'), job.area)
    if err then
      _, err = ya.image_show(cache, job.area)
      if err then
        local output = Command('mediainfo')
          :arg({
            tostring(job.file.name),
            [[--Output=General;%Performer% - %Track%\nAlbum: %Album%\n\nGenre: %Genre%\nReleased: %Recorded_Date%]],
          })
          :stdout(Command.PIPED)
          :output()
        ya.preview_widgets(job, { ui.Text.parse(output.stdout):area(job.area) })
      end
    end
    ya.preview_widget(job, err and ui.Text(err):area(job.area):wrap(ui.Wrap.YES))
  end
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
    return true, Err('Failed to rename: %s', err)
  end
end

return M
