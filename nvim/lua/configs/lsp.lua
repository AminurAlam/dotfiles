--[[ variables ]]
local cmp = require('cmp')
local lspc = require('lspconfig')
local luasnip = require('luasnip')
local luadev = require('lua-dev').setup({lspconfig = {cmd = {'lua-language-server'}}})
local kind_icons = {
    Text = '', Method = '', Function = '', Constructor = '', Field = '',
    Variable = '', Class = 'ﴯ', Interface = '', Module = '', Property = 'ﰠ',
    Unit = '', Value = '', Enum = '', Keyword = '', Snippet = '',
    Color = '', File = '', Reference = '', Folder = '', EnumMember = '',
    Constant = '', Struct = 'פּ', Event = '', Operator = '', TypeParameter = ''
}
local buffer_text = {
    buffer='[BUF]', nvim_lsp='[LSP]', path='[PATH]',
    vsnip='[VSN]', luasnip='[LSN]', ultisnips='[USN]', snippy='[SNP]', snipmate='[SNM]'
}

--[[ language-server setups ]]
local servers = {
    -- pip
    'pyright',
    -- apt
    'rust_analyzer', 'texlab',
    -- npm (vscode-langservers-extracted)
    'jsonls', 'eslint', 'cssls', 'html',
    -- mason
    'bashls',
}
for _, lsp in pairs(servers) do
    require('lspconfig')[lsp].setup({
        capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
    })
end

lspc.sumneko_lua.setup(luadev)
require("luasnip.loaders.from_lua").lazy_load()
require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_snipmate").lazy_load()

--[[ cmp setup ]]
cmp.setup({
    formatting = {
        format = require('lspkind').cmp_format({
            mode = 'symbol',
            preset = 'codicons',
            maxwidth = 50,
            symbol_map = kind_icons,
            menu = buffer_text,
      })
    },
    snippet = {
        expand = function(args)
            -- vim.fn["vsnip#anonymous"](args.body) -- vsnip
            require('luasnip').lsp_expand(args.body) -- luasnip
            -- require('snippy').expand_snippet(args.body) -- snippy
            -- vim.fn["UltiSnips#Anon"](args.body) -- ultisnips
        end,
    },
    window = {},
    mapping = cmp.mapping.preset.insert({
        ['<C-Up>'] = cmp.mapping.scroll_docs(-4),
        ['<C-Down>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
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
        end, { "i", "s" }),
    }),
    sources = cmp.config.sources(
        {
            {name = 'path'},
            {name = 'nvim_lsp'}, -- main
            {name = 'vsnip'}, -- For vsnip users.
            {name = 'luasnip'}, -- For luasnip users.
            { name = 'ultisnips' }, -- For ultisnips users.
            { name = 'snippy' }, -- For snippy users.
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
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources(
        {{name = 'path' }},
        {{name = 'cmdline'}}
    ),
})
