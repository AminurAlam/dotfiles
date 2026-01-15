;; extends

(table ; [foo]
  (bare_key) @function)

(dotted_key ; [foo.bar]
  (bare_key) @keyword)

(table ; [foo.bar]
  (dotted_key) @keyword)

(table_array_element ; [[foo]]
  (bare_key) @keyword)
