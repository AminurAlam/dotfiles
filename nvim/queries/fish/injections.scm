;; extends

(command
  name: (word) @injection.language (#any-of? @injection.language "awk" "printf" "jq")
  argument: (single_quote_string) @injection.content
  (#offset! @injection.content 0 1 0 -1))

(command
  name: (word) @_command (#any-of? @_command "rg" "fd" "grep")
  argument: (single_quote_string) @injection.content
  (#set! injection.language "regex")
  (#offset! @injection.content 0 1 0 -1))

(command
  name: (word) @_command (#eq? @_command "nvim")
  argument: (concatenation
    (word) @_prefix (#eq? @_prefix "+")
    [(single_quote_string) (double_quote_string)] @injection.content)
  (#set! injection.language "vim")
  (#offset! @injection.content 0 1 0 -1))

; (command
;   name: (word) @_command (#eq? @_command "nvim")
;   argument: (word) @injection.content (#match? @injection.content "^\+")
;   (#set! injection.language "vim")
;   (#offset! @injection.content 0 1 0 0))
