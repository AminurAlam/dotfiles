-- Example yay init.lua
--
-- This file is a complete template for yay.opt. Copy entries you need,
-- or keep all of them and tune values. Command-line flags still override
-- these values.

yay.opt.aururl = 'https://aur.archlinux.org'
yay.opt.aurrpcurl = ''
yay.opt.build_dir = os.getenv('XDG_CACHE_HOME') .. '/yay'
yay.opt.editor = os.getenv('EDITOR') or os.getenv('VISUAL') or 'nvim'
yay.opt.editor_flags = ''
-- yay.opt.pager = os.getenv('PAGER') or ''
yay.opt.makepkg_bin = 'makepkg'
yay.opt.makepkg_conf = ''
yay.opt.pacman_bin = 'pacman'
yay.opt.pacman_conf = '/etc/pacman.conf'
yay.opt.redownload = 'no'
yay.opt.git_bin = 'git'
yay.opt.gpg_bin = 'gpg'
yay.opt.gpg_flags = ''
yay.opt.mflags = ''
yay.opt.sort_by = ''
yay.opt.search_by = 'name-desc'
yay.opt.git_flags = ''
yay.opt.remove_make = 'yes'
yay.opt.sudo_bin = 'sudo'
yay.opt.sudo_flags = ''
yay.opt.rebuild = 'no'
yay.opt.answer_clean = 'None'
yay.opt.answer_diff = 'All'
yay.opt.answer_edit = ''

yay.opt.request_split_n = 150
yay.opt.completion_refresh_time = 7
yay.opt.max_concurrent_downloads = 1

yay.opt.bottom_up = true
yay.opt.sudo_loop = true
yay.opt.devel = true
yay.opt.clean_after = false
yay.opt.keep_src = false
yay.opt.provides = true
yay.opt.pgp_fetch = true
yay.opt.clean_menu = false
yay.opt.diff_menu = true
yay.opt.edit_menu = false
yay.opt.combined_upgrade = true
yay.opt.use_ask = false
yay.opt.batch_install = false
yay.opt.single_line_results = false
yay.opt.separate_sources = true
yay.opt.debug = false
yay.opt.rpc = true
yay.opt.double_confirm = true

for _, event in ipairs({
  'AURPreInstall',
  'AURPostDownload',
  'UpgradeSelect',
  -- 'PostInstall',
  -- 'SearchFilter',
  -- 'RenderAUR',
  -- 'RenderSync',
}) do
  yay.create_autocmd(event, {
    callback = function()
      print('\a')
    end,
  })
end
