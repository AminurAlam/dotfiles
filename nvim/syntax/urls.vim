if exists('b:current_syntax')
    finish
endif

syn match urlHeading /^\#\{1\}\s.\+$/
syn match urlUrl /^https\?\:\/\/.*$/ contains=urlProtocol,urlDomain,urlParam,urlTag
syn match urlDomain /\(\w\+\.\)\+\w\+/ contained
syn match urlParam /?[a-z_]*=.*/ contained
syn match urlTag /\s[#"~].\+$/ contained
" syn match urlSearch /%s/ contained

if has("conceal")
    syn match urlProtocol /https\?\:\/\/\(www\.\)\?/ contained conceal
else
    syn match urlProtocol /https\?\:\/\/\(www\.\)\?/ contained
endif

hi link urlHeading Comment
hi link urlDomain Function
hi link urlParam Comment
hi link urlTag String
