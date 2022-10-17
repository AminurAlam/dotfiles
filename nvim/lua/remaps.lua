vim.g.mapleader = ' '
local tsb = require('telescope.builtin')
local options = { noremap = true, silent = true }

local function ni_map(k, v) vim.keymap.set({ 'n', 'i' }, k, v, options) end
local function n_map(k, v) vim.keymap.set('n', k, v, options) end
local function v_map(k, v) vim.keymap.set('v', k, v, options) end

-- telescope
n_map('<leader>ff', function() tsb.fd { hidden = true } end)
n_map('<leader>fg', function() tsb.live_grep() end)
n_map('<leader>fb', function() tsb.buffers() end)
n_map('<leader>fh', function() tsb.help_tags() end)

-- packer
n_map('<leader>pup', '<cmd>:PackerUpdate<cr>') -- update
n_map('<leader>pin', '<cmd>:PackerInstall<cr>') -- install
n_map('<leader>pun', '<cmd>:PackerClean<cr>') -- uninstall
n_map('<leader>pab', '<cmd>:PackerStatus<cr>') -- info

-- cybu / buffer movement
ni_map('<C-n>', '<cmd>:CybuNext<cr>')
ni_map('<C-p>', '<cmd>:CybuPrev<cr>')

-- ufo (ultra fold)
-- n_map('zr', require('ufo').openAllFolds)
-- n_map('zm', require('ufo').closeAllFolds)

-- other plugins
n_map('<leader>tr', '<cmd>:TroubleToggle<cr>')
n_map('<leader>tt', '<cmd>:ToggleTerm<cr>')
n_map('<leader>co', '<cmd>:ColorizerToggle<cr>')

-- write, quit
ni_map('<C-q>', '<cmd>:q<cr>')
ni_map('<C-w>', '<cmd>:w<cr>')

-- other
n_map(';', ':') -- typing correction
ni_map('<C-c>', '<esc>:') -- ^c takes you to command mode
v_map('<C-c>', ':') -- ^c takes you to command mode

n_map('x', '"_x') -- deleted stuff doesnt do to clipboard
n_map('X', '"_x') -- deleted stuff doesnt do to clipboard
n_map('<del>', '"_x') -- deleted stuff doesnt do to clipboard

-- n_map('<leader>dc', '<cmd>:%s/--.*//g<cr>')  -- removes lua comments
-- n_map('<leader>dl', '<cmd>:g/^\\s*$/d<cr>')  -- removes empty lines
-- n_map('<leader>dw', '<cmd>:%s/\\s*$//g<cr>') -- removes trailing whitespace

-- ni_map('<c-space>', '<cmd>:!cd %:p:h && pdflatex %:p <cr>')
