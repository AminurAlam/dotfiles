if exists('b:current_syntax')
    finish
endif

syn match Comment /\v^#+\s.+$/

syn match urlQuery /^"query:.*"$/ contains=Title
    syn match Title /-----.*-----/ contained

syn match urlUrl /\v^https?:\/\/.*$/ contains=urlProtocol,Label,Normal,String
    syn match Label  /\v[^/]+\.\w{2,5}/ contained
    syn match Normal /\v\/\S+/          contained
    syn match String /\v\s.+$/          contained

if has('conceal')
    syn match urlProtocol /\vhttps?:\/\/(www\.)?/ contained conceal
else
    syn match urlProtocol /\vhttps?:\/\/(www\.)?/ contained
endif

let b:current_syntax = 'urls'
