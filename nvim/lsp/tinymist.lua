---@type vim.lsp.Config
return {
  cmd = { 'tinymist' },
  filetypes = { 'typst' },
  root_markers = { '.git' },
  -- https://myriad-dreamin.github.io/tinymist/config/neovim.html
  settings = {
    exportPdf = 'onType',
    formatterMode = 'typstyle',
    formatterPrintWidth = 85,
    formatterProseWrap = true,
    lint = { enabled = true },
    syntaxOnly = 'disable',
  },
}
