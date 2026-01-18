["(" ")"] @punctuation.bracket

(symbol) @variable
(boolean) @boolean
(string) @string
(list . (symbol) @function)

; @alias
(list
  (symbol) @keyword
  (#match? @keyword "^\\@.+$")
)

; $variable
(list
  (symbol) @constant
  (#match? @constant "^\\$.+$")
)

; ;;comment ;|block_comment|;
[(comment) (block_comment)] @comment
