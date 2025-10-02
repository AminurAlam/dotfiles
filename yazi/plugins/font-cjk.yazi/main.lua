local set_config = ya.sync(function(st, opts) st.opts = opts end)
local get_config = ya.sync(
  function(st)
    return st.opts
      or {
        text = 'ABCD abcd\noO0 1lI\n1234567890\n!@#$%^&*()[]{}\n== <= >= !=\nこれ直楽糸',
        canvas_size = '700x800',
        font_size = 80,
      }
  end
)
local function tbl_deep_extend(default, config)
  if type(config) ~= 'table' then return config end

  default = (type(default) == 'table') and default or {}
  for key, _ in pairs(config) do
    default[key] = tbl_deep_extend(default[key], config[key])
  end

  return default
end

local M = {}

function M:setup(config) set_config(tbl_deep_extend(get_config(), config)) end

function M:peek(job)
  local start, cache = os.clock(), ya.file_cache(job)
  if not cache then return end

  local ok, err = self:preload(job)
  if not ok or err then return end

  ya.sleep(math.max(0, rt.preview.image_delay / 1000 + start - os.clock()))

  local _, err = ya.image_show(cache, job.area)
  ya.preview_widget(job, err and ui.Text(err):area(job.area):wrap(ui.Wrap.YES))
end

function M:seek() end

function M:preload(job)
  local cache = ya.file_cache(job)
  if not cache or fs.cha(cache) then return true end
  local opts = get_config()

  local status, err = Command('magick'):arg({
    '-size',
    opts.canvas_size,
    '-gravity',
    'center',
    '-font',
    tostring(job.file.url),
    '-pointsize',
    opts.font_size,
    'xc:white',
    '-fill',
    'black',
    '-annotate',
    '+0+0',
    opts.text,
    'JPG:' .. tostring(cache),
  }):status()

  if status then
    return status.success
  else
    return true, Err('Failed to start `magick`, error: %s', err)
  end
end

return M
