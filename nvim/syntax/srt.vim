
if exists('b:current_syntax')
    finish
endif

syn match Include /^\d\+\:\d\+\:\d\+,\d\+/
syn match Label /\d\+\:\d\+\:\d\+,\d\+$/

let b:current_syntax = 'srt'
