local changed = ya.sync(function(st, new)
  local b = st.last ~= new
  st.last = new
  return b or not cx.active.finder
end)

local matched = ya.sync(function()
  for _, file in ipairs(cx.active.current.files) do
    local highlights = file:highlights()
    if highlights and #highlights > 0 then return true end
  end
  return false
end)

-- TODO: backwards on uppercase
-- TODO: setup for aliases
return {
  entry = function()
    local aliases = {
      a = 'あア',
      b = 'ばびぶべぼバビブベボ',
      c = 'ちチ',
      d = 'だぢづでどダヂヅデド',
      e = 'えエ',
      g = 'がぎぐげごガギグゲゴ',
      h = 'はひふへほハヒフヘホ',
      i = 'いイ',
      j = 'じジ',
      k = 'かきくけこカキクケコ',
      m = 'まみむめもマミムメモ',
      n = 'なにぬねのんナニヌネノン',
      o = 'おオ',
      p = 'ぱぴぷぺぽパピプペポ',
      r = 'らりるれろラリルレロ',
      s = 'さしすせそサシスセソ',
      t = 'たつてとタツテト',
      u = 'うウ',
      w = 'わをワヲ',
      y = 'やゆよヤユヨ',
      z = 'ざずぜぞザズゼゾ',
    }
    local cands = {
      { on = '0' },
      { on = '1' },
      { on = '2' },
      { on = '3' },
      { on = '4' },
      { on = '5' },
      { on = '6' },
      { on = '7' },
      { on = '8' },
      { on = '9' },
      { on = '_' },
      { on = 'a' },
      { on = 'b' },
      { on = 'c' },
      { on = 'd' },
      { on = 'e' },
      { on = 'f' },
      { on = 'g' },
      { on = 'h' },
      { on = 'i' },
      { on = 'j' },
      { on = 'k' },
      { on = 'l' },
      { on = 'm' },
      { on = 'n' },
      { on = 'o' },
      { on = 'p' },
      { on = 'q' },
      { on = 'r' },
      { on = 's' },
      { on = 't' },
      { on = 'u' },
      { on = 'v' },
      { on = 'w' },
      { on = 'x' },
      { on = 'y' },
      { on = 'z' },
    }

    local idx = ya.which { cands = cands, silent = true }
    if not idx then return end

    local kw = '[' .. cands[idx].on .. (aliases[cands[idx].on] or '') .. ']'
    local count = 0
    if changed(kw) then
      ya.emit('find_do', { [[^\W?]] .. string.rep('.', count) .. kw, insensitive = true })
      while not matched() and count < 10 do
        count = count + 1
        ya.emit('find_do', { [[^\.?]] .. string.rep('.', count) .. kw })
      end
    else
      -- TODO: incremental search
      -- count = count + 1
      -- ya.emit('find_do', { [[^\.?]] .. string.rep('.', count) .. kw })
      ya.emit('find_arrow', {})
    end
  end,
}
