if exists('b:current_syntax')
  finish
endif

syn match shaSum /^[a-z0-9]*/
syn match shaFile / .*$/

hi def link shaSum String
hi def link shaFile Identifier

syn sync minlines=500
let b:current_syntax = 'sha256'

" vim: et sw=2 sts=2
