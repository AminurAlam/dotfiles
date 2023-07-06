if vim.fn.executable('pyright-langserver') then
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

if vim.fn.executable('pylsp') then
  vim.lsp.start({
    cmd = { 'pylsp' },
    filetypes = { 'python' },
    -- root_dir = function(fname)
    --   local root_files = { 'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', 'Pipfile' }
    --   return util.root_pattern(unpack(root_files))(fname) or util.find_git_ancestor(fname)
    -- end,
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
