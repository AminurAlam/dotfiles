---@type vim.lsp.Config
return {
  cmd = { 'texlab' },
  filetypes = { 'tex', 'plaintex', 'bib' },
  root_markers = {
    '.latexmkrc',
    '.texlabroot',
    'texlabroot',
    'Tectonic.toml',
    '.git',
  },
  settings = {
    texlab = {
      rootDirectory = nil,
      build = {
        executable = 'latexmk',
        args = { '-pdf', '-interaction=nonstopmode', '-synctex=1', '%f' },
        onSave = true,
        forwardSearchAfter = false,
      },
      auxDirectory = '.',
      forwardSearch = { executable = nil, args = {} },
      chktex = { onOpenAndSave = false, onEdit = false },
      diagnosticsDelay = 100,
      latexFormatter = 'latexindent',
      latexindent = { ['local'] = nil, modifyLineBreaks = false },
      bibtexFormatter = 'texlab',
      formatterLineLength = 80,
    },
  },
}
