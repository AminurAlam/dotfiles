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
    :output()
  ya.preview_widgets(job, { ui.Text.parse(output.stdout):area(job.area) })
end

function M:seek(job) end

return M
