local filter = function(server)
  return vim.fn.executable(vim.lsp.config[server].cmd[1]) == 1
end
local null_ls = require 'null-ls'
local h = require 'null-ls.helpers'

vim.lsp.enable(vim.tbl_filter(filter, {
  'basedpyright',
  'bash_language_server',
  'ccls',
  'clangd',
  'hyprls',
  'lua_ls',
  'nushell',
  'ruff',
  -- 'rust_analyzer',
  'systemd',
  -- 'taplo',
  -- 'termux_language_server',
  'tinymist',
  'tombi',
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
    -- h.make_builtin {
    --   name = 'taplo',
    --   method = 'NULL_LS_FORMATTING',
    --   filetypes = { 'toml' },
    --   generator_opts = { command = { 'taplo', 'format', '-' }, to_stdin = true },
    --   factory = h.formatter_factory,
    -- },
    h.make_builtin {
      name = 'kanata',
      method = 'NULL_LS_DIAGNOSTICS_ON_SAVE',
      filetypes = { 'kanata' },
      factory = h.generator_factory,
      generator_opts = {
        command = 'kanata',
        args = { '-q', '--check', '--cfg-stdin' },
        from_stderr = true,
        to_stdin = true,
        ignore_stderr = false,
        multiple_files = false,
        format = 'raw',
        check_exit_code = function(c)
          return c <= 1
        end,
        on_output = function(params, done)
          local efm = '%-G%.%# [ERROR] %.%#,%E %.%#╭─[%f:%l:%c],%Z  help: %m,%-C%.%#'
          local source = 'kanata'
          local output = params.output
          if not output then
            return done()
          end

          local diagnostics = {}
          local lines = require('null-ls.utils').split_at_newline(params.bufnr, output)

          local qflist = vim.fn.getqflist({ efm = efm, lines = lines })
          local severities = { e = 1, w = 2, i = 3, n = 4 }

          for _, item in pairs(qflist.items) do
            if item.valid == 1 then
              local col = item.col > 0 and item.col - 1 or 0
              table.insert(diagnostics, {
                row = item.lnum + 1,
                col = col,
                source = source,
                message = item.text,
                severity = severities[item.type],
              })
            end
          end

          return done(diagnostics)
        end,
      },
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

    if client:supports_method('textDocument/formatting') or client.name == 'tinymist' then
      -- [[
      vim.api.nvim_create_autocmd('BufWritePre', {
        buffer = args.buf,
        callback = function()
          if vim.g.save_fmt then
            vim.lsp.buf.format()
          end
        end,
      }) --]]
    end

    if client:supports_method('textDocument/documentColor') then
      vim.lsp.document_color.enable(true, args.buf)
    end

    if client:supports_method('textDocument/linkedEditingRange') then
      vim.lsp.linked_editing_range.enable(true, { client_id = client.id })
    end

    if client:supports_method('textDocument/onTypeFormatting') then
      vim.lsp.on_type_formatting.enable(true, { client_id = client.id })
    end

    vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format, { buffer = args.buf })
    vim.keymap.set('n', 'grd', vim.lsp.buf.definition, { buffer = args.buf })
    vim.keymap.set('n', '<leader>sh', function()
      local ih = vim.lsp.inlay_hint
      ih.enable(not ih.is_enabled({ bufnr = 0 }))
    end, { buffer = args.buf })
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
