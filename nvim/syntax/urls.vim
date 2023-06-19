if exists('b:current_syntax')
    finish
endif

syn match Comment /^\#\{1\}\s.\+$/
syn match urlQuery /^"query:.*"$/ contains=urlQTitle
syn match urlUrl /^https\?\:\/\/.*$/ contains=urlProtocol,urlDomain,urlParam,urlTag

" syn match urlDomain /\(\w\+\.\)\+\w\+/ contained
" syn match urlParam /?[a-z_]*=.*[^ ]/ contained
syn match urlTag /\s[#"~].\+$/ contained
syn match urlQTitle /-----.*-----/ contained

if has("conceal")
    syn match urlProtocol /https\?\:\/\/\(www\.\)\?/ contained conceal
else
    syn match urlProtocol /https\?\:\/\/\(www\.\)\?/ contained
endif

" hi link urlDomain Function
" hi link urlParam Comment
hi link urlTag String
hi link urlQTitle Title
