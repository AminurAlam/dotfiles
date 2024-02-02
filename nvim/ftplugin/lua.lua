vim.opt_local.tabstop = 2
vim.opt_local.shiftwidth = 2
vim.opt_local.softtabstop = 2
-- vim.opt_local.fo0dmethod = 'expr'
vim.opt_local.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.opt_local.listchars = {
  leadmultispace = '│ ',
  -- precedes = '│'
}

if vim.fn.executable('lua-language-server') == 1 then
  vim.lsp.start({
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    root_dir = vim.fs.dirname(vim.fs.find({ 'lua', 'init.lua' }, { upwards = true })[1]),
    single_file_support = true,
    log_level = vim.lsp.protocol.MessageType.Warning,
    settings = {
      Lua = {
        -- library = vim.api.nvim_get_runtime_file('', true),
        typeFormat = { config = { auto_complete_end = true } },
        completion = { callSnippet = 'Replace', displayContext = 5 },
        diagnostics = {
          globals = { 'vim', 'drastic' },
          libraryFiles = 'Disable',
          -- disable = { 'lowercase-global' },
        },
        format = { enable = false }, -- using stylua instead
        hint = { enable = true },
        runtime = { version = 'LuaJIT' },
        semantic = { enable = false },
        telemetry = { enable = false },
        window = { progressBar = false },
        workspace = { checkThirdParty = false },
      },
    },
  })
end
