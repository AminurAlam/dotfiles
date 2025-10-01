local M = {}

local get_stream_info = function(file)
  local sections = {}
  for _, stream in ipairs({ 'Video', 'Audio', 'Subtitles' }) do
    -- stylua: ignore
    local cmd = Command('ffprobe'):arg {
      '-v', 'quiet',
      '-select_streams', string.lower(string.sub(stream, 1, 1)),
      '-show_entries', 'stream_tags:stream',
      '-of', 'json=c=1',
      file.name,
    }

    local output, err = cmd:output()
    if not output then return nil, Err('Failed to start `ffprobe`, error: %s', err) end

    local t = ya.json_decode(output.stdout)
    if not t then
      return nil, Err('Failed to decode `ffprobe` output: %s', output.stdout)
    elseif type(t) ~= 'table' then
      return nil, Err('Invalid `ffprobe` output: %s', output.stdout)
    end

    local data = { title = stream }
    for i, v in ipairs(t.streams) do
      if v.tags then
        data[i] = { v.codec_name or tostring(i), v.tags.title or v.tags.language or 'no title' }
      end
    end
    if data[1] ~= nil then sections[#sections + 1] = data end
  end
  return sections
end

function M:spot(job) require('spot'):spot(job, get_stream_info(job.file)) end

return M
