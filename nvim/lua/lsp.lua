local filter = function(server) return vim.fn.executable(vim.lsp.config[server].cmd[1]) == 1 end
local null_ls = require 'null-ls'
local h = require 'null-ls.helpers'

vim.lsp.enable(vim.tbl_filter(filter, {
  'basedpyright',
  'bash_language_server',
  'ccls',
  'clangd',
  'dart_language_server',
  'gopls',
  'hyprls',
  'java_language_server',
  'lua_ls',
  'ruff',
  -- 'rust_analyzer',
  'systemd',
  'taplo',
  -- 'termux_language_server',
  'texlab',
  'tinymist',
  'ts_ls',
  'vscode_css_language_server',
  'vscode_eslint_language_server',
  'vscode_html_language_server',
  'yamlls',
  'zathura',
}))

-- https://github.com/nvimtools/none-ls.nvim/blob/main/doc/BUILTINS.md
null_ls.setup {
  border = 'rounded',
  sources = {
    null_ls.builtins.formatting.prettier,
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.diagnostics.fish,
    null_ls.builtins.formatting.fish_indent,
    null_ls.builtins.formatting.clang_format.with { extra_filetypes = { 'glsl' } },
    h.make_builtin {
      name = 'taplo',
      method = 'NULL_LS_FORMATTING',
      filetypes = { 'toml' },
      generator_opts = { command = { 'taplo', 'format', '-' }, to_stdin = true },
      factory = h.formatter_factory,
    },
  },
}

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

    if client:supports_method('textDocument/documentColor') then
      vim.lsp.document_color.enable(true, info.buf)
    end

    if client:supports_method('textDocument/hover') then
      vim.keymap.set('n', 'K', function() --
        vim.lsp.buf.hover { border = 'rounded' }
      end, { buffer = info.buf })
    end

    if client:supports_method('textDocument/formatting') or client.name == 'tinymist' then
      vim.api.nvim_create_autocmd('BufWritePre', {
        buffer = info.buf,
        callback = function()
          if vim.g.save_fmt then vim.lsp.buf.format() end
        end,
      })
    end

    vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format, { buffer = info.buf })
    vim.keymap.set('n', 'grd', vim.lsp.buf.definition, { buffer = info.buf })
    vim.keymap.set('n', '<leader>sh', function()
      local ih = vim.lsp.inlay_hint
      ih.enable(not ih.is_enabled({ bufnr = 0 }))
    end, { buffer = info.buf })
  end,
})

-- stylua: ignore
vim.keymap.set('n', '<leader>li', function()
  print(table.concat(vim.tbl_map(function(client)
    return string.format('\n%s (%s): %s',
      client.name,
      client.name == 'null-ls' and '*' or table.concat(client.config.filetypes or {}, ', '),
      client.workspace_folders and vim.fn.fnamemodify(client.workspace_folders[1].name, ':~') or 'single file mode'
    )
  end, vim.lsp.get_clients()), ''))
end, { desc = 'LspInfo' })
