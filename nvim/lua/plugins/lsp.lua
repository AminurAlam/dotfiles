local M = {
  'neovim/nvim-lspconfig',
  ft = { 'c', 'cpp', 'rust', 'python', 'lua' },
}

M.config = function()
  local lspconfig = require 'lspconfig'

  require('lspconfig.ui.windows').default_options.border = 'rounded'

  local setup_lsp = function(name, bin, config)
    local bin = bin or name
    if vim.fn.executable(bin) == 0 then return end
    lspconfig[name].setup {
      settings = config or {},
    }
  end

  setup_lsp('clangd')

  setup_lsp('rust_analyzer', 'rust-analyzer')

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

  setup_lsp('lua_ls', 'lua-language-server', {
    Lua = {
      -- library = vim.api.nvim_get_runtime_file('', true),
      typeFormat = { config = { auto_complete_end = true } },
      completion = { callSnippet = 'Replace', displayContext = 5 },
      diagnostics = {
        globals = { 'vim' },
        disable = { 'lowercase-global' },
        libraryFiles = 'Disable',
      },
      format = {
        enable = false, -- using stylua instead
        defaultConfig = {
          indent_style = 'space',
          indent_size = '2',
        },
      },
      hint = { enable = true },
      runtime = { version = 'LuaJIT' },
      semantic = { enable = false },
      telemetry = { enable = false },
      window = { progressBar = false },
      workspace = { checkThirdParty = false },
    },
  })
end

return M
