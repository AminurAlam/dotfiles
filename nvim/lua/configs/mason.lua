require('mason').setup({
    ui = {
        check_outdated_packages_on_open = true,
        border = "rounded",
        icons = {
            package_installed = "✓",
            package_pending = "↓",
            package_uninstalled = "✗",
        },
        keymaps = {
            toggle_package_expand = "<CR>",
            install_package = "i",
            update_package = "u",
            check_package_version = "v",
            update_all_packages = "U",
            check_outdated_packages = "C",
            uninstall_package = "X",
            cancel_installation = "<C-c>",
            apply_language_filter = "<C-f>",
        },
    },

    -- The directory in which to install packages.
    -- install_root_dir = path.concat { vim.fn.stdpath "data", "mason" },

    pip = {
        install_args = {},  -- Example: { "--proxy", "https://proxyserver" }
    },
    log_level = vim.log.levels.INFO,
    max_concurrent_installers = 4,
    github = {
        download_url_template = "https://github.com/%s/releases/download/%s/%s",
    },
})
