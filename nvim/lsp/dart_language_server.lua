vim.lsp.config('dart_language_server', {
  cmd = { 'dart', 'language-server', '--protocol=lsp' },
  filetypes = { 'dart' },
  root_markers = { 'pubspec.yaml', '.git' },
})
