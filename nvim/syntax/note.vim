if exists('b:current_syntax')
    finish
endif

syn match noteHead1 /\v^#{1}\s.+$/ contains=noteHeadDelim
syn match noteHead2 /\v^#{2}\s.+$/ contains=noteHeadDelim
syn match noteHead3 /\v^#{3}\s.+$/ contains=noteHeadDelim
syn match noteHead4 /\v^#{4}\s.+$/ contains=noteHeadDelim

syn match Bold       /\v\*\S[^*]+\*/ contains=noteSurround
syn match noteBt     /\v`\S[^`]+`/   contains=noteSurround
syn match Underlined /\v_\S[^_]+_/   contains=noteSurround
syn region noteBt start=/\v^`{3}/ end=/\v`{3}$/

syn match Define  /\v[a-zA-Z0-9-_ ]+:( |$)/
syn match Comment /\v^-{3,}$/  " seperator
syn match Comment /\v\.{3,}$/  " etc
syn match Number  /\v^\d+\.\s/ " ordered list
syn match Number  /\v^- /      " unordered list
syn match Removed /\v^\s+- /   " nested list
syn match Number  /\v\s-\>\s/  " pointer
syn match String  /\v^\>.+/    " quote
syn match Label   /\v\[.+\]/   " label

if has('conceal')
    syn match noteHeadDelim /\v^#+\s/ contained conceal
    syn match noteSurround /\v[*~`_]/ contained conceal
else
    syn match noteHeadDelim /\v^#+\s/ contained
    syn match noteSurround /\v[*~`_]/ contained
endif

hi noteHead1 guibg=#7aa2f7 guifg=#1d202f
hi noteHead2 guibg=#A2BDF8 guifg=#1d202f
hi noteHead3 guifg=#7aa2f7
hi noteHead4 guifg=#A2BDF8
hi noteBt guibg=#1d202f

let b:current_syntax = 'note'
