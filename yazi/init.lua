local prefix = os.getenv('HOME') .. '/repos/dotfiles/yazi/'

dofile(prefix .. 'ui.lua')
dofile(prefix .. 'key.lua')

---@diagnostic disable-next-line: undefined-field
if rt.args.chooser_file then
  ya.emit('yank', { cut = true })
end

require('git'):setup {}

require('nextension'):setup {}

require('max-pane'):setup { 's', 't' }

require('zoxide'):setup { update_db = false }

require('session'):setup { sync_yanked = true }

require('spot'):setup {
  metadata_section = { hash_filesize_limit = 200, relative_time = true },
  plugins_section = { enable = true },
}

require('font-sample'):setup {
  canvas_size = '750x800',
  font_size = 60,
  bg = 'white',
  fg = 'black',
}

require('mime-ext.local'):setup {
  with_exts = {
    mmd = 'text/plain',
    scm = 'text/plain',
    srt = 'text/plain',
    sql = 'text/plain',
    tex = 'text/plain',
    xml = 'text/plain',
  },
  fallback_file1 = true,
}

require('sort-by-location'):setup {
  default = { by = 'extension', reverse = false },
  keys = {
    mtime = { 's', 'm' },
    extension = { 's', 'e' },
    natural = { 's', 'n' },
  },
  { pattern = '.*/Pictures/.*', sort = { by = 'mtime', reverse = true } },
  { pattern = '.*/pic/.*', sort = { by = 'mtime', reverse = true } },
  { pattern = '.*/DCIM/.*', sort = { by = 'mtime', reverse = true } },
  { pattern = '.*/#lewd$', sort = { by = 'mtime', reverse = true } },
  { pattern = '.*/yt$', sort = { by = 'natural' } },
}

require('fchar'):setup {
  insensitive = true,
  skip_symbols = true,
  skip_prefix = { 'yazi-', 'spot-', 'preview-', 'dot-', 'WhatsApp ', 'helix-', 'tree-sitter-' },
  keys = { start = 'f' },
  aliases = {
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
  },
}
