vim.lsp.config('java_language_server', {
  cmd = { 'java-language-server' },
  filetypes = { 'java' },
  root_markers = { 'build.gradle', 'pom.xml', '.git' },
})
