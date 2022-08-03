
--[[ variables ]]
local cmp = require('cmp')
local luasnip = require('luasnip')
local luadev = require("lua-dev").setup({
    lspconfig = {cmd = {"lua-language-server"}}
})
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



--[[ setups ]]
require('lspconfig').sumneko_lua.setup(luadev)
require('mason').setup({})
require('Comment').setup({})
require('colorizer').setup({})
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
require('telescope').setup({
	defaults = {
		prompt_prefix = "  ",
		file_ignore_patterns = { "node_modules" },
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

require('lualine').setup {
  options = {
    icons_enabled = true,
	theme = 'onedark',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
       statusline = {},
       winbar = {},
    },
    always_divide_middle = true,
    globalstatus = true,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {{'mode', padding = 1}},
    lualine_b = {{'branch'}},
    lualine_c = {{'filename'}},
    lualine_x = {{'diagnostics', update_in_insert = true}},
    lualine_y = {{'progress'}},
    lualine_z = {{'filetype', padding = 1}}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
}





