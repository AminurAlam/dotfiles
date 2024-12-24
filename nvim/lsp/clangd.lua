---@type vim.lsp.Config
return {
  cmd = {
    'clangd',
    '--clang-tidy',
    '--background-index',
    '--offset-encoding=utf-8',
  },
  filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda', 'proto' },
  root_markers = {
    '.clang-format',
    '.clang-tidy',
    '.clangd',
    '.git',
    'compile_commands.json',
    'compile_flags.txt',
    'configure.ac',
  },
}
