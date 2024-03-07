vim.opt_local.cinkeys:remove { ':' }

--[[
local pylug = { enabled = true, maxLineLength = 100, ignore = { 'E128', 'E701' } }
local root = {
  'pyproject.toml',
  'setup.py',
  'setup.cfg',
  'requirements.txt',
  'Pipfile',
  '.git',
}

if vim.fn.executable('ruff-lsp') == 1 then
  vim.lsp.start({
    cmd = { 'ruff-lsp' },
    filetypes = { 'python' },
    root_dir = vim.fs.dirname(vim.fs.find(root, { upwards = true })[1]),
    single_file_support = true,
    settings = {},
  })
end

if vim.fn.executable('pyright-langserver') == 1 then
  vim.lsp.start({
    cmd = { 'pyright-langserver', '--stdio' },
    filetypes = { 'python' },
    root_dir = vim.fs.dirname(vim.fs.find(root, { upwards = true })[1]),
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
    root_dir = vim.fs.dirname(vim.fs.find(root, { upwards = true })[1]),
    single_file_support = true,
    settings = { pylsp = { plugins = { pycodestyle = pylug, flake8 = pylug } } },
  })
end --]]
