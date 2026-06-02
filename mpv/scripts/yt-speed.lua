local mp = require('mp')
local utils = require('mp.utils')

mp.register_event('start-file', function()
  local dir, _ = utils.split_path(mp.get_property('path'))
  if dir:match('^' .. os.getenv('XDG_VIDEOS_DIR') .. '/yt/$') then
    mp.set_property('speed', 1.4)
  end
end)

-- TODO: start songs from beginning: *.{mp3,flac}, ~/vid/mv/*, ~/mu/*
