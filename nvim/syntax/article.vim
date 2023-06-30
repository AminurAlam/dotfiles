if exists('b:current_syntax')
    finish
endif

syn match String /^>.*/
syn match Error /\s\/?[ru]\/[a-zA-Z0-9_]{3,16}/

syn match Title /^\(Feed\|Title\|Author\|Link\|Date\|Links\)\:/
syn match Underlined /https?\:\/\/[^ ]\+/

syn match String /\[[0-9]\+\]/
" syn match String /\[\(image\|video\) [0-9]\+\:\? .*\\(link #[0-9]+\\)\\]/



let b:current_syntax = 'article'
