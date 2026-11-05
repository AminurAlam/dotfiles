-- https://github.com/CogentRedTester/mpv-scripts
-- https://github.com/TomJo2000/.dotfiles/blob/main/.config/mpv/scripts/pause-indicator.lua

local mp = require('mp')
local ov = mp.create_osd_overlay('ass-events')
-- in Advanced SubStation - ASS format
-- https://web.archive.org/web/20260523223459/http://www.tcax.org/docs/ass-specs.htm
ov.data = '{\\an5}' -- align, numpad style
  .. '{\\fs250}' -- font size
  .. '{\\c&FFFFFF&}' -- color
  .. '{\\alpha&H66&}' -- opacity
  .. '󰏤' -- text

local paused, time = nil, nil
local function remove_on_frame_advance(_, pos)
  if paused and time and pos ~= time then
    ov:remove()
  end
  time = pos
end

-- Track pause state
mp.observe_property('pause', 'bool', function(_, state)
  paused = state
  if paused then
    ov:update()
  else
    ov:remove()
  end
end)

-- Detect frame advance while paused
mp.observe_property('time-pos', 'number', remove_on_frame_advance)
