local status, cmp = pcall(require, 'cmp')
if not status then return end

local status, luasnip = pcall(require, 'luasnip')
if not status then return end

local kind_icons = {
    Text = '',
    Method = '',
    Function = '',
    Constructor = '',
    Field = '',
    Variable = '',
    Class = 'ﴯ',
    Interface = '',
    Module = '',
    Property = 'ﰠ',
    Unit = '',
    Value = '',
    Enum = '',
    Keyword = '',
    Snippet = '',
    Color = '',
    File = '',
    Reference = '',
    Folder = '',
    EnumMember = '',
    Constant = '',
    Struct = 'פּ',
    Event = '',
    Operator = '',
    TypeParameter = '',
}
local buffer_text = {
    nvim_lsp = '[LSP]',
    nvim_lua = '[LUA]',
    path = '[PATH]',
    buffer = '[BUF]',
    dap = '[DAP]',
    vsnip = '[VSN]',
    luasnip = '[LSN]',
    ultisnips = '[USN]',
    snippy = '[SNP]',
    snipmate = '[SNM]',
    nvim_lsp_document_symbol = '[DOC]',
}

cmp.setup {
    view = { entries = 'custom' },
    experimental = { ghost_text = true },
    snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
    preselect = cmp.PreselectMode.None,
    window = { completion = cmp.config.window.bordered() },
    -- completion = { keyword_length = 3 },
    formatting = {
        format = function(entry, vim_item)
            vim_item.kind = kind_icons[vim_item.kind]
            vim_item.menu = (buffer_text)[entry.source.name]
            return vim_item
        end,
    },
    mapping = cmp.mapping.preset.insert {
        ['<C-Space>'] = cmp.mapping.abort(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm { select = true },
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    },
    sources = cmp.config.sources({
        { name = 'path' },
        { name = 'nvim_lsp' },
        { name = 'nvim_lua' },
        { name = 'luasnip' },
    }, { { name = 'buffer' } }),
}

cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources(
        { { name = 'nvim_lsp_document_symbol' } },
        { { name = 'buffer' } }
    ),
})

cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({ { name = 'path' } }, { { name = 'cmdline' } }),
})

require('luasnip.loaders.from_lua').lazy_load()
require('luasnip.loaders.from_vscode').lazy_load()
require('luasnip.loaders.from_snipmate').lazy_load()
