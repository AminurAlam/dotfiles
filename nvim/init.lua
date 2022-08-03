--[[ reqires pt1 ]]
require('plugins')  -- lua/plugins.lua
require('remaps')  -- lua/remaps.lua
require('settings') -- lua/settings.lua
require('setups') --lua/setups.lua


--[[ variables ]]
local cmp = require('cmp')
local luasnip = require('luasnip')
local kind_icons = {
    Text = '', Method = '', Function = '', Constructor = '', Field = '',
	Variable = '', Class = 'ﴯ', Interface = '', Module = '', Property = 'ﰠ',
	Unit = '', Value = '', Enum = '', Keyword = '', Snippet = '',
	Color = '', File = '', Reference = '', Folder = '', EnumMember = '',
	Constant = '', Struct = 'פּ', Event = '', Operator = '', TypeParameter = ''
}
local buffer_text = {
    buffer='[BUF]', nvim_lsp='[LSP]', nvim_lua='[LUA]', path='[PATH]',
	luasnip='[LSN]', vsnip='[VSN]', latex_symbols = '[LTX]'
}



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
            -- vim.fn["vsnip#anonymous"](args.body)
            luasnip.lsp_expand(args.body)
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
            {name = 'nvim_lsp'},
            {name = 'luasnip'},
            {name = 'vsnip'},
            {name = 'nvim-snippy'},
            {name = 'cmp-snippy'},
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


--[[ language-servers ]]
local servers = {
    'pyright', 'rust_analyzer', 'cssmodules_ls',
	-- vscode-langservers-extracted
    'jsonls', 'eslint', 'cssls', 'html'}
for _, lsp in pairs(servers) do
    require('lspconfig')[lsp].setup({
        capabilities = require('cmp_nvim_lsp').update_capabilities(
            vim.lsp.protocol.make_client_capabilities()

        ),
        flags = { debounce_text_changes = 150 }
    })
end



vim.cmd [[
    set colorcolumn=80
    set guicursor=n-v-c-i-ci-ve-r-cr-o-a-sm:hor1,v:block

    " gray
    highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080
    " blue
    highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6
    highlight! CmpItemAbbrMatchFuzzy guibg=NONE guifg=#569CD6
    " light blue
    highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE
    highlight! CmpItemKindInterface guibg=NONE guifg=#9CDCFE
    highlight! CmpItemKindText guibg=NONE guifg=#9CDCFE
    " pink
    highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0
    highlight! CmpItemKindMethod guibg=NONE guifg=#C586C0
    " front
    highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4
    highlight! CmpItemKindProperty guibg=NONE guifg=#D4D4D4
    highlight! CmpItemKindUnit guibg=NONE guifg=#D4D4D4

	colorscheme tokyonight
]]
