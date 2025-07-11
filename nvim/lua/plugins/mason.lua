---@module "lazy"
---@type LazyPluginSpec
return {
  'https://github.com/williamboman/mason.nvim',
  enabled = false,
  cmd = { 'Mason', 'MasonInstall', 'MasonUpdate', 'MasonLog' },
  opts = {
    ui = {
      check_outdated_packages_on_open = true,
      border = 'rounded',
      width = 0.9,
      height = 0.8,
      icons = {
        package_installed = '',
        package_pending = '󰇘',
        package_uninstalled = '',
      },
    },
  },
}
