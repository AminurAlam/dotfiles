require("retrail").setup({
    hlgroup = 'Search',
    pattern = "\\v((.*%#)@!|%#)\\s+$",
    include = {},
    exclude = {
        '', 'alpha', 'checkhealth', 'diff',
        'help', 'lspinfo', 'man', 'mason.nvim',
        'mason', 'TelescopePrompt', 'Trouble',
        'WhichKey', 'toggleterm',
    },
    trim = {
        whitespace = true,
        blanklines = true,
    }
})
