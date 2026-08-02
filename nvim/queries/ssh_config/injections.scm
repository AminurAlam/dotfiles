((comment) @injection.content
  (#set! injection.language "comment"))

((condition
  criteria: "exec"
  argument: (string) @injection.content)
  (#set! injection.language "fish"))

((parameter
  keyword: [
    "KnownHostsCommand"
    "LocalCommand"
    "RemoteCommand"
    "ProxyCommand"
  ]
  argument: (string) @injection.content)
  (#set! injection.language "fish"))
