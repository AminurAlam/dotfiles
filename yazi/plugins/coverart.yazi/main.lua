local M = {}

function M:peek(job)
  local output = Command('mediainfo')
    :arg({
      tostring(job.file.name),
      ''
        .. [[--Output=General;%Performer% - %Track%\nAlbum: %Album%\n]]
        .. [[\nGenre: %Genre%\nReleased: %Recorded_Date%]],
    })
    :stdout(Command.PIPED)
    :output().stdout .. Command('mediainfo')
    :arg({
      tostring(job.file.name),
      [[--Output=Image;\nCover: %Format% %Width%x%Height% %StreamSize/String1%]],
    })
    :stdout(Command.PIPED)
    :output().stdout
  ya.preview_widgets(job, { ui.Text.parse(output):area(job.area) })
end

function M:seek(job) end

return M
