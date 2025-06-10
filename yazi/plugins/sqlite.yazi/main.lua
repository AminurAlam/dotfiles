local M = {}

function M:peek(job)
  local child, err = Command('sqlite3')
    :arg({
      tostring(job.file.url),
      '.schema',
    })
    :stdout(Command.PIPED)
    :output()

  if not err then
    text = child.stdout
    ya.preview_widget(job, ui.Text.parse(text):area(job.area):wrap(ui.Text.WRAP))
  else
    ya.preview_widget(job, ui.Text.parse(err):area(job.area):wrap(ui.Text.WRAP))
  end
end

return M
