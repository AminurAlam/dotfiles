return {
  'https://github.com/williamboman/mason.nvim',
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
