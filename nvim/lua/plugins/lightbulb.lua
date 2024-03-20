return {
  'kosayoda/nvim-lightbulb',
  enabled = false,
  config = {
    priority = 10,
    hide_in_unfocused_buffer = false,
    link_highlights = true,
    validate_config = 'auto',
    action_kinds = { 'quickfix', 'refactor', 'source' }, -- https://microsoft.github.io/language-server-protocol/specifications/lsp/3.17/specification/#codeActionKind
    virtual_text = { enabled = true, text = '' },
    sign = { enabled = false },
    float = { enabled = false },
    status_text = { enabled = false },
    number = { enabled = false },
    line = { enabled = false },
    autocmd = { enabled = true },
    ignore = { -- Scenarios to not show a lightbulb.
      clients = {},
      ft = {},
      actions_without_kind = false,
    },
  },
}
