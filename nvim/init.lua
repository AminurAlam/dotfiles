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
set.swapfile = false
set.termguicolors = true
set.clipboard:append('unnamedplus')
set.tgc = true
set.exrc = true
set.cmdheight = 0
set.cursorline = true
set.cursorlineopt = 'number'

--[[ local Plug = vim.fn['plug#']
vim.call('plug#begin', "~/.local/share/nvim/plugged/")
vim.call('plug#end') --]]
require('plugins')

local map = vim.keymap.set
vim.g.mapleader = ' '
map('n', '<Leader>ff', '<cmd>lua require(\'telescope.builtin\').find_files()<cr>', { noremap = true })
map('n', '<leader>tr', '<cmd>:TroubleToggle<cr>', { noremap = true })
map('n', '<C-q>', '<cmd>:q<cr>', { noremap = true })
map('n', '<C-w>', '<cmd>:w<cr>', { noremap = true })
map('i', '<C-q>', '<cmd>:q<cr>', { noremap = true })
map('i', '<C-w>', '<cmd>:w<cr>', { noremap = true })
map('n', '<C-n>', '<cmd>:bn<cr>', { noremap = true })
map('n', '<C-p>', '<cmd>:bp<cr>', { noremap = true })
map('i', '<C-n>', '<cmd>:bn<cr>', { noremap = true })
map('i', '<C-p>', '<cmd>:bp<cr>', { noremap = true })

vim.cmd [[
    syntax enable
    colorscheme nightfox
	set colorcolumn=80
	set guicursor=n-v-c-i-ci-ve-r-cr-o-a-sm:hor1,v:block
]]

vim.diagnostic.config({
	underline = false,
	signs = false,
	virtual_text = { spacing = 1 },
	float = {
	  show_header = true,
	  source = true,
	  border = border,
	  focus = false,
	  width = 60
    },
	update_in_insert = true,
	severity_sort = true,
})

-- require('telescope').setup({})
-- require('nvim-autopairs').setup({})
-- require('indent_blankline').setup({})
-- require("nvim-lsp-installer").setup({})
-- require('nightfox').init({dim_inactive = true})
-- require('trouble').setup({position = 'top', height = 8})
-- require('nightfox').setup({options = {comments = 'italic'}})
-- require('nvim-treesitter.configs').setup({highlight = {enable = true}})
-- require('indent_blankline').setup({show_current_context = true})
require('bufferline').setup({options = {
	tab_size = 12,
	diagnostics = false,
    text_align = 'left',
	separator_style = 'thin', -- indicator_icon = '',
}})
require('nvim-cursorline').setup({
	cursorline = {enable = false},
    cursorword = {
      enable = true,
      min_length = 3,
      hl = {underline = true},
    }
})
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
}})

local cmp = require('cmp')
local lspc = require('lspconfig')
local lspkind = require('lspkind')
local luasnip = require('luasnip')
local icon = require('nvim-web-devicons')
local capabilities = require('cmp_nvim_lsp').update_capabilities(
    vim.lsp.protocol.make_client_capabilities()
)

luasnip.config.set_config({
	history = true,
	update_events = "TextChanged,TextChangedI",
	delete_check_events = "TextChanged",
	ext_base_prio = 300,
	ext_prio_increase = 1,
	enable_autosnippets = true,
	store_selection_keys = "<Tab>",
})
cmp.setup({
    formatting = {
      format = lspkind.cmp_format({
		mode = "symbol",
		preset = "codicons",
		maxwidth = 30,
		symbol_map = {
          Text='', Method='', Function='', Constructor='', Field='ﰠ',
		  Variable='', Class='ﴯ', Interface='', Module='', Property='ﰠ',
		  Unit='塞', Value='', Enum='', Keyword='', Snippet='', Color='',
		  File='', Reference='', Folder='', EnumMember='', Constant='',
		  Struct='פּ', Event='', Operator='', TypeParameter='',
        },
		menu = {
		  buffer="BUF", nvim_lsp="LSP", nvim_lua="API", path="PAT", luasnip="LSN", vsnip="VSN",
		}})
	},
    snippet = {
      expand = function(args)
	    -- vim.fn["vsnip#anonymous"](args.body)
        require('luasnip').lsp_expand(args.body)
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
    sources = cmp.config.sources({
	  {name='path'},
      {name = 'nvim_lsp'},
	  {name = 'luasnip'},
      {name = 'vsnip'},
	  {name = 'nvim-snippy'},
	  {name='cmp-snippy'},
	}, {{ name = 'buffer' }
    })
})

cmp.setup.filetype('sh', cmp.config.sources({
	}, {{name='buffer'}
    })
)
cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
	  { name = 'nvim_lsp_document_symbol' }
	}, {{ name = 'buffer' } })
})
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
	  {name = 'path'},
	}, {{name = 'cmdline'} }),
})

local servers = {
	-- manual installation
	'pyright', 'rust_analyzer', 'cssmodules_ls', 'eslint',
	-- nvim-lsp-installer
	'bashls', 'jsonls',}-- 'sumneko_lua'}
for _, lsp in pairs(servers) do
	require('lspconfig')[lsp].setup({
      on_attach = on_attach,
      capabilities = capabilities,
	  flags = { debounce_text_changes = 150 }
    })
end
