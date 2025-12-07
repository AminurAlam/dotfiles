---@type vim.lsp.Config
return {
  cmd = { 'tinymist' },
  filetypes = { 'typst' },
  root_markers = { '.git' },
  settings = { formatterMode = 'typstyle' },
  on_attach = function(client, bufnr)
    for _, command in ipairs {
      -- 'tinymist.exportSvg',
      'tinymist.exportPng',
      'tinymist.exportPdf',
      'tinymist.exportHtml', -- Use typst 0.13
      'tinymist.exportMarkdown',
      -- 'tinymist.exportText',
      -- 'tinymist.exportQuery',
      -- 'tinymist.getServerInfo',
      -- 'tinymist.getDocumentTrace',
      -- 'tinymist.getWorkspaceLabels',
      -- 'tinymist.getDocumentMetrics',
    } do
      vim.api.nvim_buf_create_user_command(
        bufnr,
        'Typst' .. command:match 'tinymist%.export(%w+)',
        function()
          client:exec_cmd({
            title = command,
            command = command,
            arguments = { vim.api.nvim_buf_get_name(bufnr) },
          }, { bufnr = bufnr }, function(err, res)
            if err then
              return vim.notify(err.code .. ': ' .. err.message, vim.log.levels.ERROR)
            end
            -- vim.notify(res, vim.log.levels.INFO)
            if command == 'tinymist.exportPdf' then
              vim.cmd('silent !xdg-open %:r.pdf &')
            end
          end)
        end,
        { nargs = 0, desc = command }
      )
    end
  end,
}
