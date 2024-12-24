---@type vim.lsp.Config
return {
  cmd = { 'java-language-server' },
  filetypes = { 'java' },
  root_markers = { 'build.gradle', 'pom.xml', '.git' },
}
