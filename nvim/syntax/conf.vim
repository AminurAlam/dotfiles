if exists('b:current_syntax')
    finish
endif

syn region Title oneline start=/^\s*\[[^\[]/ end=/\]/

syn match  Comment    "^#.*"
syn match  Comment    "\s#.*"ms=s+1
syn region String     start=/"/ skip=/\\"/ end=/"/ oneline
syn region String     start=/'/ skip=/\\'/ end=/'/ oneline
syn region Identifier start=/^\s*[-a-zA-Z]/ end=/ \|$/ oneline

let b:current_syntax = 'conf'
