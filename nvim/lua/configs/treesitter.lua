local status, treesitter = pcall(require, 'nvim-treesitter.configs')
if not status then return end

treesitter.setup {
    highlight = { enable = true },
    incremental_selection = { enable = true },
    textobjects = { enable = true },
}
