-- local function reload_workspace(bufnr)
--   bufnr = util.validate_bufnr(bufnr)
--   vim.lsp.buf_request(bufnr, 'rust-analyzer/reloadWorkspace', nil, function(err)
--     if err then error(tostring(err)) end
--     vim.notify 'Cargo workspace reloaded'
--   end)
-- end
--
-- local function is_library(fname)
--   local cargo_home = os.getenv 'CARGO_HOME' or util.path.join(vim.env.HOME, '.cargo')
--   local registry = util.path.join(cargo_home, 'registry', 'src')
--
--   local rustup_home = os.getenv 'RUSTUP_HOME' or util.path.join(vim.env.HOME, '.rustup')
--   local toolchains = util.path.join(rustup_home, 'toolchains')
--
--   for _, item in ipairs { toolchains, registry } do
--     if fname:sub(1, #item) == item then
--       local clients = vim.lsp.get_active_clients { name = 'rust_analyzer' }
--       return clients[#clients].config.root_dir
--     end
--   end
-- end

if vim.fn.executable('rust-analyzer') == 1 then
  vim.lsp.start({
    cmd = { 'rust-analyzer' },
    filetypes = { 'rust' },
    -- root_dir = function(fname)
    --   local name = vim.fs.dirname(vim.fn.findfile('Cargo.toml', '.;'))
    --   print(name)
    --   return name
    -- end,
    -- capabilities = function()
    --   local capabilities = vim.lsp.protocol.make_client_capabilities()
    --   capabilities.experimental = { serverStatusNotification = true }
    --   return capabilities
    -- end,
  })
end
