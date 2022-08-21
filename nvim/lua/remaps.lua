local function nmap(k, v)
        vim.keymap.set('n', k, v, {noremap = true})
end
local function imap(k, v)
        vim.keymap.set('i', k, v, {noremap = true})
end
local function vmap(k, v)
        vim.keymap.set('v', k, v, {noremap = true})
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
-- other plugins
nmap('<leader>tr', '<cmd>:TroubleToggle<cr>')
nmap('<leader>tt', '<cmd>:ToggleTerm<cr>')
nmap('<leader>co', '<cmd>:ColorizerToggle<cr>')
-- write, quit
nmap('<C-q>', '<cmd>:q<cr>')
nmap('<C-w>', '<cmd>:w<cr>')
imap('<C-q>', '<cmd>:q<cr>')
imap('<C-w>', '<cmd>:w<cr>')
-- buffer movement
nmap('<C-n>', '<cmd>:bn<cr>')
nmap('<C-p>', '<cmd>:bp<cr>')
imap('<C-n>', '<cmd>:bn<cr>')
imap('<C-p>', '<cmd>:bp<cr>')
-- shortcuts
nmap(';', ':')           -- typing correction
nmap('<C-c>', '<esc>:')  -- ^c takes you to command mode
imap('<C-c>', '<esc>:')  -- ^c takes you to command mode
vmap('<C-c>', ':')       -- ^c takes you to command mode
