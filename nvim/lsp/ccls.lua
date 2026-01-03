---@type vim.lsp.Config
return {
  cmd = { 'ccls' },
  filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda', 'proto' },
  root_markers = {
    'compile_commands.json',
    'compile_flags.txt',
    '.git',
    '.ccls',
    'configure.ac',
  },
}
