local usercmd = vim.api.nvim_create_user_command
local autocmd = vim.api.nvim_create_autocmd
local servers = {
  { { 'gopls' }, { 'go' }, { 'go.work', 'go.mod', '.git' } },
  { { 'java-language-server' }, { 'java' }, { 'build.gradle', 'pom.xml', '.git' } },
  { { 'bash-language-server', 'start' }, { 'sh', 'zsh', 'bash' }, { '.sh', '.zsh' } },
  { -- dart
    { 'dart', 'language-server', '--protocol=lsp' },
    { 'dart' },
    { 'pubspec.yaml' },
    { dart = { completeFunctionCalls = true, showTodos = true } },
  },
  { -- rust-project
    { 'rust-analyzer' },
    { 'rust' },
    {
      'Cargo.toml',
      'rust-project.json',
    },
    { ['rust-analyzer'] = { linkedProjects = nil } },
  },
  { -- taplo
    {
      'taplo',
      'lsp',
      '-c',
      (vim.env.XDG_CONFIG_HOME or vim.fn.expand '~/.config') .. '/taplo.toml',
      'stdio',
    },
    { 'toml' },
    { '*.toml', '.git' },
    {},
  },
  { -- clangd
    { 'clangd' },
    { 'c', 'cpp', 'objc', 'objcpp', 'cuda', 'proto' },
    {
      '.git',
      '.clangd',
      '.clang-tidy',
      'compile_commands.json',
      'compile_flags.txt',
      'configure.ac',
      '.clang-format',
    },
  },
  { -- pyright-langserver
    { 'pyright-langserver', '--stdio' },
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
        },
      },
    },
  },
  { -- ruff
    { 'ruff', 'server' },
    { 'python' },
    {
      'pyproject.toml',
      'setup.py',
      'setup.cfg',
      'requirements.txt',
      '.git',
    },
    {
      init_options = {
        settings = { configuration = vim.fn.expand '~/repos/dotfiles/other/ruff.toml' },
      }, -- TODO
    },
  },
  { -- lua-language-server
    { 'lua-language-server' },
    { 'lua' },
    { 'lua/' },
    {
      Lua = {
        -- library = vim.api.nvim_get_runtime_file('', true),
        typeFormat = { config = { auto_complete_end = true } },
        completion = { callSnippet = 'Replace', displayContext = 5 },
        diagnostics = {
          globals = { 'vim', 'drastic', 'ya', 'Command', 'cx' },
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
    },
  },
  { -- texlab
    { 'texlab' },
    { 'tex', 'plaintex', 'bib' },
    {
      '.git',
      '.latexmkrc',
      '.texlabroot',
      'texlabroot',
      'Tectonic.toml',
    },
    {
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
    },
  },
}

for _, server in pairs(servers) do
  local cmd = server[1]
  vim.api.nvim_create_autocmd('Filetype', {
    pattern = server[2],
    callback = function(buf)
      if vim.fn.filereadable(buf.file) == 0 then return end -- FIX: someone keeps spawning unlisted lua buffers??
      local client_id = vim.lsp.start({
        name = cmd[1],
        cmd = cmd,
        filetypes = server[2],
        single_file_support = true,
        root_dir = vim.fs.root(0, server[3] or {}), -- https://github.com/neovim/neovim/pull/28477
        settings = server[4] or {},
      }, { silent = true }) -- https://github.com/neovim/neovim/pull/28478
      if client_id then vim.lsp.buf_attach_client(buf.id, client_id) end
    end,
  })
end

usercmd('TexBuild', function(info)
  local status = {
    [0] = 'Success',
    [1] = 'Error',
    [2] = 'Failure',
    [3] = 'Cancelled',
  }

  if vim.fn.executable('latexmk') == 0 then
    print('latexmk is not executable!!')
    return
  end

  vim.lsp.get_clients({ bufnr = 0, name = 'texlab' })[1].request('textDocument/build', {
    textDocument = { uri = vim.uri_from_bufnr(0) },
  }, function(e, r)
    if e then print(status[r.status] .. ': ' .. tostring(e), vim.log.levels.INFO) end
  end, 0)
  if info.bang then vim.cmd('!open %:r.pdf') end
end, { desc = 'Builds your tex file', bang = true })

usercmd('TexClean', function()
  vim.lsp.buf.execute_command {
    command = 'texlab.cleanArtifacts',
    arguments = { { uri = vim.uri_from_bufnr(0) } },
  }
  vim.lsp.buf.execute_command {
    command = 'texlab.cleanAuxiliary',
    arguments = { { uri = vim.uri_from_bufnr(0) } },
  }
end, { desc = 'cleans up temp files' })

usercmd('LspInfo', function()
  local clients = vim.lsp.get_clients()
  local text = #clients .. ' clients attached\n'
  local template = [[ CLIENT: %s (id: %d)
     ft: %s
     ws: %s
]]

  local get_ws = function(dirs)
    return dirs and vim.fn.fnamemodify(dirs[1].name, ':~') or 'single file mode'
  end

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

usercmd('LspLog', function() vim.cmd.tabnew(vim.lsp.get_log_path()) end, {
  desc = 'Opens the Nvim LSP client log.',
})

autocmd('LspAttach', {
  callback = function(info)
    local nmap = function(lhs, rhs) vim.keymap.set('n', lhs, rhs, { buffer = info.buf }) end

    nmap('<leader>li', vim.lsp.buf.format)
    nmap('<leader>lf', vim.lsp.buf.format)
    nmap('<leader>ca', vim.lsp.buf.code_action)
    nmap('<leader>lr', vim.lsp.buf.rename)
    nmap('gd', vim.lsp.buf.definition)

    -- local client = vim.lsp.get_client_by_id(info.data.client_id)
    -- if client == nil then return end
    -- if client.name == 'ruff' then client.server_capabilities.hoverProvider = false end
    -- if client.supports_method('textDocument/definition') then end
  end,
})

vim.lsp.handlers['textDocument/hover'] =
  vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' })
vim.lsp.handlers['textDocument/signatureHelp'] =
  vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' })
