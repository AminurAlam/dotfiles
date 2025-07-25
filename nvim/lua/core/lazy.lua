local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local out = vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    '--branch=stable',
    'https://github.com/folke/lazy.nvim.git',
    lazypath,
  })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
      { out, 'WarningMsg' },
      { '\nPress any key to exit...' },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup('plugins', {
  root = vim.fn.stdpath('data') .. '/lazy',
  defaults = { lazy = false, version = nil, cond = nil },
  spec = nil,
  lockfile = vim.fn.stdpath('state') .. '/lazy/lazy-lock.json',
  concurrency = 4,
  git = {
    log = { '--since=3 days ago' },
    timeout = 120,
    url_format = 'https://github.com/%s',
    filter = true,
  },
  dev = {
    path = '~/repos',
    patterns = {},
    fallback = false,
  },
  install = { missing = true },
  ui = {
    size = { width = 0.9, height = 0.8 },
    wrap = false,
    border = 'rounded',
    backdrop = 100,
    title = nil,
    title_pos = 'center',
    pills = false,
    icons = {
      cmd = ' ',
      config = ' ',
      event = ' ',
      ft = '',
      init = '',
      import = '',
      keys = ' ',
      lazy = '󰒲 ',
      loaded = '●',
      not_loaded = '○',
      plugin = ' ',
      runtime = ' ',
      require = '󰢱 ',
      source = ' ',
      start = '',
      task = ' ',
      list = { '-', '-', '-', '‒' },
    },
    browser = nil,
    throttle = 20,
    custom_keys = {},
  },
  diff = { cmd = 'git' },
  checker = { enabled = false },
  change_detection = {
    enabled = false,
    notify = false,
  },
  performance = {
    cache = {
      enabled = true,
      path = vim.fn.stdpath('cache') .. '/lazy/cache',
      disable_events = { 'UIEnter', 'BufReadPre' },
      ttl = 3600 * 24 * 5, -- keep unused modules for up to 5 days
    },
    reset_packpath = true, -- reset the package path to improve startup time
    rtp = {
      reset = true, -- reset the runtime path to $VIMRUNTIME and your config directory
      paths = {}, -- add any custom paths here that you want to includes in the rtp
      disabled_plugins = {},
    },
  },
  readme = {
    enabled = true,
    root = vim.fn.stdpath('state') .. '/lazy/readme',
    files = { 'README.md', 'lua/**/README.md' },
    skip_if_doc_exists = true,
  },
  state = vim.fn.stdpath('state') .. '/lazy/state.json', -- state info for checker and other things
  build = { warn_on_override = true },
  profiling = {
    loader = false,
    require = false,
  },
})
