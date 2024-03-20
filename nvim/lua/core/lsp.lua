---@param cmd table[string]
---@param filetypes table[string]
---@param root_dir table[string]
---@param settings table?
local function create(cmd, filetypes, root_dir, settings)
  vim.api.nvim_create_autocmd('Filetype', {
    pattern = filetypes,
    -- once = true,
    callback = function(buf)
      -- vim.print(buf)
      if vim.fn.executable(cmd[1]) == 1 then
        vim.lsp.start {
          name = cmd[1],
          cmd = cmd,
          filetypes = filetypes,
          single_file_support = true,
          root_dir = vim.fs.dirname(vim.fs.find(root_dir, { upwards = true })[1]),
          settings = settings or {},
        }
      end
    end,
  })
end

create({ 'gopls' },
  { 'go' },
  { 'go.work', 'go.mod', '.git' }
)

create({ 'java-language-server' },
  { 'java' },
  { 'build.gradle', 'pom.xml', '.git' }
)

create({ 'bash-language-server', 'start' },
  { 'sh', 'zsh', 'bash' },
  { '.sh', '.zsh', '.bash' }
)

create({ 'dart', 'language-server', '--protocol=lsp' },
  { 'dart' },
  { 'pubspec.yaml' },
  { dart = { completeFunctionCalls = true, showTodos = true } }
)

create({ 'rust-analyzer' },
  { 'rust' },
  { 'Cargo.toml', 'rust-project.json' },
  { ['rust-analyzer'] = { linkedProjects = nil } }
)

create({ 'ruff-lsp' },
  { 'python' },
  {
    'pyproject.toml',
    'setup.py',
    'setup.cfg',
    'requirements.txt',
    'Pipfile',
    '.git',
  }
)

create({ 'clangd' },
  { 'c', 'cpp', 'objc', 'objcpp', 'cuda', 'proto' },
  {
    '.git',
    '.clangd',
    '.clang-tidy',
    '.clang-format',
    'compile_commands.json',
    'compile_flags.txt',
    'configure.ac',
  }
)

create({ 'pyright-langserver', '--stdio' },
  { 'python' },
  {
    'pyproject.toml',
    'setup.py',
    'setup.cfg',
    'requirements.txt',
    'Pipfile',
    '.git',
  },
  {
    python = {
      analysis = {
        diagnosticMode = 'document',
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
      }
    }
  }
)

create({ 'lua-language-server' },
  { 'lua' },
  { 'init.lua', 'lua' }, {
    Lua = {
      -- library = vim.api.nvim_get_runtime_file('', true),
      typeFormat = { config = { auto_complete_end = true } },
      completion = { callSnippet = 'Replace', displayContext = 5 },
      diagnostics = {
        globals = { 'vim', 'drastic' },
        libraryFiles = 'Disable',
        disable = { 'lowercase-global' },
      },
      format = { enable = false },
      hint = { enable = true },
      runtime = { version = 'LuaJIT' },
      semantic = { enable = false },
      telemetry = { enable = false },
      window = { progressBar = false },
      workspace = { checkThirdParty = false },
    }
  }
)



---@return string
local info = function()

  local text = ''
  local template = [[ CLIENT: %s (id: %d)
     ft: %s
     ws: %s
]]

  for _, client in pairs(vim.lsp.get_clients()) do
    text = text .. string.format(
      template,
      client.name,
      client.id,
      table.concat(client.config.filetypes, ', '),
      vim.fn.fnamemodify(client.workspace_folders[1].name, ':~')
    )
    -- vim.print(client)
    -- vim.print(client.config.cmd)
  end
  return text
end

-- TODO: put this in a floating window
vim.api.nvim_create_user_command('LspInfo', function ()
  print(info())
end, {
  desc = 'Display attached language servers',
})

vim.api.nvim_create_user_command('LspLog', function() vim.cmd(string.format('tabnew %s', vim.lsp.get_log_path())) end, {
  desc = 'Opens the Nvim LSP client log.',
})

return {
  create = create,
  info = info
}
