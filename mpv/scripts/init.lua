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

local sub_info = function(id)
  if id == 'no' or id == nil then
    return 'None'
  end

  local tracks = mp.get_property_native('track-list') or {}
  for _, track in ipairs(tracks) do
    if track.type == 'sub' and tostring(track.id) == tostring(id) then
      return string.format('[%s] %s', (track.lang or '??'), (track.title or ''))
    end
  end

  return 'Track ' .. id
end

local swap_subtitles = function()
  local primary = mp.get_property('sid') or 'no'
  local secondary = mp.get_property('secondary-sid') or 'no'

  if primary == 'no' and secondary == 'no' then
    mp.osd_message('No subtitles active to swap')
    return
  end

  mp.set_property('sid', 'no')
  mp.set_property('secondary-sid', 'no')
  mp.set_property('sid', secondary)
  mp.set_property('secondary-sid', primary)

  mp.osd_message(string.format('%s\n%s', sub_info(primary), sub_info(secondary)))
end

mp.add_key_binding('a', 'swap-subtitles', swap_subtitles)

-- TODO: bind `d` to automatically copy jp subs whether its in primary or secondary
-- mp.add_key_binding('d', 'yank-jp-text', yank_jp_text)
