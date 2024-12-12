vim.o.guifont = 'SauceCodePro Nerd Font:h14'
vim.o.linespace = 0

if vim.g.neovide then
  vim.g.neovide_scale_factor = 1.0

  vim.keymap.set('n', '<C-+>', function()
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + (0.25 * vim.v.count1)
    vim.cmd.redraw { bang = true }
  end)
  vim.keymap.set('n', '<C-->', function()
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - (0.25 * vim.v.count1)
    vim.cmd.redraw { bang = true }
  end)
end
