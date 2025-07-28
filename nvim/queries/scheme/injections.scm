((comment) @injection.content (#match? @injection.content "^\\; .*")
  (#set! injection.language "scheme")
  (#offset! @injection.content 0 2 0 0)
)

; (list
;   (list) @injection.content (#match? @injection.content ".*cmd.*")
;   (#set! injection.language "sh")
;   (#offset! @injection.content 0 0 0 0)
; )
