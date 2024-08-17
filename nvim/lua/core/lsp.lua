---@param cmd table[string]
---@param filetypes table[string]
---@param root_dir table[string]
---@param settings table?
local function create(cmd, filetypes, root_dir, settings)
  vim.api.nvim_create_autocmd('Filetype', {
    pattern = filetypes,
    callback = function(buf)
      local client_id = vim.lsp.start({
        name = cmd[1],
        cmd = cmd,
        filetypes = filetypes,
        single_file_support = true,
        root_dir = vim.fs.root(0, root_dir), -- https://github.com/neovim/neovim/commit/38b9c322c97b63f53caef7a651211fc9312d055e
        settings = settings or {},
      }, { silent = false }) -- https://github.com/neovim/neovim/commit/37d8e504593646c81542f8c66f0d608e0a59f036
      if client_id then vim.lsp.buf_attach_client(buf.id, client_id) end
    end,
  })
end

create({ 'taplo', 'lsp', 'stdio' }, { 'toml' }, { '*.toml', '.git' }, {})
create({ 'gopls' }, { 'go' }, { 'go.work', 'go.mod', '.git' })
create({ 'java-language-server' }, { 'java' }, { 'build.gradle', 'pom.xml', '.git' })
create({ 'bash-language-server', 'start' }, { 'sh', 'zsh', 'bash' }, { '.sh', '.zsh', '.bash' })
-- stylua: ignore
create({ 'dart', 'language-server', '--protocol=lsp' },
  { 'dart' },
  { 'pubspec.yaml' },
  { dart = { completeFunctionCalls = true, showTodos = true } }
)
create({ 'rust-analyzer' }, { 'rust' }, {
  'Cargo.toml',
  'rust-project.json',
}, { ['rust-analyzer'] = { linkedProjects = nil } })
create({ 'ruff', 'server' }, { 'python' }, {
  'pyproject.toml',
  'setup.py',
  'setup.cfg',
  'requirements.txt',
  '.git',
}, {
  init_options = { settings = { configuration = '~/repos/dotfiles/other/ruff.toml' } },
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
create({ 'pyright-langserver', '--stdio' }, { 'python' }, {
  'pyproject.toml',
  'setup.py',
  'setup.cfg',
  'requirements.txt',
  'Pipfile',
  '.git',
}, {
  python = {
    analysis = {
      diagnosticMode = 'document',
      autoSearchPaths = true,
      useLibraryCodeForTypes = true,
    },
  },
})
create({ 'lua-language-server' }, { 'lua' }, { 'init.lua', 'lua' }, {
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
    workspace = {
      checkThirdParty = false,
      library = { vim.env.VIMRUNTIME },
    },
  },
})
create({ 'texlab' }, { 'tex', 'plaintex', 'bib' }, {
  '.git',
  '.latexmkrc',
  '.texlabroot',
  'texlabroot',
  'Tectonic.toml',
}, {
  texlab = {
    rootDirectory = nil,
    build = {
      executable = 'latexmk',
      args = { '-pdf', '-interaction=nonstopmode', '-synctex=1', '%f' },
      onSave = true,
      forwardSearchAfter = false,
    },
    auxDirectory = '.',
    forwardSearch = { executable = nil, args = {} },
    chktex = { onOpenAndSave = false, onEdit = false },
    diagnosticsDelay = 300,
    latexFormatter = 'latexindent',
    latexindent = { ['local'] = nil, modifyLineBreaks = false },
    bibtexFormatter = 'texlab',
    formatterLineLength = 80,
  },
})


-- vim.api.nvim_create_autocmd('LspAttach', {
--   desc = 'LSP: Disable hover capability from Ruff',
--   once = true,
--   callback = function(args)
--     local client = vim.lsp.get_client_by_id(args.data.client_id)
--     if client == nil then return end
--     if client.name == 'ruff' then client.server_capabilities.hoverProvider = false end
--   end,
-- })


vim.api.nvim_create_user_command('TexBuild', function(info)
  local status = {
    [0] = 'Success',
    [1] = 'Error',
    [2] = 'Failure',
    [3] = 'Cancelled',
  }

  vim.lsp.get_clients({ bufnr = 0, name = 'texlab' })[1].request('textDocument/build', {
    textDocument = { uri = vim.uri_from_bufnr(0) },
  }, function(e, r)
    if e then print(status[r.status] .. ': ' .. tostring(e), vim.log.levels.INFO) end
  end, 0)
  if info.bang then vim.cmd('!open %:r.pdf') end
end, { desc = 'Builds your tex file', bang = true })

vim.api.nvim_create_user_command('TexClean', function()
  vim.lsp.buf.execute_command { command = 'texlab.cleanArtifacts', arguments = { { uri = vim.uri_from_bufnr(0) } } }
  vim.lsp.buf.execute_command { command = 'texlab.cleanAuxiliary', arguments = { { uri = vim.uri_from_bufnr(0) } } }
end, { desc = 'cleans up temp files' })

vim.api.nvim_create_user_command('LspInfo', function()
  local clients = vim.lsp.get_clients()
  local text = #clients .. ' clients attached\n'
  local template = [[ CLIENT: %s (id: %d)
     ft: %s
     ws: %s
]]

  local get_ws = function(dirs) return dirs and vim.fn.fnamemodify(dirs[1].name, ':~') or 'single file mode' end

  for _, client in pairs(clients) do
    text = text
      .. string.format(
        template,
        client.name,
        client.id,
        table.concat(client.config.filetypes, ', '),
        get_ws(client.workspace_folders) -- client.config.root_dir
      )
  end
  print(text)
end, {
  desc = 'Display attached language servers',
})

vim.api.nvim_create_user_command('LspLog', function() vim.cmd(string.format('tabnew %s', vim.lsp.get_log_path())) end, {
  desc = 'Opens the Nvim LSP client log.',
})
