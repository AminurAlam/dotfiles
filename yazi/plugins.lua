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
    { url = '*.{!qB,part}', run = 'noop' },
    { url = '/mnt/rclone/**', run = 'noop' },
    -- default
    { mime = 'folder/*', run = 'folder' },
    { mime = 'text/*', run = 'code' },
    { mime = 'application/{mbox,javascript,wine-extension-ini}', run = 'code' },
    { mime = 'application/{json,ndjson}', run = 'json' },
    { mime = 'image/{avif,hei?,jxl}', run = 'magick' },
    { mime = 'image/svg+xml', run = 'svg' },
    { mime = 'image/*', run = 'image' },
    { mime = 'video/*', run = 'video' },
    { mime = 'application/pdf', run = 'pdf' },
    {
      mime = 'application/{zip,rar,7z*,tar,gzip,xz,zstd,bzip*,lzma,compress,archive,cpio,arj,'
        .. 'xar,ms-cab*,debian*-package,redhat-package-manager,rpm,android.package-archive}',
      run = 'archive',
    },
    {
      url = '*.{AppImage,appimage,img,fat,ext,ext2,ext3,ext4,squashfs,ntfs,hfs,hfsx}',
      run = 'archive',
    },
    { mime = 'inode/empty', run = 'empty' },
    { mime = 'vfs/*', run = 'vfs' },
    { mime = 'trash/**', run = 'trash' },
    { mime = 'error/*', run = 'error' },
    { url = '*', run = 'file' },
  },
  preloaders = {
    { url = '*.{!qB,part}', run = 'noop' },
    { url = '/mnt/rclone/**', run = 'noop' },
    -- default
    { mime = 'image/{avif,hei?,jxl}', run = 'magick' },
    { mime = 'image/svg+xml', run = 'svg' },
    { mime = 'image/*', run = 'image' },
    { mime = 'video/*', run = 'video' },
    { mime = 'application/pdf', run = 'pdf' },
    { mime = 'trash/**', run = 'trash' },
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
