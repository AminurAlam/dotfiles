local M = { 'neovim/nvim-lspconfig', ft = { 'python', 'lua', 'rust', 'json', 'javascript' } }

function M.config()
    local lspconfig = require('lspconfig')

    require('lspconfig.ui.windows').default_options.border = 'rounded'

    -- require('neodev').setup {
    --     library = { enabled = true, runtime = true, types = true, plugins = false },
    --     setup_jsonls = false
    -- }

    -- lspconfig.rust_analyzer.setup {}

    lspconfig.pylsp.setup {
        settings = {
            pylsp = {
                plugins = {
                    pycodestyle = { ignore = { 'E128', 'E701' }, maxLineLength = 100 },
                    flake8 = { enabled = true, maxLineLength = 100, ignore = { 'E128', 'E701' } },
                },
            },
        },
    }

    lspconfig.pyright.setup {
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
        settings = {
            Lua = {
                workspace = {
                    library = vim.api.nvim_get_runtime_file('', true),
                    checkThirdParty = false,
                },
                diagnostics = { globals = { 'vim' } },
                telemetry = { enable = false },
            },
        },
    }
end

return M
