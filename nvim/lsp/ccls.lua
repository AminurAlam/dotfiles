---@type vim.lsp.Config
return {
  cmd = { 'ccls' },
  filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda', 'proto' },
  root_markers = {
    '.git',
    'compile_commands.json',
    'compile_flags.txt',
    'configure.ac',
  },
}
