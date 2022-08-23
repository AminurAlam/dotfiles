--[[ variables ]]
local cmp = require('cmp')
local lspc = require('lspconfig')
local lspkind = require('lspkind')
local luasnip = require('luasnip')
local luadev = require('lua-dev').setup({
    lspconfig = {cmd = {'lua-language-server'}}
})
local kind_icons = {
    Text = '', Method = '', Function = '', Constructor = '', Field = '',
    Variable = '', Class = 'ﴯ', Interface = '', Module = '', Property = 'ﰠ',
    Unit = '', Value = '', Enum = '', Keyword = '', Snippet = '',
    Color = '', File = '', Reference = '', Folder = '', EnumMember = '',
    Constant = '', Struct = 'פּ', Event = '', Operator = '', TypeParameter = ''
}
local buffer_text = {
    nvim_lsp='[LSP]', nvim_lua='[LUA]',
    path='[PATH]', buffer='[BUF]', dap = '[DAP]',
    vsnip='[VSN]', luasnip='[LSN]', ultisnips='[USN]', snippy='[SNP]', snipmate='[SNM]',
}

--[[ language-server setups ]]
local servers = {
    -- pip
    'pyright',
    -- apt
    'rust_analyzer',
    -- npm (vscode-langservers-extracted)
    'jsonls', 'eslint', 'cssls', 'html',
    -- mason
    'bashls',
}

--[[ cmp setup ]]
cmp.setup({
    view = {
        entries = 'custom',
    },
    formatting = {
        format = lspkind.cmp_format({
            mode = 'symbol',
            preset = 'codicons',
            maxwidth = 22,
            symbol_map = kind_icons,
            menu = buffer_text,
        })
    },
    snippet = {
        expand = function(args)
            -- vim.fn["vsnip#anonymous"](args.body) -- vsnip
            require('luasnip').lsp_expand(args.body) -- luasnip
        end,
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    experimental = {
        ghost_text = true
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-Up>'] = cmp.mapping.scroll_docs(-4),
        ['<C-Down>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<C-CR>'] = cmp.mapping.abort(),
        ['<C-Enter>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),
    }),
    sources = cmp.config.sources(
        {
            {name = 'path'},
            {name = 'nvim_lsp'},
            {name = 'nvim_lua'},
            {name = 'dap'},
            {name = 'vsnip'}, -- For vsnip users.
            {name = 'luasnip'}, -- For luasnip users.
            -- {name = 'ultisnips'}, -- For ultisnips users.
            -- {name = 'snippy'}, -- For snippy users.
        },
        {{name = 'buffer'}}
    )
})

cmp.setup.filetype('c',
    cmp.config.sources({}, {{name='buffer'}})
)
cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources(
        {{name = 'nvim_lsp_document_symbol'}},
        {{name = 'buffer'}}
    )
})
cmp.setup.cmdline(':', {
    view = {
        -- entries = {name = 'wildmenu', separator = '|' }
    },
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources(
        {{name = 'path' }},
        {{name = 'cmdline'}}
    ),
})

for _, lsp in pairs(servers) do
    require('lspconfig')[lsp].setup({
        autostart = true,
        capabilities = require('cmp_nvim_lsp').update_capabilities(
            vim.lsp.protocol.make_client_capabilities()
        )
    })
end

lspc.sumneko_lua.setup(luadev)
require("luasnip.loaders.from_lua").lazy_load()
require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_snipmate").lazy_load()
