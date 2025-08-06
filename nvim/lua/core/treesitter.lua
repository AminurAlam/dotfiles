-- require('treesitter-context').setup({
--   enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
--   multiwindow = false, -- Enable multiwindow support.
--   max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
--   min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
--   line_numbers = true,
--   multiline_threshold = 20, -- Maximum number of lines to show for a single context
--   trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
--   mode = 'cursor', -- Line used to calculate context. Choices: 'cursor', 'topline'
--   -- Separator between context and content. Should be a single character string, like '-'.
--   -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
--   separator = nil,
--   zindex = 20, -- The Z-index of the context window
--   on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
-- })

local tsft = {}

for f in vim.fs.dir(vim.fn.stdpath('data') .. '/site/parser') do
  for _, ft in ipairs(vim.treesitter.language.get_filetypes(vim.fn.fnamemodify(f, ':r'))) do
    table.insert(tsft, ft)
  end
end

vim.api.nvim_create_autocmd('FileType', {
  desc = 'automatically start treesitter',
  pattern = tsft,
  callback = function(details)
    if #tsft == 0 then return end
    vim.treesitter.start()
    vim.bo[details.buf].syntax = 'on'
    vim.wo.foldmethod = 'expr'
    vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
  end,
})
