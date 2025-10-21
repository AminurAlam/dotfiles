if exists('b:current_syntax')
    finish
endif

syn match Comment /\v^#+\s.+$/

syn match Section /^@ .*$/ contains=Title,Rule
    syn match Title /\v\@ [A-z0-9& ]+/ contained


syn match urlUrl /\v^https?:\/\/.*$/ contains=urlProtocol,Label,Normal,String,Rule
    syn match Label  /\v[^/]+\.\w{2,5}/  contained
    syn match Normal /\v\/\S+/           contained
    syn match String /\v\s"[^"]+"/       contained
    syn match Rule   /\v(\<|;) [a-z-]+ / contained

if has('conceal')
    syn match urlProtocol /\vhttps?:\/\/(www\.)?/ contained conceal
else
    syn match urlProtocol /\vhttps?:\/\/(www\.)?/ contained
endif

hi def link Rule @comment.todo

let b:current_syntax = 'feed'
