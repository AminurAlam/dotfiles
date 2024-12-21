vim.lsp.config('bash_language_server', {
  cmd = { 'bash-language-server', 'start' },
  filetypes = { 'sh', 'zsh', 'bash' },
})
