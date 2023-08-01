if vim.fn.executable('pyright-langserver') == 1 then
  vim.lsp.start({
    cmd = { 'pyright-langserver', '--stdio' },
    filetypes = { 'python' },
    -- root_dir = util.root_pattern(unpack(root_files)),
    single_file_support = true,
    settings = {
      python = {
        analysis = {
          diagnosticMode = 'document', -- 'workspace',
          autoSearchPaths = true,
          useLibraryCodeForTypes = true,
        },
      },
    },
  })
end

if vim.fn.executable('pylsp') == 1 then
  vim.lsp.start({
    cmd = { 'pylsp' },
    filetypes = { 'python' },
    root_dir = vim.fs.dirname(vim.fs.find({
      'pyproject.toml',
      'setup.py',
      'setup.cfg',
      'requirements.txt',
      'Pipfile',
      '.git',
    }, { upwards = true })[1]),
    single_file_support = true,
    settings = {
      pylsp = {
        plugins = {
          pycodestyle = { ignore = { 'E128', 'E701' }, maxLineLength = 100 },
          flake8 = { enabled = true, maxLineLength = 100, ignore = { 'E128', 'E701' } },
        },
      },
    },
  })
end
