(comment) @comment

(string_literal) @string
(number_literal) @constant.numeric
(boolean_literal) @constant.builtin.boolean
(null_literal) @constant.builtin

(identifier) @variable

(hash_pair
  (identifier) @property)

(block_open
  "#" @keyword
  (path_expression (identifier) @keyword))

(block_close
  "/" @keyword
  (path_expression (identifier) @keyword))

(else_block
  "else" @keyword)

(partial
  ">" @keyword)

(partial_block_open
  "#>" @keyword)

(decorator
  "*" @keyword)

(block_decorator_open
  "#*" @keyword)

(expression
  "&" @operator)

(subexpression
  "(" @punctuation.bracket
  ")" @punctuation.bracket)

(block_params
  "as" @keyword
  "|" @punctuation.delimiter)

(path_expression
  "this" @variable.builtin)

(path_expression
  "." @variable.builtin)

(segment_literal
  "[" @punctuation.bracket
  "]" @punctuation.bracket)

"{{" @punctuation.special
"}}" @punctuation.special
"{{{" @punctuation.special
"}}}" @punctuation.special
"{{{{" @punctuation.special
"}}}}" @punctuation.special
"{{{{/" @punctuation.special
"~" @operator
"=" @operator
"." @punctuation.delimiter
