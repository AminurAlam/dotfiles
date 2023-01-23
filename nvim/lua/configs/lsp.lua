local status, lspconfig = pcall(require, 'lspconfig')
if not status then return end

require('lspconfig.ui.windows').default_options.border = 'rounded'
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- require('neodev').setup {
--     library = { enabled = true, runtime = true, types = true, plugins = false },
--     setup_jsonls = false
-- }

-- lspconfig.pylsp.setup {
--     capabilities = capabilities,
--     settings = { pylsp = { plugins = {
--         pycodestyle = { ignore = { 'E128', 'E701' }, maxLineLength = 100 },
--         flake8 = { enabled = true, maxLineLength = 100, ignore = { 'E128', 'E701' } },
--     } } }
-- }

lspconfig.pyright.setup {
    capabilities = capabilities,
    settings = {
        python = {
            analysis = {
                autoSearchPaths = true,
                diagnosticMode = 'document',
                useLibraryCodeForTypes = true,
            },
        },
    },
}

lspconfig.sumneko_lua.setup {
    capabilities = capabilities,
    on_attach = function(client, bufnr) client.server_capabilities.semanticTokensProvider = nil end,
    settings = {
        Lua = {
            workspace = {
                -- library = vim.api.nvim_get_runtime_file('', true),
                checkThirdParty = false,
            },
            diagnostics = { globals = { 'vim' } },
            telemetry = { enable = false },
        },
    },
}
