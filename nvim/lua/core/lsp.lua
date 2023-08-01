local autocmd = vim.api.nvim_create_autocmd

---@param cmd string
---@param filetypes table[string]
---@param root_dir table[string]
local start = function(cmd, filetypes, root_dir, settings)
  if vim.fn.executable(cmd) == 1 then
    vim.lsp.start {
      cmd = { cmd },
      filetypes = filetypes,
      single_file_support = true,
      root_dir = vim.fs.dirname(vim.fs.find(root_dir, { upwards = true })[1]),
      settings = settings,
    }
  end
end

autocmd('Filetype', {
  pattern = { 'c', 'cpp', 'objc', 'objcpp', 'cuda', 'proto' },
  once = true,
  callback = function()
    start('clangd', { 'c', 'cpp', 'objc', 'objcpp', 'cuda', 'proto' }, {
      '.git',
      '.clangd',
      '.clang-tidy',
      '.clang-format',
      'compile_commands.json',
      'compile_flags.txt',
      'configure.ac',
    })
  end,
})

autocmd('Filetype', {
  pattern = { 'rust' },
  once = true,
  callback = function()
    start('rust-analyzer', { 'rust' }, { 'Cargo.toml' }, {
      ['rust-analyzer'] = { linkedProjects = nil },
    })
  end,
})

-- local lsp_info = function()
--   vim.fl
-- end
