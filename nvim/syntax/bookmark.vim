if exists('b:current_syntax')
    finish
endif

syn match bmHeading /^\#\{1\}\s.\+$/
syn match bmUrl /^https\?\:\/\/.*$/ contains=bmProtocol,bmTags
syn match bmTags /?[a-z_]*=.*/ contained
" syn match bmSearch /%s/ contained

if has("conceal")
    syn match bmProtocol /https\?\:\/\/\(www.\)\?/ contained conceal
else
    syn match bmProtocol /https\?\:\/\/\(www.\)\?/ contained
endif

hi bmHeading guibg=#7aa2f7 guifg=#1d202f gui=bold
hi link bmTags Comment
