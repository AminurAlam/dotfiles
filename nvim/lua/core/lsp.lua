---@param cmd table[string]
---@param filetypes table[string]
---@param root_dir table[string]
---@param settings table|nil
local function create(cmd, filetypes, root_dir, settings)
  vim.api.nvim_create_autocmd('Filetype', {
    pattern = filetypes,
    once = true,
    callback = function()
      if vim.fn.executable(cmd[1]) == 1 then
        vim.lsp.start {
          cmd = cmd,
          filetypes = filetypes,
          single_file_support = true,
          root_dir = vim.fs.dirname(vim.fs.find(root_dir, { upwards = true })[1]),
          settings = settings,
        }
      end
    end,
  })
end

create({ 'clangd' }, { 'c', 'cpp', 'objc', 'objcpp', 'cuda', 'proto' }, {
  '.git',
  '.clangd',
  '.clang-tidy',
  '.clang-format',
  'compile_commands.json',
  'compile_flags.txt',
  'configure.ac',
})

create({ 'rust-analyzer' }, { 'rust' }, { 'Cargo.toml', 'rust-project.json' }, {
  ['rust-analyzer'] = { linkedProjects = nil },
})

create({ 'gopls' }, { 'go' }, { 'go.work', 'go.mod', '.git' })

create({ 'dart', 'language-server', '--protocol=lsp' }, { 'dart' }, { 'pubspec.yaml' }, {
  dart = { completeFunctionCalls = true, showTodos = true },
})

create({ 'bash-language-server', 'start' }, { 'sh', 'bash' }, {}, {})

-- TODO: make :LspInfo copy

local api, lsp = vim.api, vim.lsp

if vim.fn.has 'nvim-0.8' ~= 1 then
  local version_info = vim.version()
  local warning_str = string.format(
    '[lspconfig] requires neovim 0.8 or later. Detected neovim version: 0.%s.%s',
    version_info.minor,
    version_info.patch
  )
  vim.notify_once(warning_str)
  return
end

-- local completion_sort = function(items)
--   table.sort(items)
--   return items
-- end
--
-- local lsp_complete_configured_servers = function(arg)
--   return completion_sort(vim.tbl_filter(function(s)
--     return s:sub(1, #arg) == arg
--   end, require('lspconfig.util').available_servers()))
-- end
--
-- local lsp_get_active_client_ids = function(arg)
--   local clients = vim.tbl_map(function(client)
--     return ('%d (%s)'):format(client.id, client.name)
--   end, require('lspconfig.util').get_managed_clients())
--
--   return completion_sort(vim.tbl_filter(function(s)
--     return s:sub(1, #arg) == arg
--   end, clients))
-- end
--
-- local get_clients_from_cmd_args = function(arg)
--   local result = {}
--   for id in (arg or ''):gmatch '(%d+)' do
--     result[#result + 1] = lsp.get_client_by_id(tonumber(id))
--   end
--   if #result == 0 then
--     return require('lspconfig.util').get_managed_clients()
--   end
--   return result
-- end

for group, hi in pairs {
  LspInfoBorder = { link = 'Label', default = true },
  LspInfoList = { link = 'Function', default = true },
  LspInfoTip = { link = 'Comment', default = true },
  LspInfoTitle = { link = 'Title', default = true },
  LspInfoFiletype = { link = 'Type', default = true },
} do
  api.nvim_set_hl(0, group, hi)
end

-- Called from plugin/lspconfig.vim because it requires knowing that the last
-- script in scriptnames to be executed is lspconfig.
api.nvim_create_user_command('LspInfo', function() require 'core.lspinfo_ui'() end, {
  desc = 'Displays attached, active, and configured language servers',
})

api.nvim_create_user_command('LspLog', function() vim.cmd(string.format('tabnew %s', lsp.get_log_path())) end, {
  desc = 'Opens the Nvim LSP client log.',
})
