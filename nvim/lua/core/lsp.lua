-- TODO: format on write
local autocmd = vim.api.nvim_create_autocmd
local servers = {
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
  'vscode_css_language_server',
  'vscode_eslint_language_server',
  'vscode_html_language_server',
}

if vim.fn.has('nvim-0.11.0') == 1 then vim.lsp.enable(servers) end

vim.api.nvim_create_autocmd({ 'BufEnter' }, {
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
    vim.lsp.start({
      name = 'termux',
      cmd = { 'termux-language-server' },
    })
  end,
})

-- stylua: ignore
vim.api.nvim_create_user_command('Tex', function()
  vim.cmd(':silent !latexmk -pdf -interaction=nonstopmode -synctex=1 % ; open %:r.pdf')
end, { desc = 'Builds your tex file', bang = true })

-- stylua: ignore
vim.api.nvim_create_user_command('TexClean', function()
    vim.cmd(':silent !rm %:r.aux %:r.toc %:r.fdb_latexmk %:r.fls %:r.log %:r.pdf %:r.synctex.gz')
end, { desc = 'Builds your tex file', bang = true })

autocmd('LspAttach', {
  callback = function(info)
    local nmap = function(lhs, rhs) vim.keymap.set('n', lhs, rhs, { buffer = info.buf }) end
    local client = vim.lsp.get_client_by_id(vim.tbl_get(info, 'data', 'client_id'))

    nmap('<leader>lf', vim.lsp.buf.format)
    nmap('grd', vim.lsp.buf.definition)
    nmap('<leader>li', function()
      local clients = vim.lsp.get_clients()
      local text = #clients .. ' clients attached\n'
      local template = [[ CLIENT: %s (id: %d)
     ft: %s
     ws: %s
]]

      local get_ws = function(dirs)
        return dirs and vim.fn.fnamemodify(dirs[1].name, ':~') or 'single file mode'
      end

      for _, client in pairs(clients) do
        text = text
          .. string.format(
            template,
            client.name,
            client.id,
            table.concat(client.config.filetypes, ', '),
            get_ws(client.workspace_folders) -- client.config.root_dir
          )
      end
      print(text)
    end)

    if client == nil then return end
    if client:supports_method('textDocument/hover') then
      nmap('K', function() vim.lsp.buf.hover { border = 'rounded' } end)
    end
    -- if client:supports_method('textDocument/inlayHint') then
    --   vim.lsp.inlay_hint.enable(true, { bufnr = info.buf })
    -- end
  end,
})
