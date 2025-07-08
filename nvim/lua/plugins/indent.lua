---@module "lazy"
---@type LazyPluginSpec
return {
  'https://github.com/lukas-reineke/indent-blankline.nvim',
  config = function()
    require('ibl.hooks').register('WHITESPACE', function(_, _, _, tbl)
      if tbl[1] == 6 then tbl[1] = 5 end
      return tbl
    end)
    require('ibl').setup {
      whitespace = { remove_blankline_trail = true },
      scope = { enabled = false },
      exclude = {
        filetypes = { 'checkhealth', 'diff', 'help', 'man', '' },
      },
    }
  end,
}
