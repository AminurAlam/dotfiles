if exists('current_compiler')
    finish
endif

let current_compiler = 'oxdraw' " TODO: make one for mermaid-cli

let s:makeprg = [current_compiler, '-i', '%:S', '-o', '%:r:S.svg']

execute 'CompilerSet makeprg=' . join(s:makeprg, '\ ')
