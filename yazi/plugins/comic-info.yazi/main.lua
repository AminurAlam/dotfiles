local M = {}

-- TODO: gsub text
function M:peek(job)
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
end

function M:seek(job) end

return M
