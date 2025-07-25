(number) @number
(string) @string

(list
  .
  (symbol) @function)

([
  (comment)
  (block_comment)
] @comment
  (#match? @comment "^\\;;.*")
)

; underscore
((symbol) @comment
  (#match? @comment "^_$"))

; aliases
((symbol) @keyword
  (#match? @keyword "^\\@.*"))

; variables
((symbol) @constant
  (#match? @constant "^\\$.*"))
