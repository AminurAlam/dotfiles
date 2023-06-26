if exists('b:current_syntax')
    finish
endif

syn match noteHead1 /^\#\{1\}\s.\+$/ contains=noteHeadDelim
syn match noteHead2 /^\#\{2\}\s.\+$/ contains=noteHeadDelim
syn match noteHead3 /^\#\{3\}\s.\+$/ contains=noteHeadDelim
syn match noteHead4 /^\#\{4\}\s.\+$/ contains=noteHeadDelim
syn match Bold /\*\S[^\*]*\*/ contains=noteSurround
syn match Strike /\~\S[^\~]*\~/ contains=noteSurround
syn match noteBt /\`\S[^\`]*\`/ contains=noteSurround
syn match Underlined /_\S[^_]*_/   contains=noteSurround

syn region noteBt start=/^\`\{3\}/ end=/\`\{3\}$/
syn match noteUrl /https\?:\/\/[^ \]\)\>]\+/
syn match Title /[a-zA-Z0-9-_ ]\+\:\s/
syn match Number /^\d\+\.\s/
syn match Number /\s\+\->\? /
syn match String /^>.\+/
syn match Comment /^\-\{3,\}$/
syn match Comment /\.\{3,\}$/
syn match Number /^\[.\+\]\s/ contains=noteMarker

if has('conceal')
    syn match noteHeadDelim /^#\+\s/ contained conceal
    syn match noteSurround /[\*\~\`_]/ contained conceal
    syn match noteMarker /[xX]/ contained conceal cchar=✓
else
    syn match noteHeadDelim /^#\+\s/ contained
    syn match noteSurround /[\*\~\`_]/ contained
    syn match noteMarker /[xX]/ contained
endif

hi noteHead1 guibg=#7aa2f7 guifg=#1d202f
hi noteHead2 guibg=#A2BDF8 guifg=#1d202f
hi noteHead3 guifg=#7aa2f7
hi noteHead4 guifg=#A2BDF8
hi Strike gui=strikethrough
hi noteBt guibg=#1d202f
hi noteUl gui=underline
hi noteUrl guifg=#7aa2f7 gui=underline

let b:current_syntax = 'note'
