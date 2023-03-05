if exists('b:current_syntax')
    finish
endif

syn match noteHead1 /^\#\{1\}\s.\+$/ contains=noteHeadDelim
syn match noteHead2 /^\#\{2\}\s.\+$/ contains=noteHeadDelim
syn match noteHead3 /^\#\{3\}\s.\+$/ contains=noteHeadDelim
syn match noteHead4 /^\#\{4\}\s.\+$/ contains=noteHeadDelim
syn match noteBo /\*[^\*]*\*/ contains=noteSurround
syn match noteSt /\~[^\~]*\~/ contains=noteSurround
syn match noteBt /\`[^\`]*\`/ contains=noteSurround
syn match noteUl /_[^_]*_/   contains=noteSurround

syn region noteBt start=/^\`\{3\}/ end=/\`\{3\}$/
syn match noteUrl /https\?:\/\/[^ \]\)\>]\+/
syn match noteDef /[a-zA-Z0-9-_ ]\+\:\s/
syn match noteList /^\d\+\.\s/
syn match noteDash /\s\+\->\? /
syn match noteQuote /^>.\+/
syn match noteSeporator /^\-\{3,\}$/
syn match noteEllipsis /\.\{3,\}/
syn match noteTag /^\[.\+\]\s/

if has("conceal")
    syn match noteHeadDelim /^#\+\s/ contained conceal
    syn match noteSurround /[\*\~\`_]/ contained conceal
else
    syn match noteHeadDelim /^#\+\s/ contained
    syn match noteSurround /[\*\~\`_]/ contained
endif

hi noteHead1 guibg=#7aa2f7 guifg=#1d202f gui=bold
hi noteHead2 guibg=#A2BDF8 guifg=#1d202f gui=bold
hi noteHead3 guifg=#7aa2f7
hi noteHead4 guifg=#A2BDF8
hi noteBo gui=bold
hi noteSt gui=strikethrough
hi noteBt guibg=#1d202f
hi noteUl gui=underline
hi noteUrl guifg=#7aa2f7 gui=underline
hi def link noteDef Title
hi def link noteList Number
hi def link noteDash Number
hi def link noteQuote String
hi def link noteSeporator Comment
hi def link noteEllipsis Comment
hi def link noteTag Number

syn sync minlines=500
let b:current_syntax = 'note'
