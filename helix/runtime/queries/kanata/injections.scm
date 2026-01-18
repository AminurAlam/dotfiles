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
  (string) @injection.content
  (#offset! @injection.content 0 1 0 -1)
)
