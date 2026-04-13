do -- General config
  swayimg.set_mode('viewer')
  swayimg.enable_antialiasing(true)
  swayimg.enable_decoration(true)
  swayimg.enable_overlay(true)
  swayimg.enable_exif_orientation(true)
  swayimg.set_dnd_button('MouseRight')
end

do -- Image list configuration
  swayimg.imagelist.set_order('mtime')
  swayimg.imagelist.enable_reverse(true)
  swayimg.imagelist.enable_recursive(false)
  swayimg.imagelist.enable_adjacent(false)
  swayimg.imagelist.enable_fsmon(true)
end

do -- Text overlay configuration
  swayimg.text.set_font('monospace')
  swayimg.text.set_size(20)
  swayimg.text.set_spacing(0)
  swayimg.text.set_padding(10)
  swayimg.text.set_foreground(0xffc0caf5)
  swayimg.text.set_background(0x00000000)
  swayimg.text.set_shadow(0x0d000000)
  swayimg.text.set_timeout(5)
  swayimg.text.set_status_timeout(3)
end

do -- Image viewer mode
  swayimg.viewer.set_default_scale('fit')
  swayimg.viewer.set_default_position('center')
  swayimg.viewer.set_drag_button('MouseLeft')
  swayimg.viewer.set_window_background(0x33000000)
  swayimg.viewer.set_image_chessboard(20, 0xff333333, 0xff4c4c4c)
  swayimg.viewer.enable_centering(true)
  swayimg.viewer.enable_loop(true)
  swayimg.viewer.limit_preload(1)
  swayimg.viewer.limit_history(1)
  swayimg.viewer.set_mark_color(0xff808080)
  swayimg.viewer.set_text('topleft', {
    'scale: {scale}',
    'size: {frame.width}x{frame.height} {sizehr}',
  })
  swayimg.viewer.set_text('topright', {})
  swayimg.viewer.set_text('bottomleft', {})
end

do -- Key and mouse bindings in viewer mode
  local zoom = function(n)
    local pos = swayimg.get_mouse_pos()
    local scale = swayimg.viewer.get_scale()

    -- local aa = swayimg.is_antialiasing_on()
    -- swayimg.enable_antialiasing(false)
    scale = scale + (scale / n)
    -- swayimg.enable_antialiasing(aa)

    swayimg.viewer.set_abs_scale(scale, pos.x, pos.y)
  end
  local zoomin = function()
    zoom(10)
  end
  local zoomout = function()
    zoom(-10)
  end
  local mov = function(x, y)
    local wnd = swayimg.get_window_size()
    local pos = swayimg.viewer.get_position()
    swayimg.viewer.set_abs_position(
      x == 0 and pos.x or math.floor(pos.x + wnd.width / x),
      y == 0 and pos.y or math.floor(pos.y + wnd.width / y)
    )
  end

  swayimg.viewer.on_key('q', swayimg.exit)
  swayimg.viewer.on_key('space', swayimg.viewer.set_animation)
  swayimg.viewer.on_key(',', function()
    swayimg.viewer.rotate(90)
  end)
  swayimg.viewer.on_key('.', function()
    swayimg.viewer.rotate(270)
  end)
  swayimg.viewer.on_key('Shift+less', function()
    swayimg.viewer.set_animation(false)
    swayimg.viewer.prev_frame()
  end)
  swayimg.viewer.on_key('Shift+greater', function()
    swayimg.viewer.set_animation(false)
    swayimg.viewer.next_frame()
  end)

  swayimg.viewer.on_key('i', function()
    swayimg.text.show()
  end)
  swayimg.viewer.on_key('s', function()
    swayimg.viewer.set_fix_scale('width')
  end)
  swayimg.viewer.on_key('d', function()
    swayimg.viewer.set_fix_scale('height')
  end)
  swayimg.viewer.on_key('KP_Add', zoomin)
  swayimg.viewer.on_key('KP_Subtract', zoomout)
  swayimg.viewer.on_key('h', function()
    mov(10, 0)
  end)
  swayimg.viewer.on_key('j', function()
    mov(0, -10)
  end)
  swayimg.viewer.on_key('k', function()
    mov(0, 10)
  end)
  swayimg.viewer.on_key('l', function()
    mov(-10, 0)
  end)
  swayimg.viewer.on_key('Shift+j', function()
    swayimg.viewer.switch_image('next')
  end)
  swayimg.viewer.on_key('Shift+k', function()
    swayimg.viewer.switch_image('prev')
  end)
  swayimg.viewer.on_key('r', swayimg.viewer.reset)
  swayimg.viewer.on_key('Escape', function()
    if swayimg.get_fullscreen() then
      swayimg.set_fullscreen(false)
    else
      swayimg.exit()
    end
  end)
end

do -- Gallery mode
  swayimg.gallery.set_aspect('fill')
  swayimg.gallery.set_thumb_size(200)
  swayimg.gallery.set_padding_size(5)
  swayimg.gallery.set_border_size(5)
  swayimg.gallery.set_border_color(0xffaaaaaa)
  swayimg.gallery.set_selected_scale(1.15)
  swayimg.gallery.set_selected_color(0xff404040)
  swayimg.gallery.set_unselected_color(0xff202020)
  swayimg.gallery.set_window_color(0xff000000)
  swayimg.gallery.limit_cache(100)
  swayimg.gallery.enable_preload(false)
  swayimg.gallery.enable_pstore(false)
  swayimg.gallery.set_text('topleft', { 'File: {name}' })
  swayimg.gallery.set_text('topright', { '{list.index} of {list.total}' })
end

do -- misc
  swayimg.toggle_fullscreen()

  swayimg.viewer.on_image_change(function()
    local i = swayimg.viewer.get_image()
    if i.width < 500 then
      swayimg.enable_antialiasing(false)
    end
  end)

  local scaled = false
  swayimg.on_window_resize(function()
    if not scaled then
      swayimg.viewer.set_fix_scale('fit')
      scaled = true
    end
  end)
  swayimg.on_initialized(function() end)
end

swayimg.viewer.set_pinch_factor(1)
