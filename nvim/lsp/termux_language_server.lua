---@type vim.lsp.Config
return {
  cmd = { 'termux-language-server' },
  filetypes = { 'sh' }, -- TODO: better detection
  root_markers = { '.git' },
}
