vim.g.mapleader = ' '
local opts = { noremap = true, silent = true }

local function nmap(k, v) vim.keymap.set('n', k, v, opts) end
local function vmap(k, v) vim.keymap.set('v', k, v, opts) end
local function umap(k, v) vim.keymap.set({ '', 'i' }, k, v, opts) end

-- telescope
nmap('<leader>ff', require('telescope.builtin').fd)
nmap('<leader>fg', function() require('telescope.builtin').live_grep() end)
nmap('<leader>fb', function() require('telescope.builtin').buffers() end)
nmap('<leader>fh', function() require('telescope.builtin').help_tags() end)

-- packer
nmap('<leader>pup', '<cmd>:PackerUpdate<cr>')
nmap('<leader>pin', '<cmd>:PackerInstall<cr>')
nmap('<leader>pun', '<cmd>:PackerClean<cr>')
nmap('<leader>pab', '<cmd>:PackerStatus<cr>')

-- cybu / buffer movement
umap('<C-n>', '<cmd>:CybuNext<cr>')
umap('<C-p>', '<cmd>:CybuPrev<cr>')

-- ufo
nmap('zu', require('ufo').openAllFolds)
nmap('zf', require('ufo').closeAllFolds)

-- other plugins
nmap('<leader>tr', '<cmd>:TroubleToggle document_diagnostics<cr>')
nmap('<leader>tt', '<cmd>:ToggleTerm<cr>')
nmap('<leader>co', '<cmd>:ColorizerToggle<cr>')
nmap('<leader>ib', '<cmd>:IndentBlanklineToggle<cr>')
nmap('<leader>mm', function() require('codewindow').toggle_minimap() end)
nmap('<leader>mf', function() require('codewindow').toggle_focus() end)

-- other
nmap('Q', '<cmd>:bdelete<cr>')
umap('<C-q>', '<cmd>:q<cr>')
umap('<C-w>', '<cmd>:w<cr>')

nmap(';', ':') -- typing correction
umap('<C-c>', '<esc>:') -- ^c takes you to command mode
vmap('<C-c>', ':') -- ^c takes you to command mode

nmap('x', '"_x') -- deleted stuff doesnt go to clipboard
nmap('X', '"_x') -- deleted stuff doesnt go to clipboard
nmap('<del>', '"_x') -- deleted stuff doesnt go to clipboard

nmap('<leader>li', '<cmd>:LspInfo<cr>')
nmap('<leader>/', '<cmd>:nohlsearch<cr>') -- remove highlight after search
nmap('<leader>d ', '<cmd>:%s/\\s*$//g<cr><cmd>:nohlsearch<cr>') -- removes trailing whitespace

--[[ require('which-key').setup {
    plugins = {
        marks = true, -- shows a list of your marks on ' and `
        registers = false, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        spelling = {
            enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
            suggestions = 20, -- how many suggestions should be shown in the list?
        },
        presets = {
            operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
            motions = false, -- adds help for motions
            text_objects = true, -- help for text objects triggered after entering an operator
            windows = false, -- default bindings on <c-w>
            nav = true, -- misc bindings to work with windows
            z = true, -- bindings for folds, spelling and others prefixed with z
            g = true, -- bindings for prefixed with g
        },
    },
    operators = { gc = 'Comments' },
    key_labels = {
        ['<leader>'] = '< >',
        ['<space>'] = 'SPC',
        ['<tab>'] = 'TAB',
        ['<ScrollWheelUp>'] = 'up',
        ['<ScrollWheelDown>'] = 'down',
    },
    icons = {
        breadcrumb = '»', -- symbol used in the command line area that shows your active key combo
        separator = '➜', -- symbol used between a key and it's label
        group = '+', -- symbol prepended to a group
    },
    popup_mappings = {
        scroll_down = '<c-d>', -- binding to scroll down inside the popup
        scroll_up = '<c-u>', -- binding to scroll up inside the popup
    },
    window = {
        border = 'rounded', -- none, single, double, shadow
        position = 'bottom', -- bottom, top
        margin = { 0, 0, 0, 0 }, -- extra window margin [top, right, bottom, left]
        padding = { 0, 0, 0, 0 }, -- extra window padding [top, right, bottom, left]
        winblend = 10,
    },
    layout = {
        height = { min = 1, max = 18 }, -- min and max height of the columns
        width = { min = 5, max = 34 }, -- min and max width of the columns
        spacing = 2, -- spacing between columns
        align = 'left', -- align columns left, center or right
    },
    ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
    hidden = { '<silent>', '<cmd>', '<Cmd>', '<CR>', 'call', 'lua', '^:', '^ ' }, -- hide mapping boilerplate
    show_help = true, -- show help message on the command line when the popup is visible
    triggers = 'auto', -- automatically setup triggers
    -- triggers = {"<leader>"} -- or specify a list manually
    triggers_blacklist = {
        i = { 'j', 'k' },
        v = { 'j', 'k' },
    },
    disable = {
        buftypes = {},
        filetypes = { 'TelescopePrompt' },
    },
} ]]
