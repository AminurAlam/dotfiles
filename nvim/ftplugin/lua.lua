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
    -- root_dir = function(fname)
    --   local root = util.root_pattern(unpack(root_files))(fname)
    --   if root and root ~= vim.env.HOME then
    --     return root
    --   end
    --   root = util.root_pattern 'lua/'(fname)
    --   if root then
    --     return root .. '/lua/'
    --   end
    --   return util.find_git_ancestor(fname)
    -- end,
    single_file_support = true,
    log_level = vim.lsp.protocol.MessageType.Warning,
    settings = {

      Lua = {
        -- library = vim.api.nvim_get_runtime_file('', true),
        typeFormat = { config = { auto_complete_end = true } },
        completion = { callSnippet = 'Replace', displayContext = 5 },
        diagnostics = {
          globals = { 'vim', 'drastic', 'ratt' },
          -- disable = { 'lowercase-global' },
          libraryFiles = 'Disable',
        },
        format = {
          enable = false, -- using stylua instead
          defaultConfig = {
            indent_style = 'space',
            indent_size = '2',
          },
        },
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
