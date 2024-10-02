if exists('b:current_syntax')
    finish
endif

syn match Number   /\v^\d+$/
syn match Label    /\v^\d+:\d+:\d+,\d+/
syn match Operator /-->/
syn match Label    /\v\d+:\d+:\d+,\d+$/
syn region Special start=/{/ end=/}/

let b:current_syntax = 'srt'
