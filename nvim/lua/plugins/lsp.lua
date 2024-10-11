local M = {
  'https://github.com/neovim/nvim-lspconfig',
  enabled = true,
}

M.config = function()
  local lspconfig = require 'lspconfig'
  local nmap = function(lhs, rhs) vim.keymap.set('n', lhs, rhs) end
  local servers = {
    'bashls',
    'clangd',
    'dartls',
    'gopls',
    'java_language_server',
    'taplo',
    rust_analyzer = { ['rust-analyzer'] = { linkedProjects = nil } },
    lua_ls = {
      Lua = {
        typeFormat = { config = { auto_complete_end = true } },
        completion = { callSnippet = 'Replace', displayContext = 5 },
        diagnostics = {
          globals = { 'vim', 'drastic', 'ya', 'Command', 'cx' },
          libraryFiles = 'Disable',
          disable = { 'lowercase-global' },
        },
        format = { enable = false },
        hint = { enable = true },
        runtime = { version = 'LuaJIT' },
        semantic = { enable = false },
        telemetry = { enable = false },
        window = { progressBar = false },
        workspace = {
          checkThirdParty = false,
          library = { vim.env.VIMRUNTIME },
        },
      },
    },
    pyright = {
      python = {
        analysis = {
          diagnosticMode = 'document',
          autoSearchPaths = true,
          useLibraryCodeForTypes = true,
        },
      },
    },
    ruff = {
      init_options = {
        settings = { configuration = vim.fn.expand '~/repos/dotfiles/other/ruff.toml' },
      },
    },
    texlab = {
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
        diagnosticsDelay = 300,
        latexFormatter = 'latexindent',
        latexindent = { ['local'] = nil, modifyLineBreaks = false },
        bibtexFormatter = 'texlab',
        formatterLineLength = 80,
      },
    },
  }

  for key, value in pairs(servers) do
    if type(key) == 'number' then
      lspconfig[value].setup {}
    else
      lspconfig[key].setup { settings = value }
    end
  end

  -- require('lspconfig.ui.windows').default_options.border = 'rounded'
  vim.lsp.handlers['textDocument/hover'] =
    vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' })
  vim.lsp.handlers['textDocument/signatureHelp'] =
    vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' })

  nmap('<leader>lf', vim.lsp.buf.format)
  nmap('<leader>ca', vim.lsp.buf.code_action)
  nmap('<leader>lr', vim.lsp.buf.rename)
  nmap('gd', vim.lsp.buf.definition)
  nmap('<leader>li', '<cmd>LspInfo<cr>')
  vim.api.nvim_create_user_command('Tex', function(info)
    local status = {
      [0] = 'Success',
      [1] = 'Error',
      [2] = 'Failure',
      [3] = 'Cancelled',
    }

    if vim.fn.executable('latexmk') == 0 then
      print('latexmk is not executable!!')
      return
    end

    vim.lsp.buf.execute_command {
      command = 'texlab.cleanArtifacts',
      arguments = { { uri = vim.uri_from_bufnr(0) } },
    }
    vim.lsp.buf.execute_command {
      command = 'texlab.cleanAuxiliary',
      arguments = { { uri = vim.uri_from_bufnr(0) } },
    }
    vim.lsp.get_clients({ bufnr = 0, name = 'texlab' })[1].request('textDocument/build', {
      textDocument = { uri = vim.uri_from_bufnr(0) },
    }, function(e, r)
      if e then print(status[r.status] .. ': ' .. tostring(e), vim.log.levels.INFO) end
    end, 0)
    if info.bang then vim.cmd('!open %:r.pdf') end
  end, { desc = 'Builds your tex file', bang = true })
end

return M
