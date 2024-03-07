---@param cmd table[string]
---@param filetypes table[string]
---@param root_dir table[string]
---@param settings table|nil
local function create(cmd, filetypes, root_dir, settings)
  vim.api.nvim_create_autocmd('Filetype', {
    pattern = filetypes,
    once = true,
    callback = function(buf)
      -- vim.print(buf)
      if vim.fn.executable(cmd[1]) == 1 then
        vim.lsp.start {
          name = cmd[1],
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

local pylug = { enabled = true, maxLineLength = 100, ignore = { 'E128', 'E701' } }
local py_root = {
  'pyproject.toml',
  'setup.py',
  'setup.cfg',
  'requirements.txt',
  'Pipfile',
  '.git',
}

create({ 'gopls' }, { 'go' }, { 'go.work', 'go.mod', '.git' })

create({ 'bash-language-server', 'start' }, { 'sh', 'bash' }, {}, {})

create({ 'ruff-lsp' }, { 'python' }, py_root, {})

create({ 'pylsp' }, { 'python' }, py_root, {
  pylsp = { plugins = { pycodestyle = pylug, flake8 = pylug } },
})

create({ 'dart', 'language-server', '--protocol=lsp' }, { 'dart' }, { 'pubspec.yaml' }, {
  dart = { completeFunctionCalls = true, showTodos = true },
})

create({ 'rust-analyzer' }, { 'rust' }, { 'Cargo.toml', 'rust-project.json' }, {
  ['rust-analyzer'] = { linkedProjects = nil },
})

create({ 'pyright-langserver', '--stdio' }, { 'python' }, py_root, {
  python = {
    analysis = {
      diagnosticMode = 'document', -- 'workspace',
      autoSearchPaths = true,
      useLibraryCodeForTypes = true,
    },
  },
})

create({ 'clangd' }, { 'c', 'cpp', 'objc', 'objcpp', 'cuda', 'proto' }, {
  '.git',
  '.clangd',
  '.clang-tidy',
  '.clang-format',
  'compile_commands.json',
  'compile_flags.txt',
  'configure.ac',
})

create({ 'lua-language-server' }, { 'lua' }, { 'init.lua', 'lua' }, {
  Lua = {
    -- library = vim.api.nvim_get_runtime_file('', true),
    typeFormat = { config = { auto_complete_end = true } },
    completion = { callSnippet = 'Replace', displayContext = 5 },
    diagnostics = {
      globals = { 'vim', 'drastic' },
      libraryFiles = 'Disable',
      -- disable = { 'lowercase-global' },
    },
    format = { enable = false }, -- using stylua instead
    hint = { enable = true },
    runtime = { version = 'LuaJIT' },
    semantic = { enable = false },
    telemetry = { enable = false },
    window = { progressBar = false },
    workspace = { checkThirdParty = false },
  },
}) --]]


for group, hi in pairs {
  LspInfoBorder = { link = 'Label', default = true },
  LspInfoList = { link = 'Function', default = true },
  LspInfoTip = { link = 'Comment', default = true },
  LspInfoTitle = { link = 'Title', default = true },
  LspInfoFiletype = { link = 'Type', default = true },
} do
  vim.api.nvim_set_hl(0, group, hi)
end

-- TODO: put this in a float
vim.api.nvim_create_user_command('LspInfo2', function()
  ---@param workspace_folders table?
  ---@return string
  local get_workspace_folders = function(workspace_folders)
    local dirs = {}
    if workspace_folders then
      for _, y in pairs(workspace_folders) do
        table.insert(dirs, y.name)
      end
      return vim.fn.join(dirs)
    end
    return 'single file mode'
  end

  for _, x in pairs(vim.lsp.get_clients()) do
    local buf = string.format(
      [[
  CLIENT: %s (id: %d)
    ft: %s
    ws: %s
  ]],
      x.name,
      x.id,
      vim.fn.join(x.config.filetypes, ', '),
      get_workspace_folders(x.workspace_folders)
    )
    print(buf)
    -- vim.print(x)
    -- vim.print(x.config.cmd)
  end
end, {
  desc = 'Displays attached, active, and configured language servers',
})

vim.api.nvim_create_user_command('LspLog', function() vim.cmd(string.format('tabnew %s', vim.lsp.get_log_path())) end, {
  desc = 'Opens the Nvim LSP client log.',
})
