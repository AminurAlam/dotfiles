;; extends

((variable_name) @variable.builtin
  (#any-of? @variable.builtin "PREFIX" "HOME" "PATH" "PWD" "SHELL" "TERM" "USER"))

(command
  name: (word) @_command (#eq? @_command "set")
  argument: (word)* @_flag
    (#match? @_flag "^-")
  argument: (word) @variable.member
    (#not-match? @variable.member "^-"))


; spellcheck strings
((single_quote_string) @spell)
((double_quote_string) @spell)
((variable_name) @nospell)
