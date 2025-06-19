if exists('b:current_syntax')
    finish
endif

syn region String oneline start=/"/ skip=/\\"/ end=/"/ contains=SpecialChar
syn region String oneline start=/'/ end=/'/

syn keyword Special START
syn keyword DiagnosticError ERROR Error error
syn keyword DiagnosticWarn WARN Warn warn DEBUG Debug debug
syn keyword DiagnosticInfo INFO Info info
syn match Directory /\[[a-z]\+\]/

"                   date                      sep       time            ms          TZ
syn match Number /\(\d\d\+-\d\d-\d\+\d\+\)\?\(T\| \)\?\(\d\+:\d\+:\d\+\(\.\d\+\)\?\( [A-Z][A-Z][A-Z]\)\?\)/
syn match Number /\(\d\+ \)\?\(Jan\|Feb\|Mar\|Apr\|May\|June\|Jun\|July\|Jul\|Aug\|Sep\|Oct\|Nov\|Dec\|Mon\|Tue\|Wed\|Thu\|Fri\|Sat\|Sun\)\+\( \d\+\)\?/
syn match Number /\d\d\+\/\d\d\/\d\+\d\+/

let b:current_syntax = 'log'
