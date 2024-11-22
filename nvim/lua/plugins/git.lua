return {
  { 'akinsho/git-conflict.nvim', config = true, enabled = false },
  { 'sindrets/diffview.nvim', cmd = 'DiffviewFileHistory', config = true }, -- TODO: learn features
  {
    'fredeeb/tardis.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
    keys = { { '<leader>gh', '<cmd>Tardis<cr>' } },
    config = true,
  },
  {
    'moyiz/git-dev.nvim',
    cmd = { 'GitDevOpen', 'GitDevToggleUI', 'GitDevRecents', 'GitDevCleanAll' },
    opts = {
      ephemeral = false, -- auto delete repo
      read_only = false,
      cd_type = 'global', -- global|tab|window|none
      opener = function(dir, repo_uri, selected_path)
        vim.print('Opening ' .. repo_uri)
        vim.cmd('edit ' .. vim.fn.fnameescape(selected_path and dir .. '/' .. selected_path or dir))
      end,
      repositories_dir = (vim.env.XDG_PROJECTS_DIR or vim.fn.expand('~/repos')),
      -- Extend the builtin URL parsers.
      -- Should map domains to parse functions. See |parser.lua|.
      extra_domain_to_parser = nil,
      git = {
        command = 'git',
        default_org = nil,
        base_uri_format = 'https://github.com/%s.git',
        clone_args = '--jobs=2 --single-branch --depth=1 --progress',
        fetch_args = '',
        checkout_args = '-f --recurse-submodules',
      },
      ui = {
        auto_close = true,
        close_after_ms = 3000,
        mode = 'floating',
        floating_win_config = {
          title = 'git-dev',
          title_pos = 'center',
          anchor = 'NE',
          style = 'minimal',
          border = 'rounded',
          relative = 'editor',
          width = 79,
          height = 9,
          row = 1,
          col = vim.o.columns,
          noautocmd = true,
        },
        split_win_config = {
          split = 'right',
          width = 79,
          noautocmd = true,
        },
      },
      history = {
        n = 32,
        path = vim.fn.stdpath('data') .. '/git-dev/history.json',
      },
      verbose = false,
    },
  },
  {
    'https://github.com/lewis6991/gitsigns.nvim', -- NOTE: https://github.com/lewis6991/gitsigns.nvim/issues/453
    opts = {
      signs = {
        add = { text = '┃' },
        change = { text = '┃' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
        untracked = { text = '┆' },
      },
      signs_staged_enable = true,
      signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
      numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
      linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
      word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
      watch_gitdir = { follow_files = true },
      auto_attach = true,
      attach_to_untracked = false,
      current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
        ignore_whitespace = false,
        virt_text_priority = 100,
      },
      current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
      sign_priority = 6,
      update_debounce = 100,
      max_file_length = 40000, -- Disable if file is longer than this (in lines)
      preview_config = {
        border = 'rounded',
        style = 'minimal',
        relative = 'cursor',
        row = 0,
        col = 1,
      },
      status_formatter = function(status)
        local added, changed, removed = status.added, status.changed, status.removed
        local statext = {}
        if added and added > 0 then table.insert(statext, '%#GitSignsAdd#+' .. added) end
        if changed and changed > 0 then table.insert(statext, '%#GitSignsChange#~' .. changed) end
        if removed and removed > 0 then table.insert(statext, '%#GitSignsDelete#-' .. removed) end
        return table.concat(statext, ' ') .. '%#Normal#'
      end,
    },
  },
}
