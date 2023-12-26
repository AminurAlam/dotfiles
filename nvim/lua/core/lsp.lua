---@param cmd table[string]
---@param filetypes table[string]
---@param root_dir table[string]
---@param settings table|nil
local function create(cmd, filetypes, root_dir, settings)
  vim.api.nvim_create_autocmd('Filetype', {
    pattern = filetypes,
    once = true,
    callback = function()
      if vim.fn.executable(cmd[1]) == 1 then
        vim.lsp.start {
          cmd = cmd,
          filetypes = filetypes,
          single_file_support = true,
          root_dir = vim.fs.dirname(vim.fs.find(root_dir, { upwards = true })[1]),
          settings = settings,
        }
      end
    end,
  })
end

create({ 'clangd' }, { 'c', 'cpp', 'objc', 'objcpp', 'cuda', 'proto' }, {
  '.git',
  '.clangd',
  '.clang-tidy',
  '.clang-format',
  'compile_commands.json',
  'compile_flags.txt',
  'configure.ac',
})

create({ 'rust-analyzer' }, { 'rust' }, { 'Cargo.toml', 'rust-project.json' }, {
  ['rust-analyzer'] = { linkedProjects = nil },
})

create({ 'gopls' }, { 'go' }, { 'go.work', 'go.mod', '.git' })

create({ 'dart', 'language-server', '--protocol=lsp' }, { 'dart' }, { 'pubspec.yaml' }, {
  dart = {
    completeFunctionCalls = true,
    showTodos = true,
  },
})

create({ 'luau-lsp', 'lsp' }, { 'luau' }, {})

-- TODO: make :LspInfo copy
-- local lsp_info = function()
--   vim.float
-- end
