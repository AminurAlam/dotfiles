local grid_side = {
  [true] = 5, -- fullscreen
  [false] = 3, -- windowed
}

do -- General config
  swayimg.mode = 'viewer'
  swayimg.enable_antialiasing = true
  swayimg.enable_decoration = true
  swayimg.enable_overlay = true
  swayimg.enable_exif_orientation = true
  swayimg.dnd_button = 'MouseRight'
end

do -- Image list configuration
  swayimg.imagelist.order = 'mtime'
  swayimg.imagelist.reverse = true
  swayimg.imagelist.recursive = false
  swayimg.imagelist.adjacent = false
  swayimg.imagelist.fsmon = true
end

do -- Text overlay configuration
  swayimg.text.font = 'monospace'
  swayimg.text.size = 20
  swayimg.text.spacing = 0
  swayimg.text.padding = 10
  swayimg.text.color = 0xffc0caf5
  swayimg.text.background = 0x00000000
  swayimg.text.shadow = 0x0d000000
  swayimg.text.timeout = 5
  swayimg.text.status_timeout = 3
end

do -- Image viewer mode
  swayimg.viewer.default_scale = 'fit'
  swayimg.viewer.default_position = 'center'
  swayimg.viewer.drag_button = 'MouseLeft'
  swayimg.viewer.set_window_background(0x33000000)
  swayimg.viewer.set_image_chessboard(20, 0xff333333, 0xff4c4c4c)
  swayimg.viewer.enable_centering = true
  swayimg.viewer.enable_loop = true
  swayimg.viewer.limit_preload = 1
  swayimg.viewer.limit_history = 1
  swayimg.viewer.mark_color = 0xff808080
  swayimg.viewer.set_text('topleft', {
    'scale: {scale}',
    'size: {frame.width}x{frame.height} {sizehr}',
  })
  swayimg.viewer.set_text('topright', {})
  swayimg.viewer.set_text('bottomleft', {})
  swayimg.viewer.pinch_factor = 1
end

