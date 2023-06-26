if exists('b:current_syntax')
    finish
endif

" https://wiki.hydrogenaud.io/index.php?title=Cue_sheet
syn match SpecialChar /\\[btnfr"/\\]/ display contained
syn match SpecialChar /\\u\x\{4}/ contained
syn match SpecialChar /\\U\x\{8}/ contained
syn match SpecialChar /\\$/ contained

syn match Comment /^;.*$/
syn region String oneline start=/"/ skip=/\\\\\|\\"/ end=/"/ contains=SpecialChar
syn region String oneline start=/'/ end=/'/

syn keyword Identifier FILE TRACK INDEX PREGAP POSTGAP FLAGS REM
syn keyword Function CDTEXTFILE CATALOG ISRC TITLE PERFORMER SONGWRITER COMPOSER
syn keyword Function GENRE DATE DISCID COMMENT LABEL FORMAT URL DISCNUMBER TOTALDISCS
syn keyword Function REPLAYGAIN_ALBUM_GAIN REPLAYGAIN_ALBUM_PEAK REPLAYGAIN_TRACK_GAIN REPLAYGAIN_TRACK_PEAK

syn match Number / [+-]\=\d\+\.\=\d*\( \|$\)/
syn match Number /\d\+\:\d\+\:\d\+\( \|$\)/

let b:current_syntax = 'cuesheet'
