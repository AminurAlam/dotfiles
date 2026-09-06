(generator
  (cmd) @injection.content
  (#set! injection.language "bash")
)

; (rule
;   (setting) @_setting
;   (#eq? @_setting "item-rule")
;   (string) @injection.content
;   (#offset! @injection.content 0 1 0 -1)
;   (#set! injection.language "sql")
; )
