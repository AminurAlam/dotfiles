vim.lsp.log.set_level(vim.log.levels.ERROR)

local filter = function(server)
  return vim.fn.executable(vim.lsp.config[server].cmd[1]) == 1
end

vim.lsp.enable(vim.tbl_filter(filter, {
  'basedpyright',
  -- 'bash_language_server',
  'biome',
  'ccls',
  'clangd',
  'hyprls',
  'lua_ls',
  'nushell',
  'ruff',
  -- 'rust_analyzer',
  'systemd_lsp',
  'taplo',
  -- 'termux_language_server',
  'tinymist',
  -- 'tombi',
  'ts_ls',
  'ty',
  'vscode_css_language_server',
  'vscode_eslint_language_server',
  'vscode_html_language_server',
  'yamlls',
  'zathura',
}))

-- https://github.com/stevearc/conform.nvim#formatters
-- TODO: keybind to turn off format on save
require('conform').setup({
  formatters_by_ft = {
    lua = { 'stylua' },
    toml = { 'taplo' },
    fish = { 'fish_indent' },
  },
  format_on_save = { timeout_ms = 500, lsp_format = 'fallback' },
  notify_no_formatters = true,
})

vim.api.nvim_create_autocmd({ 'BufEnter' }, {
  desc = 'start termux lsp on opening specific files',
  pattern = { 'build.sh', '*.subpackage.sh' },
  callback = function()
    if vim.fn.executable 'termux-language-server' == 0 then
      return
    end
    vim.lsp.start({
      name = 'termux',
      cmd = { 'termux-language-server' },
    })
  end,
})

vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'enable lsp features',
  callback = function(args)
    local client = vim.lsp.get_client_by_id(vim.tbl_get(args, 'data', 'client_id'))

    if client == nil then
      return
    end

    if client:supports_method('textDocument/completion') or client.name == 'tinymist' then
      vim.bo[args.buf].omnifunc = 'v:lua.MiniCompletion.completefunc_lsp'
    end

    if client:supports_method('textDocument/hover') then
      vim.keymap.set('n', 'K', function() --
        vim.lsp.buf.hover { border = 'rounded' }
      end, { buffer = args.buf })
    end

    if client:supports_method('textDocument/documentColor') then
      vim.lsp.document_color.enable(true, { bufnr = args.buf }, { style = 'background' })
    end

    if client:supports_method('textDocument/linkedEditingRange') then
      vim.lsp.linked_editing_range.enable(true, { client_id = client.id })
    end

    if client:supports_method('textDocument/onTypeFormatting') then
      vim.lsp.on_type_formatting.enable(true, { client_id = client.id })
    end

    vim.keymap.set('n', 'grd', vim.lsp.buf.definition, { buffer = args.buf })
  end,
})

-- stylua: ignore
vim.keymap.set('n', '<leader>li', function()
  print(table.concat(vim.tbl_map(function(client)
    return string.format('\n%d %s (%s): %s',
      client.id,
      client.name,
      client.name == 'null-ls' and '*' or table.concat(client.config.filetypes or {}, ', '),
      client.workspace_folders and vim.fn.fnamemodify(client.workspace_folders[1].name, ':~') or 'single file mode'
    )
  end, vim.lsp.get_clients()), ''))
end, { desc = 'LspInfo' })
