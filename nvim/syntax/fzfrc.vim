if exists('b:current_syntax')
    finish
endif

syn match  Comment    "^#.*"
syn region String     start=/"/ skip=/\\"/ end=/"/ oneline
syn region String     start=/'/ skip=/\\'/ end=/'/ oneline
syn match Constant /^-[-a-zA-Z]\+/
syn match Identifier /\v( |,)[-a-z+]+:/

let b:current_syntax = 'fzfrc'
