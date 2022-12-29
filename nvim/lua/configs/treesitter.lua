local status, treesitter = pcall(require, 'nvim-treesitter.configs')
if not status then return end

treesitter.setup {
    -- ensure_installed = { 'fish', 'lua', 'python', 'vim' },
    ensure_installed = {},
    sync_install = false, -- Install parsers synchronously (only applied to `ensure_installed`)
    auto_install = false, -- Automatically install missing parsers when entering buffer
    ignore_install = {}, -- List of parsers to ignore installing (for "all")

    highlight = { enable = true },
    indent = { enable = false },
    incremental_selection = { enable = true },
    textobjects = { enable = true },
}
