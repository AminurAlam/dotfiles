local options = {noremap = true, silent = true}

local function nimap(k, v)
    vim.keymap.set({'n', 'i'}, k, v, options)
end
local function nmap(k, v)
        vim.keymap.set('n', k, v, options)
end
local function imap(k, v)
        vim.keymap.set('i', k, v, options)
end
local function vmap(k, v)
        vim.keymap.set('v', k, v, options)
end

vim.g.mapleader = ' '

-- telescope
nmap('<leader>ff', '<cmd>:Telescope find_files follow=true no_ignore=true hidden=true<cr>')
nmap('<leader>fg', '<cmd>:Telescope live_grep<cr>')
nmap('<leader>fb', '<cmd>:Telescope buffers<cr>')
nmap('<leader>fh', '<cmd>:Telescope help_tags<cr>')
-- packer
nmap('<leader>pup', '<cmd>:PackerSync<cr>')     -- update
nmap('<leader>pin', '<cmd>:PackerInstall<cr>')  -- install
nmap('<leader>pun', '<cmd>:PackerClean<cr>')    -- uninstall
nmap('<leader>pab', '<cmd>:PackerStatus<cr>')   -- info
-- zen
nmap('<leader>zn', '<cmd>:TZNarrow<cr>')
nmap('<leader>zf', '<cmd>:TZFocus<cr>')
nmap('<leader>zm', '<cmd>:TZMinimalist<cr>')
nmap('<leader>za', '<cmd>:TZAtaraxis<cr>')
-- cybu / buffer movement
nimap('<C-n>', '<cmd>:CybuNext<cr>')
nimap('<C-p>', '<cmd>:CybuPrev<cr>')
-- other plugins
nmap('<leader>tr', '<cmd>:TroubleToggle<cr>')
nmap('<leader>tt', '<cmd>:ToggleTerm<cr>')
nmap('<leader>co', '<cmd>:ColorizerToggle<cr>')
-- write, quit
nimap('<C-q>', '<cmd>:q<cr>')
nimap('<C-w>', '<cmd>:w<cr>')
-- other
nmap(';', ':')          -- typing correction
nimap('<C-c>', '<esc>:')  -- ^c takes you to command mode
vmap('<C-c>', ':')      -- ^c takes you to command mode
nmap('x', '"_x')
nmap('X', '"_x')
nmap('<del>', '"_x')
