if exists('b:current_syntax')
  finish
endif

syn region noteTitleH1 matchgroup=noteTitle start=/^#\s/ end=/$/
syn region noteTitleNest matchgroup=noteTitle start=/^#\{2,4\}\s/ end=/$/
syn region note matchgroup=noteTitle start=/^\d\+/ end=/\./
syn region noteMark matchgroup=noteMarker start=/^\[/ end=/\]\s/
syn match noteDash / \- / display

hi def link noteTitle markdownHeadingDelimiter
hi def link noteTitleH1 htmlH2
hi def link noteTitleNest htmlH1
hi def link noteMarker @parameter
hi def link noteDash markdownHeadingDelimiter

syn sync minlines=500
let b:current_syntax = 'note'

" vim: et sw=2 sts=2
