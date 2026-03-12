---@type vim.lsp.Config
return {
  cmd = { 'vscode-css-language-server', '--stdio' },
  filetypes = { 'css', 'scss', 'less' },
  root_markers = { 'package.json', '.git' },
  settings = {
    -- https://code.visualstudio.com/Docs/languages/CSS
    css = {
      validate = true,
      lint = {
        duplicateProperties = 'warning',
        emptyRules = 'ignore',
      },
    },
    scss = { validate = true },
    less = { validate = true },
  },
}
