local function nmap(k, v)
	vim.keymap.set('n', k, v, {noremap = true})
end

local function imap(k, v)
	vim.keymap.set('i', k, v, {noremap = true})
end


vim.g.mapleader = ' '


-- telescope
nmap('<leader>ff', '<cmd>:Telescope find_files follow=true no_ignore=true hidden=true<cr>')
nmap('<leader>fg', '<cmd>:Telescope live_grep<cr>')
nmap('<leader>fb', '<cmd>:Telescope buffers<cr>')
nmap('<leader>fh', '<cmd>:Telescope help_tags<cr>')

-- packer
nmap('<leader>ps', '<cmd>:PackerSync<cr>')
nmap('<leader>pi', '<cmd>:PackerInstall<cr>')
nmap('<leader>pc', '<cmd>:PackerClean<cr>')
nmap('<leader>pl', '<cmd>:PackerLoad<cr>')

-- other plugins
nmap('<leader>hl', '<cmd>:TSToggle highlight<cr>')
nmap('<leader>tr', '<cmd>:TroubleToggle<cr>')
nmap('<leader>ex', '<cmd>:Explore<cr>')
nmap('<leader>ts', '<cmd>:NeoTreeShowToggle<cr>')
nmap('<leader>tf', '<cmd>:NeoTreeFloatToggle<cr>')
nmap('<leader>co', '<cmd>:ColorizerToggle<cr>')

-- write, quit
nmap('<C-q>', '<cmd>:q<cr>')
nmap('<C-w>', '<cmd>:w<cr>')
imap('<C-q>', '<cmd>:q<cr>')
imap('<C-w>', '<cmd>:w<cr>')

-- movement
nmap('<C-n>', '<cmd>:bn<cr>')
nmap('<C-p>', '<cmd>:bp<cr>')
imap('<C-n>', '<cmd>:bn<cr>')
imap('<C-p>', '<cmd>:bp<cr>')

nmap(';', ':')
