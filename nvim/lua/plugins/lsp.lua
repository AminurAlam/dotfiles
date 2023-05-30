local M = {
  'neovim/nvim-lspconfig',
}

M.config = function()
  local lspconfig = require('lspconfig')
  local setup_lsp = function(name, bin, config)
    if vim.fn.executable(bin) == 0 then return end
    lspconfig[name].setup {
      settings = config or {},
      -- on_attach = function(client, bufnr)
      --   client.server_capabilities.semanticTokensProvider = nil
      -- end,
    }
  end

  require('lspconfig.ui.windows').default_options.border = 'rounded'

  require('neodev').setup {
    library = {
      enabled = true,
      runtime = true,
      types = true,
      plugins = true,
    },
    setup_jsonls = false,
  }

  setup_lsp('clangd', 'clangd')

  setup_lsp('lua_ls', 'lua-language-server', {
    Lua = {
      library = vim.api.nvim_get_runtime_file('', true),
      typeFormat = {
        config = { auto_complete_end = true },
      },
      diagnostics = {
        globals = { 'vim' },
        disable = { 'lowercase-global' },
      },
      format = {
        enable = false, -- using stylua instead
        defaultConfig = {
          indent_style = 'space',
          indent_size = '2',
        },
      },
      completion = {
        callSnippet = 'Replace',
        displayContext = 5,
      },
      runtime = { version = 'LuaJIT' },
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  })

  setup_lsp('pyright', 'pyright-langserver', {
    python = {
      analysis = {
        autoSearchPaths = true,
        diagnosticMode = 'document',
        useLibraryCodeForTypes = true,
      },
    },
  })

  setup_lsp('pylsp', 'pylsp', {
    pylsp = {
      plugins = {
        pycodestyle = { ignore = { 'E128', 'E701' }, maxLineLength = 100 },
        flake8 = { enabled = true, maxLineLength = 100, ignore = { 'E128', 'E701' } },
      },
    },
  })
end

return M
