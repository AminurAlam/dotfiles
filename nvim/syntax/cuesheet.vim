if exists('b:current_syntax')
    finish
endif

" https://wiki.hydrogenaud.io/index.php?title=Cue_sheet
syn match cueEscape /\\[btnfr"/\\]/ display contained
syn match cueEscape /\\u\x\{4}/ contained
syn match cueEscape /\\U\x\{8}/ contained
syn match cueLineEscape /\\$/ contained

syn region cueString oneline start=/"/ skip=/\\\\\|\\"/ end=/"/ contains=cueEscape
syn region cueString oneline start=/'/ end=/'/

" syn match cueKey /^\s*[A-Z _]+ / display
syn match cueKey /FILE\|TRACK\|INDEX\|PREGAP\|POSTGAP/ display
syn match cueKey /CDTEXTFILE\|CATALOG\|ISRC\|TITLE\|PERFORMER\|SONGWRITER/ display
syn match cueKey /REM [A-Z_]\+/

syn match cueNum / [+-]\=\d\+\.\=\d*\( \|$\)/
syn match cueTime /\d\+\:\d\+\:\d\+\( \|$\)/

hi def link cueKey Identifier
hi def link cueNum Number
hi def link cueTime Function
hi def link cueString String
hi def link cueLineEscape SpecialChar
hi def link cueEscape SpecialChar

syn sync minlines=500
let b:current_syntax = 'cuesheet'
