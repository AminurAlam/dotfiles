local mp = require('mp')
local utils = require('mp.utils')

mp.register_event('start-file', function()
  mp.set_property('resume-playback', 'no')
  local dir, file = utils.split_path(mp.get_property('path'))

  if dir:match('^' .. os.getenv('XDG_VIDEOS_DIR') .. '/yt/$') then
    mp.set_property('speed', 1.4)
  end

  if dir:match('^' .. os.getenv('XDG_VIDEOS_DIR') .. '/mv/$') or file:match('%..*$') == '.flac' then
    mp.set_property('start', 0)
  end
end)
