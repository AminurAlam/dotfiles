-- TODO: update autocmd
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
