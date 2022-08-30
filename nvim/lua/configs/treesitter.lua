require('nvim-treesitter.configs').setup {
    ensure_installed = {
        'bash',
        'fish',
        'jsonc',
        'lua',
        'markdown',
        'python',
        'rust',
        'vim',
    },

    sync_install = false, -- Install parsers synchronously (only applied to `ensure_installed`)
    auto_install = false, -- Automatically install missing parsers when entering buffer
    ignore_install = {}, -- List of parsers to ignore installing (for "all")

    highlight = { enable = true },
    indent = { enable = false },
    incremental_selection = { enable = true },
    textobjects = { enable = true },
    rainbow = { enable = true },
}
