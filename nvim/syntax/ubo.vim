if exists('b:current_syntax')
    finish
endif

syn match comment /^!\+\s.\+$/
syn match item /^.*\..*#?\?##\?.*$/ contains=main,point,func
syn match sp /^\(@@\|||\|\$\).*$/ contains=url,allowed,denied

syn match main /^\(\w\+\.\)\+\w\+#?\?##\?/ contained contains=url,join
syn match url  /^\(\w\+\.\)\+\w\+/ contained
syn match join /#?\?##\?/ contained
syn match allowed /^@@||/ contained
syn match denied /^\(\$\|||\)/ contained

syn match point /\s>\s/ contained
syn match func /:nth\-of\-type(\d\+)/ contained
syn match func /:has(.*)/ contained


hi def link comment Comment
hi def link url Number
hi def link join Identifier
hi def link allowed String
hi def link denied Error
hi def link point Number
hi def link func Function

let b:current_syntax = 'ubo'
