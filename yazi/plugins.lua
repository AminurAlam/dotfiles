---@diagnostic disable: undefined-field

local o = rt.plugin
ya.dbg(o)

for _, f in pairs(rt.plugin.fetchers:match()) do
  rt.plugin.fetchers:remove { id = f.id }
end
for _, f in pairs(rt.plugin.spotters:match()) do
  rt.plugin.spotters:remove { id = f.id }
end

local plugin_rules = {
  fetchers = {
    { group = 'mime', url = '*/', run = 'mime.dir', prio = 'high' },
    { group = 'mime', url = 'local://*', run = 'mime-ext.local', prio = 'high' },
    { group = 'mime', url = 'remote://*', run = 'mime-ext.remote', prio = 'high' },
    { group = 'mime', url = 'trash://*', run = 'mime.trash', prio = 'high' },
    { group = 'mime', url = '*.{!qB,part}', run = 'noop', prio = 'high' },
    { group = 'mime', url = '/mnt/rclone/**', run = 'noop', prio = 'high' },
    { group = 'git', url = '*', run = 'git' },
    { group = 'git', url = '*/', run = 'git' },
  },
  spotters = {
    { mime = 'multi/*', run = 'multi' },
    { mime = 'folder/*', run = 'spot' },
    { mime = 'application/cbr', run = 'spot-cbz' },
    { mime = 'audio/*', run = 'spot-audio' },
    { mime = 'image/*', run = 'spot-image' },
    { mime = 'video/*', run = 'spot-video' },
    { url = '*', run = 'spot' },
  },
  previewers = {
    { url = '/home/fisher/pic/{.lewdp,Camera,Komikku,covers,desu,ss,wp}/', run = 'preview-imgdir' },
    -- partial downloads
    { url = '*.{!qB,part}', run = 'noop' },
    { url = '/mnt/rclone/**', run = 'noop' },
    -- custom plugins
    { url = '**/.git/', run = 'preview-git' },
    { url = '**/manga/**/*.{zip,rar}', run = 'preview-cbz' },
    { url = '**/smut/*.{zip,rar}', run = 'preview-cbz' },
    { url = '**/smut/*/*.{zip,rar}', run = 'preview-cbz' },
    { url = '*.typ', run = 'preview-typst' },
    { url = '*.service', run = 'preview-systemd' },
    { mime = 'application/apple.mpegurl', run = 'code' },
    { mime = 'application/bittorrent', run = 'preview-torrent' },
    { mime = 'application/cbr', run = 'preview-cbz' },
    { mime = 'application/sqlite3', run = 'preview-sqlite' },
    { mime = 'audio/mpegurl', run = 'code' },
    { mime = 'audio/*', run = 'preview-audio' },
    { mime = 'font/*', run = 'font-sample' },
  },
  preloaders = {
    { url = '/home/fisher/pic/{.lewdp,Camera,Komikku,covers,desu,ss,wp}/', run = 'preview-imgdir' },
    -- partial downloads
    { url = '*.{!qB,part}', run = 'noop' },
    { url = '/mnt/rclone/**', run = 'noop' },
    -- custom plugins
    { url = '**/manga/**/*.{zip,rar}', run = 'preview-cbz' },
    { url = '**/smut/*.{zip,rar}', run = 'preview-cbz' },
    -- { url = "*.typ", run = "preview-typst" },
    { mime = 'application/cbr', run = 'preview-cbz' },
    { mime = 'audio/*', run = 'preview-audio' },
    { mime = 'font/*', run = 'font-sample' },
  },
}

for plugin, rules in pairs(plugin_rules) do
  local p = rt.plugin[plugin]
  for id, data in ipairs(rules) do
    p:insert(id, data)
  end
  -- ya.dbg('===================== ' .. plugin)
  -- for i, f in pairs(p:match()) do
  --   ya.dbg(i, f.run.name, f.url or f.mime)
  -- end
end
