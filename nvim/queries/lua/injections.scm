;; extends

(function_call
  name: (_) @_vimcmd_identifier
  arguments: (arguments
    .
    (_)
    .
    (table_constructor
      (field
        name: (identifier) @_command
        value: (string
          content: (_) @injection.content))) .)
  (#eq? @_vimcmd_identifier "autocmd")
  (#eq? @_command "command")
  (#set! injection.language "vim"))


(function_call
  name: (_) @_map
  arguments:
    (arguments
      . (_)
      .
      (string
        content: (_) @injection.content))
  (#any-of? @_map "nmap" "vmap" "umap")
  (#lua-match? @injection.content "^<cmd>.*<cr>")
  (#offset! @injection.content 0 5 0 -4)
  (#set! injection.language "vim"))
