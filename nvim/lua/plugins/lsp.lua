return {
    'neovim/nvim-lspconfig',
    ft = { 'python', 'lua', 'c', 'cpp' },
    config = function()
        local lspconfig = require('lspconfig')

        require('lspconfig.ui.windows').default_options.border = 'rounded'

        lspconfig.lua_ls.setup {
            on_attach = function(client, bufnr) client.server_capabilities.semanticTokensProvider = nil end,
            settings = {
                Lua = {
                    workspace = { checkThirdParty = false }, -- + library = vim.api.nvim_get_runtime_file('', true),
                    diagnostics = { globals = { 'vim' } },
                    telemetry = { enable = false },
                },
            },
        }

        lspconfig.clangd.setup {}

        -- require('neodev').setup {
        --     library = { enabled = true, runtime = true, types = true, plugins = false },
        --     setup_jsonls = false
        -- }
        -- lspconfig.pylsp.setup {
        --     settings = { pylsp = { plugins = {
        --         pycodestyle = { ignore = { 'E128', 'E701' }, maxLineLength = 100 },
        --         flake8 = { enabled = true, maxLineLength = 100, ignore = { 'E128', 'E701' } },
        --     } } }
        -- }
        -- lspconfig.pyright.setup {
        --     settings = { python = { analysis = {
        --         autoSearchPaths = true, diagnosticMode = 'document', useLibraryCodeForTypes = true
        --     } } }
        -- }
    end,
}
