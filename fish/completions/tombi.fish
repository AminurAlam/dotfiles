# Print an optspec for argparse to handle cmd's options that are independent of any subcommand.
function __fish_tombi_global_optspecs
    string join \n v/verbose h/help V/version
end

function __fish_tombi_needs_command
    # Figure out if the current invocation already has a command.
    set -l cmd (commandline -opc)
    set -e cmd[1]
    argparse -s (__fish_tombi_global_optspecs) -- $cmd 2>/dev/null
    or return
    if set -q argv[1]
        # Also print the command, so this can be used to figure out what it is.
        echo $argv[1]
        return 1
    end
    return 0
end

function __fish_tombi_using_subcommand
    set -l cmd (__fish_tombi_needs_command)
    test -z "$cmd"
    and return 1
    contains -- $cmd[1] $argv
end

complete -c tombi -n "__fish_tombi_needs_command" -s v -l verbose -d 'Change the logging level'
complete -c tombi -n "__fish_tombi_needs_command" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c tombi -n "__fish_tombi_needs_command" -s V -l version -d 'Print version'
complete -c tombi -n "__fish_tombi_needs_command" -f -a "format" -d 'Format TOML files'
complete -c tombi -n "__fish_tombi_needs_command" -f -a "lint" -d 'Lint TOML files'
complete -c tombi -n "__fish_tombi_needs_command" -f -a "lsp" -d 'Run TOML Language Server'
complete -c tombi -n "__fish_tombi_needs_command" -f -a "cache" -d 'Manage the cache'
complete -c tombi -n "__fish_tombi_needs_command" -f -a "completion" -d 'Generate shell completion'
complete -c tombi -n "__fish_tombi_using_subcommand format" -l stdin-filename -d 'Filename to use when reading from stdin' -r
complete -c tombi -n "__fish_tombi_using_subcommand format" -l diagnostics-format -d 'Output format of diagnostics' -r -f -a "pretty\t'Human-readable output'
json\t'JSON array of diagnostics'
json-lines\t'JSON Lines, a diagnostic per line'
github\t'GitHub Actions workflow commands'
gitlab\t'GitLab Code Quality report'
junit\t'JUnit XML report'
sarif\t'SARIF 2.1.0 report'"
complete -c tombi -n "__fish_tombi_using_subcommand format" -l diagnostics-file -d 'File to write diagnostics to' -r -F
complete -c tombi -n "__fish_tombi_using_subcommand format" -l cache-ttl -d 'Cache expiration time in seconds' -r
complete -c tombi -n "__fish_tombi_using_subcommand format" -l check -d 'Check only and don\'t overwrite files'
complete -c tombi -n "__fish_tombi_using_subcommand format" -l diff -d 'Show format changes'
complete -c tombi -n "__fish_tombi_using_subcommand format" -l quiet -d 'Quiet mode'
complete -c tombi -n "__fish_tombi_using_subcommand format" -l offline -d 'Disable network access'
complete -c tombi -n "__fish_tombi_using_subcommand format" -l no-cache -d 'Do not use cache'
complete -c tombi -n "__fish_tombi_using_subcommand format" -s v -l verbose -d 'Change the logging level'
complete -c tombi -n "__fish_tombi_using_subcommand format" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c tombi -n "__fish_tombi_using_subcommand lint" -l stdin-filename -d 'Filename to use when reading from stdin' -r
complete -c tombi -n "__fish_tombi_using_subcommand lint" -l diagnostics-format -d 'Output format of diagnostics' -r -f -a "pretty\t'Human-readable output'
json\t'JSON array of diagnostics'
json-lines\t'JSON Lines, a diagnostic per line'
github\t'GitHub Actions workflow commands'
gitlab\t'GitLab Code Quality report'
junit\t'JUnit XML report'
sarif\t'SARIF 2.1.0 report'"
complete -c tombi -n "__fish_tombi_using_subcommand lint" -l diagnostics-file -d 'File to write diagnostics to' -r -F
complete -c tombi -n "__fish_tombi_using_subcommand lint" -l cache-ttl -d 'Cache expiration time in seconds' -r
complete -c tombi -n "__fish_tombi_using_subcommand lint" -l error-on-warnings -d 'Exit with error code on warnings'
complete -c tombi -n "__fish_tombi_using_subcommand lint" -l quiet -d 'Quiet mode'
complete -c tombi -n "__fish_tombi_using_subcommand lint" -l offline -d 'Disable network access'
complete -c tombi -n "__fish_tombi_using_subcommand lint" -l no-cache -d 'Do not use cache'
complete -c tombi -n "__fish_tombi_using_subcommand lint" -s v -l verbose -d 'Change the logging level'
complete -c tombi -n "__fish_tombi_using_subcommand lint" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c tombi -n "__fish_tombi_using_subcommand lsp" -l cache-ttl -d 'Cache expiration time in seconds' -r
complete -c tombi -n "__fish_tombi_using_subcommand lsp" -l offline -d 'Disable network access'
complete -c tombi -n "__fish_tombi_using_subcommand lsp" -l no-cache -d 'Do not use cache'
complete -c tombi -n "__fish_tombi_using_subcommand lsp" -s v -l verbose -d 'Change the logging level'
complete -c tombi -n "__fish_tombi_using_subcommand lsp" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c tombi -n "__fish_tombi_using_subcommand cache; and not __fish_seen_subcommand_from clean dir" -s v -l verbose -d 'Change the logging level'
complete -c tombi -n "__fish_tombi_using_subcommand cache; and not __fish_seen_subcommand_from clean dir" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c tombi -n "__fish_tombi_using_subcommand cache; and not __fish_seen_subcommand_from clean dir" -f -a "clean" -d 'Remove all cached files'
complete -c tombi -n "__fish_tombi_using_subcommand cache; and not __fish_seen_subcommand_from clean dir" -f -a "dir" -d 'Print the cache directory path'
complete -c tombi -n "__fish_tombi_using_subcommand cache; and __fish_seen_subcommand_from clean" -s v -l verbose -d 'Change the logging level'
complete -c tombi -n "__fish_tombi_using_subcommand cache; and __fish_seen_subcommand_from clean" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c tombi -n "__fish_tombi_using_subcommand cache; and __fish_seen_subcommand_from dir" -s v -l verbose -d 'Change the logging level'
complete -c tombi -n "__fish_tombi_using_subcommand cache; and __fish_seen_subcommand_from dir" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c tombi -n "__fish_tombi_using_subcommand completion" -s v -l verbose -d 'Change the logging level'
complete -c tombi -n "__fish_tombi_using_subcommand completion" -s h -l help -d 'Print help (see more with \'--help\')'