do -- Key bindings
  local zoom = function(n)
    local pos = swayimg.get_mouse_pos()
    local scale = swayimg.viewer.scale()

    -- local aa = swayimg.is_antialiasing_on()
    -- swayimg.enable_antialiasing(false)
    scale = scale + (scale / n)
    -- swayimg.enable_antialiasing(aa)

    swayimg.viewer.set_abs_scale(scale, pos.x, pos.y)
  end
  local zoomin = function() zoom(10) end
  local zoomout = function() zoom(-10) end
  local mov = function(x, y)
    local wnd = swayimg.get_window_size()
    local pos = swayimg.viewer.get_position()
    swayimg.viewer.set_abs_position(
      x == 0 and pos.x or math.floor(pos.x + wnd.width / x),
      y == 0 and pos.y or math.floor(pos.y + wnd.width / y)
    )
  end
  local vmap = swayimg.viewer.on_key
  local gmap = swayimg.gallery.on_key
  local mmap = swayimg.viewer.on_mouse

  vmap('q', swayimg.exit)
  vmap('space', function() swayimg.viewer.animation = not swayimg.viewer.animation end)
  vmap(',', function() swayimg.viewer.rotate(90) end)
  vmap('.', function() swayimg.viewer.rotate(270) end)
  vmap('Shift+less', function()
    swayimg.viewer.animation = false
    local f = swayimg.viewer.frame - 1
    swayimg.viewer.frame = (f < 0) and (swayimg.viewer.get_image().frames - 1) or f
  end)
  vmap('Shift+greater', function()
    swayimg.viewer.animation = false
    local f = swayimg.viewer.frame + 1
    swayimg.viewer.frame = (f >= swayimg.viewer.get_image().frames) and 0 or f
  end)

  vmap('i', function()
    if swayimg.text.visible then
      swayimg.text.visible = false
    else
      swayimg.text.visible = true
    end
  end)
  vmap('s', function() swayimg.viewer.set_fix_scale('width') end)
  vmap('d', function() swayimg.viewer.set_fix_scale('height') end)
  vmap('KP_Add', zoomin)
  vmap('KP_Subtract', zoomout)
  vmap('h', function() mov(10, 0) end)
  vmap('j', function() mov(0, -10) end)
  vmap('k', function() mov(0, 10) end)
  vmap('l', function() mov(-10, 0) end)
  mmap('ScrollUp', function() mov(0, 100) end)
  mmap('ScrollDown', function() mov(0, -100) end)
  mmap('ScrollLeft', function() mov(100, 0) end)
  mmap('ScrollRight', function() mov(-100, 0) end)
  vmap('Shift+j', function() swayimg.viewer.open('next') end)
  vmap('Shift+k', function() swayimg.viewer.open('prev') end)
  vmap('r', swayimg.viewer.reset)
  vmap('Escape', function()
    print()
    if swayimg.imagelist.size > 1 then
      swayimg.mode = 'gallery'
    elseif swayimg.fullscreen then
      swayimg.fullscreen = false
    else
      swayimg.exit()
    end
  end)
  vmap('y', function() os.execute(string.format('wl-copy %q', swayimg.viewer.get_image().path)) end)
  vmap(
    'd',
    function() os.execute(string.format('trash-put %q', swayimg.gallery.get_image().path)) end
  )
  local gsize = function(n)
    local fs = swayimg.fullscreen
    if not fs then fs = false end
    if grid_side[fs] == nil then return end
    grid_side[fs] = grid_side[fs] + n
    if grid_side[fs] < 2 then grid_side[fs] = 2 end
    swayimg.gallery.thumb_size = math.floor(swayimg.get_window_size().width / grid_side[fs])
  end
  gmap('KP_Add', function() gsize(-1) end)
  gmap('KP_Subtract', function() gsize(1) end)
  gmap('plus', function() gsize(-1) end)
  gmap('equal', function() gsize(-1) end)
  gmap('minus', function() gsize(1) end)
  gmap('q', swayimg.exit)
  gmap('h', function() swayimg.gallery.select('left') end)
  gmap('j', function() swayimg.gallery.select('down') end)
  gmap('k', function() swayimg.gallery.select('up') end)
  gmap('l', function() swayimg.gallery.select('right') end)
  gmap('g', function() swayimg.gallery.select('first') end)
  gmap('Shift+g', function() swayimg.gallery.select('last') end)
  gmap('u', function() swayimg.gallery.select('pgup') end)
  gmap('d', function() swayimg.gallery.select('pgdown') end)

  -- TODO: gallery bindings for: sort change, size change, hjkl
end

do -- Gallery mode
  swayimg.gallery.aspect = 'fill'
  -- swayimg.gallery.thumb_size = 350 -- set grid_side instead
  swayimg.gallery.padding_size = 0
  swayimg.gallery.border_size = 5
  swayimg.gallery.border_color = 0xff29a4bd
  swayimg.gallery.selected_scale = 1
  swayimg.gallery.selected_color = 0xff404040
  swayimg.gallery.unselected_color = 0xff202020
  swayimg.gallery.window_color = 0xff000000
  swayimg.gallery.cache = 100
  swayimg.gallery.preload = false
  swayimg.gallery.pstore = false
  swayimg.gallery.set_text('topleft', { 'File: {name}' })
  swayimg.gallery.set_text('topright', { '{list.index} of {list.total}' })
end

do -- misc
  swayimg.fullscreen = true

  swayimg.viewer.on_image_change(function()
    local i = swayimg.viewer.get_image()
    if i and i.width < 500 then swayimg.antialiasing = false end
  end)

  -- fit to screen on resize
  local scaled = false
  swayimg.on_window_resize(function()
    swayimg.gallery.thumb_size =
      math.floor(swayimg.get_window_size().width / grid_side[swayimg.fullscreen])
    if swayimg.mode == 'viewer' and not scaled then
      swayimg.viewer.set_fix_scale('fit')
      scaled = true
    end
  end)

  swayimg.on_initialized(
    function()
      swayimg.gallery.thumb_size =
        math.floor(swayimg.get_window_size().width / grid_side[swayimg.fullscreen])
    end
  )
end
