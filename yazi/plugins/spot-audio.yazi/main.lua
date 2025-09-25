local M = {}

local audio = function(file)
  local cmd = Command('mediainfo'):arg { '--Output=JSON', file.name }

  local output, err = cmd:output()
  if not output then return nil, Err('Failed to start `mediainfo`, error: %s', err) end

  local t = ya.json_decode(output.stdout)
  if not t then
    return nil, Err('Failed to decode `mediainfo` output: %s', output.stdout)
  elseif type(t) ~= 'table' then
    return nil, Err('Invalid `mediainfo` output: %s', output.stdout)
  end

  local t = t.media.track
  local aar = t[1].Album_Performer or ''
  local ar = t[1].Performer or ''
  local cdata = t[3]
  local br = tonumber((t[2].BitRate or 0) // 1000) .. ' kb/s'
  local sr = tonumber((t[2].SamplingRate or 0) / 1000)
  local csize = ''
  local date = t[1].Recorded_Date
  if t[1].extra and t[1].extra.ORIGINALDATE then date = date .. ' / ' .. t[1].extra.ORIGINALDATE end
  if cdata then csize = cdata.Format .. ' ' .. cdata.Height .. 'x' .. cdata.Width end

  return {
    {
      title = 'General',
      { 'Title', t[1].Title },
      { 'Album', t[1].Album },
      { 'Artist', ar .. (aar ~= ar and (' / ' .. aar) or '') },
      { 'Genre', t[1].Genre },
      { 'Date', date },
      csize ~= '' and { 'Cover art', csize } or nil,
    },
    {
      title = 'Audio',
      { 'Format', t[2].Format .. t[2].Compression_Mode },
      { 'Quality', (t[2].BitDepth or '1') .. '/' .. sr },
      { 'BitRate', br },
      { 'Channels', t[2].Channels .. ' ' .. (t[2].ChannelLayout or '') },
      -- { 'Duration', t[2].Duration },
    },
  }
end

function M:spot(job) require('spot'):spot(job, audio(job.file)) end

return M
