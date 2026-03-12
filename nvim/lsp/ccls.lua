---@type vim.lsp.Config
return {
  cmd = { 'ccls' },
  filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda', 'proto' },
  root_markers = { 'compile_commands.json', 'compile_flags.txt', '.ccls', 'configure.ac', '.git' },
  offset_encoding = 'utf-32',
  workspace_required = true,
}
