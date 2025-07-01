local filter = function(server) return vim.fn.executable(vim.lsp.config[server].cmd[1]) == 1 end
vim.lsp.enable(vim.tbl_filter(filter, {
  'basedpyright',
  'bash_language_server',
  'clangd',
  'dart_language_server',
  'gopls',
  'hyprls',
  'java_language_server',
  'lua_ls',
  'ruff',
  'rust_analyzer',
  'taplo',
  -- 'termux_language_server',
  'texlab',
  'ts_ls',
  'vscode_css_language_server',
  'vscode_eslint_language_server',
  'vscode_html_language_server',
}))

vim.api.nvim_create_autocmd({ 'BufEnter' }, {
  desc = 'start termux lsp on opening specific files',
  pattern = {
    'build.sh',
    '*.subpackage.sh',
    'PKGBUILD',
    '*.install',
    'makepkg.conf',
    '*.ebuild',
    '*.eclass',
    'color.map',
    'make.conf',
  },
  callback = function()
    if vim.fn.executable 'termux-language-server' == 0 then return end
    vim.lsp.start({
      name = 'termux',
      cmd = { 'termux-language-server' },
    })
  end,
})

vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'enable lsp features',
  callback = function(info)
    local client = vim.lsp.get_client_by_id(vim.tbl_get(info, 'data', 'client_id'))

    if client == nil then return end
    if client:supports_method('textDocument/hover') then
      vim.keymap.set('n', 'K', function() --
        vim.lsp.buf.hover { border = 'rounded' }
      end, { buffer = info.buf })
    end

    if client:supports_method('textDocument/documentColor') then
      vim.lsp.document_color.enable(true, info.buf)
    end

    -- if client:supports_method('textDocument/inlayHint') then
    --   vim.lsp.inlay_hint.enable(true, { bufnr = info.buf })
    -- end

    vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format, { buffer = info.buf })
    vim.keymap.set('n', 'grd', vim.lsp.buf.definition, { buffer = info.buf })
  end,
})
