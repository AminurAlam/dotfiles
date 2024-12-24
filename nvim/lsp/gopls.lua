---@type vim.lsp.Config
return {
  cmd = { 'gopls' },
  filetypes = { 'go' },
  root_markers = { 'go.work', 'go.mod', '.git' },
}
