((comment) @injection.content (#match? @injection.content "^\\; .*")
  (#set! injection.language "scheme")
  (#offset! @injection.content 0 2 0 0)
)

; (list
;   (list) @injection.content (#match? @injection.content ".*cmd.*")
;   (#set! injection.language "sh")
;   (#offset! @injection.content 0 0 0 0)
; )

; (command
;   name: (word) @injection.language (#any-of? @injection.language "awk" "printf" "jq")
;   argument: (single_quote_string) @injection.content
;   (#offset! @injection.content 0 1 0 -1))
;
; (command
;   name: (word) @_command (#any-of? @_command "rg" "fd" "grep")
;   argument: (single_quote_string) @injection.content
;   (#set! injection.language "regex")
;   (#offset! @injection.content 0 1 0 -1))
