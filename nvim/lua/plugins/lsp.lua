local M = {
  'https://github.com/neovim/nvim-lspconfig',
  enabled = vim.version().minor < 11,
}

M.init = function()
  vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    callback = function(event)
      local nmap = function(lhs, rhs) vim.keymap.set('n', lhs, rhs) end
      local client = vim.lsp.get_client_by_id(vim.tbl_get(event, 'data', 'client_id'))

      nmap('<leader>lf', vim.lsp.buf.format)
      nmap('grd', vim.lsp.buf.definition)
      nmap('<leader>li', '<cmd>silent LspInfo<cr>')
      nmap('K', function() vim.lsp.buf.hover { border = 'rounded' } end)

      if client == nil then return end
      -- if client.supports_method('textDocument/hover') then
      --   nmap('K', function() vim.lsp.buf.hover { border = 'rounded' } end)
      -- end
      -- if client.supports_method('textDocument/inlayHint') then
      --   vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })
      -- end
    end,
  })

  vim.api.nvim_create_user_command(
    'Tex',
    function(info)
      vim.cmd(':silent !latexmk -pdf -interaction=nonstopmode -synctex=1 % ; open %:r.pdf')
    end,
    { desc = 'Builds your tex file', bang = true }
  )
end

M.config = function()
  local lspconfig = require 'lspconfig'
  local servers = {
    'bashls',
    'clangd',
    'gopls',
    'kotlin_language_server',
    'taplo',
    java_language_server = { cmd = { 'java-language-server' } },
    rust_analyzer = { settings = { ['rust-analyzer'] = { linkedProjects = nil } } },
    ruff = {
      settings = {
        init_options = {
          settings = { configuration = vim.fn.expand '~}/repos/dotfiles/other/ruff.toml' },
        },
      },
    },
    basedpyright = {
      settings = {
        python = {
          analysis = {
            diagnosticMode = 'document',
            autoSearchPaths = true,
            useLibraryCodeForTypes = true,
          },
        },
      },
    },
    lua_ls = {
      settings = {
        Lua = {
          typeFormat = { config = { auto_complete_end = true } },
          completion = { callSnippet = 'Replace', displayContext = 5 },
          diagnostics = {
            globals = { 'vim', 'drastic', 'ya', 'Command', 'cx', 'mp' },
            libraryFiles = 'Disable',
            disable = { 'lowercase-global' },
          },
          format = { enable = false },
          hint = { enable = true },
          runtime = { version = 'LuaJIT' },
          semantic = { enable = false },
          telemetry = { enable = false },
          window = { progressBar = false },
          workspace = { checkThirdParty = false, library = { vim.env.VIMRUNTIME } },
        },
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
      lspconfig[key].setup(value)
    end
  end
end

return M
