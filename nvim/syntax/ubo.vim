if exists('b:current_syntax')
    finish
endif

syn match comment /^!\+\s.\+$/
syn match item /^.*\..*###\?.*$/ contains=main,point,nth
syn match sp /^\(@@\|||\|\$\).*$/ contains=url,allowed,denied

syn match main /^\(\w\+\.\)\+\w\+###\?/ contained contains=url,join
syn match url  /^\(\w\+\.\)\+\w\+/ contained
syn match join /###\?/ contained
syn match allowed /^@@||/ contained
syn match denied /^\(\$\|||\)/ contained

syn match point /\s>\s/ contained
syn match nth /:nth\-of\-type(\d\+)/ contained


hi def link comment Comment

hi def link url Number
hi def link join Identifier
hi def link allowed String
hi def link denied Error
hi def link point Number
hi def link nth Function
