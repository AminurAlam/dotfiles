---@module "lazy"
---@type LazyPluginSpec
return {
  'rcarriga/nvim-dap-ui',
  enabled = false,
  config = true,
  dependencies = {
    {
      'mfussenegger/nvim-dap',
      config = function()
        require('dap').adapters.gdb = {
          type = 'executable',
          command = 'gdb',
          args = {
            '--interpreter=dap',
            '--eval-command',
            'set print pretty on',
          },
        }
      end,
    },
    'nvim-neotest/nvim-nio',
  },
}
