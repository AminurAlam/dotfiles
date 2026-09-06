(list
  (symbol) @_action
  (#eq? @_action "cmd")
  .
  (symbol) @injection.language
  (#any-of? @injection.language "bash" "fish" "zsh" "nu")
  .
  (symbol) @_flag
  (#eq? @_flag "-c")
  .
  (string (string_content) @injection.content)
)
