--[[ settings ]]
-- https://www.reddit.com/r/neovim/comments/u88dye/moving_from_initvim_to_initlua/
-- https://vonheikemen.github.io/devlog/tools/configuring-neovim-using-lua/
local set = vim.opt
set.number = true
set.hlsearch = false
set.autoindent = true
set.tabstop = 4
set.shiftwidth = 4
set.smarttab = true
set.softtabstop = 4
set.ignorecase = true
set.smartcase = true
set.scrolloff = 6
set.sidescroll = 10
set.sidescrolloff = 10
set.wrap = false
set.showbreak = ' …'
set.ea = true
set.incsearch = true
set.inccommand = 'split'
set.swapfile = false
set.termguicolors = true
set.clipboard:append('unnamedplus')
set.tgc = true
set.exrc = true
set.cmdheight = 0
set.cursorline = true
set.cursorlineopt = 'number'
set.laststatus = 3
set.fillchars = 'fold: ,eob: '
set.helpheight = 200
set.mouse = 'nvic'
set.numberwidth = 2
set.smartindent = true

--[[ variables ]]
local cmp = require('cmp')
local luasnip = require('luasnip')
local luadev = require("lua-dev").setup({
    lspconfig = {cmd = {"lua-language-server"}}
})
local kind_icons = {
    Text = '', Method = '', Function = '', Constructor = '',
    Field = '', Variable = '', Class = 'ﴯ', Interface = '',
    Module = '', Property = 'ﰠ', Unit = '', Value = '', Enum = '',
    Keyword = '', Snippet = '', Color = '', File = '',
    Reference = '', Folder = '', EnumMember = '', Constant = '',
    Struct = 'פּ', Event = '', Operator = '', TypeParameter = ''
}
local buffer_text = {
    buffer='[BUF]', nvim_lsp='[LSP]', nvim_lua='[LUA]',
    path='[PATH]', luasnip='[LSN]', vsnip='[VSN]', latex_symbols = '[LTX]'
}


--[[ reqires pt1 ]]
require('plugins')  -- lua/plugins
require('remaps')  -- lua/remaps
require('lspconfig').sumneko_lua.setup(luadev)

require('colorizer').setup({})
require('telescope').setup({})
require('todo-comments').setup({})
require('nvim-autopairs').setup({})
require('indent_blankline').setup({})
require('nvim-lsp-installer').setup({})
require('trouble').setup({position = 'top', height = 8})
require('indent_blankline').setup({show_current_context = true})
require('nvim-treesitter.configs').setup({
    highlight = {enable = true},
    indent = {enable = true},
})
require('bufferline').setup({
    options = {
        max_name_length = 16,
        tab_size = 12,
        diagnostics = false, -- separator_style = 'thin', indicator_icon = '',
    }
})
require('nvim-cursorline').setup({
    cursorline = {enable = false},
    cursorword = {
        enable = true,
        min_length = 3,
        hl = {underline = true},
    }
})
require('luasnip').config.set_config({
    history = true,
    update_events = 'TextChanged,TextChangedI',
    delete_check_events = 'TextChanged',
    ext_base_prio = 300,
    ext_prio_increase = 1,
    enable_autosnippets = true,
    store_selection_keys = '<Tab>',
})
--[[
require('hardline').setup({sections = {{class='mode', item=' '},
    {class='mode', item=require('hardline.parts.mode').get_item},
    {class='mode', item=' '}, {class='low', item=' '},
    {class='low', item=require('hardline.parts.git').get_item},
    {class='low', item=require('hardline.parts.filename').get_item},
    {class='low', item='%='}, {class='mode', item=' '},
    {class='mode', item=require('hardline.parts.lsp').get_error},
    {class='mode', item=require('hardline.parts.line').get_item},
    {class='mode', item='|'},
    {class='mode', item=require('hardline.parts.filetype').get_item},
    {class='mode', item=' '},
}}) --]]

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch'},
    lualine_c = {'filename'},
    lualine_x = {{'diagnostics', update_in_insert = true}},
    lualine_y = {'progress'},
    lualine_z = {'filetype'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
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

vim.diagnostic.config({
    underline = false,
    signs = false,
    virtual_text = { spacing = 1 },
    float = {
      show_header = true,
      source = true,
      focus = false,
      width = 60,  -- border = border,
    },
    update_in_insert = true,
    severity_sort = true,
})
-- vim.g.tokyonight_style = "night"
vim.g.tokyonight_italic_comments = false
vim.g.tokyonight_italic_functions = false
vim.g.tokyonight_italic_keywords = false
vim.g.tokyonight_sidebars = {"terminal", "packer", "Trouble"}
-- Change the "hint" color to the "orange" color, and make the "error" color bright red
vim.g.tokyonight_colors = {hint = "orange", error = "#ff0000"}

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
