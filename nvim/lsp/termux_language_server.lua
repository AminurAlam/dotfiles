function search_ancestors(startpath, func)
  vim.validate('func', func, 'function')
  if func(startpath) then
    return startpath
  end
  local guard = 100
  for path in vim.fs.parents(startpath) do
    -- Prevent infinite recursion if our algorithm breaks
    guard = guard - 1
    if guard == 0 then
      return
    end

    if func(path) then
      return path
    end
  end
end

local function escape_wildcards(path)
  return path:gsub('([%[%]%?%*])', '\\%1')
end

function root_pattern(...)
  local patterns = ...
  return function(startpath)
    for _, pattern in ipairs(patterns) do
      local match = search_ancestors(startpath, function(path)
        for _, p in
          ipairs(vim.fn.glob(table.concat({ escape_wildcards(path), pattern }, '/'), true, true))
        do
          if vim.uv.fs_stat(p) then
            return path
          end
        end
      end)

      if match ~= nil then
        local real = vim.uv.fs_realpath(match)
        return real or match -- fallback to original if realpath fails
      end
    end
  end
end

---@type vim.lsp.Config
return {
  cmd = { 'termux-language-server' },
  -- root_dir = function(bufnr, on_dir)
  --   local patterns = {
  --     -- Termux
  --     'build.sh',
  --     '*.subpackage.sh',
  --     -- Arch/MSYS2
  --     'PKGBUILD',
  --     'makepkg.conf',
  --     '*.install',
  --     -- Gentoo
  --     'make.conf',
  --     'color.map',
  --     '*.ebuild',
  --     '*.eclass',
  --   }
  --   local fname = vim.api.nvim_buf_get_name(bufnr)
  --   local match = root_pattern(patterns)(fname)
  --   if match then
  --     on_dir(vim.fs.root(match, '.git') or match)
  --   end
  -- end,
  root_markers = { '.git' },
}
