local mp = require('mp')
local utils = require('mp.utils')

-- [[ event ]]

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

-- [[ swap subs ]]

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

-- [[ yank subs ]]

---@return "sub-text"|"secondary-sub-text"|nil
local get_jp_loc = function()
  local primary_sid, secondary_sid = mp.get_property('sid'), mp.get_property('secondary-sid')
  local tracks = mp.get_property_native('track-list') or {}

  for _, track in ipairs(tracks) do
    if
      track.type == 'sub'
      and track.selected == true
      and (track.lang == 'ja' or track.lang == 'jp')
    then
      if tostring(track.id) == tostring(primary_sid) then
        return 'sub-text'
      elseif tostring(track.id) == tostring(secondary_sid) then
        return 'secondary-sub-text'
      end
    end
    -- for k, v in pairs(track) do
    --   print(k, v)
    -- end
  end
end

local yank_jp_text = function()
  local ps = get_jp_loc() ---@type "sub-text"|"secondary-sub-text"|nil
  if not ps then
    return
  end

  local text = mp.get_property(ps) ---@type string?
  if not text or text == '' then
    return
  end

  -- TODO: strip spaces from text
  text = string.gsub(text, ' ', '')
  mp.commandv('run', 'wl-copy', text)
  print(text)
end

mp.add_key_binding('a', 'swap-subtitles', swap_subtitles)
mp.add_key_binding('d', 'yank-jp-text', yank_jp_text)
