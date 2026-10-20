(generator
  (cmd) @injection.content
  (#set! injection.language "bash")
)

; (settings
;   (setting_name) @_setting_name
;   (#eq? @_setting_name "item-rule")
;   (string) @injection.content
;   (#offset! @injection.content 0 1 0 -1)
;   (#set! injection.language "sql")
; )
