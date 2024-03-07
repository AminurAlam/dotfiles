local M = {
  'neovim/nvim-lspconfig',
  enabled = false,
}

--[[ M.config = function()
  local lspconfig = require 'lspconfig'
  local nmap = function(lhs, rhs, desc) vim.keymap.set('n', lhs, rhs, { noremap = true, silent = true, desc = desc }) end

  require('lspconfig.ui.windows').default_options.border = 'rounded'

  local setup_lsp = function(name, bin, config)
    local bin = bin or name
    if vim.fn.executable(bin) == 0 then return end
    lspconfig[name].setup {
      settings = config or {},
    }
  end

  setup_lsp('clangd')

  setup_lsp('rust_analyzer', 'rust-analyzer', {
    ['rust_analyzer'] = {
      cargo = { buildScripts = { enable = false } },
      completion = { autoimport = { enable = false } },
      diagnostics = { warningsAsHints = {}, warningsAsInfo = {} },
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

  setup_lsp('lua_ls', 'lua-language-server', {
    Lua = {
      -- library = vim.api.nvim_get_runtime_file('', true),
      typeFormat = { config = { auto_complete_end = true } },
      completion = { callSnippet = 'Replace', displayContext = 5 },
      diagnostics = {
        globals = { 'vim', 'drastic', 'ratt' },
        -- disable = { 'lowercase-global' },
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

  nmap('<leader>li', '<cmd>LspInfo<cr>', 'LSP status')
  nmap('<leader>lf', vim.lsp.buf.format, 'format code using LSP')
  nmap('<leader>lr', vim.lsp.buf.rename, 'rename symbol under cursor')
  nmap('<leader>gd', vim.lsp.buf.definition, 'goto definition')
  nmap('<leader>ca', vim.lsp.buf.code_action, 'goto definition')
  nmap('[d', vim.diagnostic.goto_prev, 'goto prev diagnostic message')
  nmap(']d', vim.diagnostic.goto_next, 'goto next diagnostic message')
  nmap('<leader>d', vim.diagnostic.open_float, 'view line diagnostics')
  nmap('<leader>D', function() vim.diagnostic.open_float { scope = 'buffer' } end, 'view all diagnostics in a buffer')
end ]]

return M
