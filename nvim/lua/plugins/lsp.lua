local M = {
  'neovim/nvim-lspconfig',
}

M.config = function()
  local lspconfig = require('lspconfig')

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

  lspconfig.clangd.setup {}

  lspconfig.lua_ls.setup {
    -- on_attach = function(client, bufnr) client.server_capabilities.semanticTokensProvider = nil end,
    settings = {
      Lua = {
        workspace = { checkThirdParty = false },
        -- library = vim.api.nvim_get_runtime_file('', true),
        diagnostics = { globals = { 'vim' } },
        telemetry = { enable = false },
      },
    },
  }

  -- lspconfig.pyright.setup {
  --   settings = { python = { analysis = {
  --     autoSearchPaths = true,
  --     diagnosticMode = 'document',
  --     useLibraryCodeForTypes = true,
  --   } } }
  -- }

  -- lspconfig.pylsp.setup {
  --     settings = { pylsp = { plugins = {
  --         pycodestyle = { ignore = { 'E128', 'E701' }, maxLineLength = 100 },
  --         flake8 = { enabled = true, maxLineLength = 100, ignore = { 'E128', 'E701' } },
  --     } } }
  -- }
end

return M
