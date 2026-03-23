---General functionality
swayimg.toggle_fullscreen()
swayimg.on_initialized(function() end)
swayimg.enable_antialiasing(true)
swayimg.enable_decoration(false)
swayimg.set_dnd_button('MouseLeft') -- https://github.com/artemsen/swayimg/issues/435

---Image list
swayimg.imagelist.set_order('mtime')
swayimg.imagelist.enable_recursive(false)

---Text overlay layer
swayimg.text.set_size(20)
swayimg.text.set_foreground(0xffc0caf5)

---Base application mode
swayimg.viewer.on_key('q', function()
  swayimg.exit()
end)
swayimg.viewer.on_key('KP_Add', function() end)
swayimg.viewer.on_key('KP_Subtract', function() end)
swayimg.viewer.on_key('h', function() end)
swayimg.viewer.on_key('j', function() end)
swayimg.viewer.on_key('Shift+j', function() end)
swayimg.viewer.on_key('k', function() end)
swayimg.viewer.on_key('Shift+k', function() end)
swayimg.viewer.on_key('l', function() end)
swayimg.viewer.on_key('r', function()
  swayimg.viewer.reset()
end)
swayimg.viewer.on_key('Escape', function()
  if swayimg.get_window_size().width == 1920 then
    swayimg.toggle_fullscreen()
  else
    swayimg.exit()
  end
end)

swayimg.viewer.set_text('topleft', {
  'scale: {scale}',
  'size: {frame.width}x{frame.height} {sizehr}',
})
swayimg.viewer.set_text('bottomleft', {})
swayimg.viewer.set_text('topright', {})

---Viewer mode
swayimg.viewer.set_default_scale('fit')
-- swayimg.viewer.reset()

swayimg.viewer.on_image_change(function()
  local i = swayimg.viewer.get_image()
  if i.width < 500 then
    swayimg.enable_antialiasing(false)
  end
end)

-- print(swayimg.get_mode())
