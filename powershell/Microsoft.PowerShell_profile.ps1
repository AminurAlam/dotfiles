### ENV

# https://gist.github.com/eabase/dc409e95c0c3bd3168711a914a1b4c02
$env_dict = @{
    "XDG_CONFIG_HOME"                           = "$HOME/dotfiles"
    "POWERSHELL_TELEMETRY_OPTOUT"               = "1"
    "DOTNET_CLI_TELEMETRY_OPTOUT"               = "1"
    "VCPKG_DISABLE_METRICS"                     = "1"
    "AZURE_CORE_COLLECT_TELEMETRY"              = "0"
    "VSCODE_TELEMETRY_DISABLE"                  = "1"
    "VSCODE_CRASH_REPORTER_DISABLE"             = "1"
    "GH_NO_TELEMETRY"                           = "1"
    "APPLICATIONINSIGHTS_NO_DIAGNOSTIC_CHANNEL" = "1"
}

foreach ($key in $env_dict.Keys) {
    $value = $env_dict[$key]
    [Environment]::SetEnvironmentVariable($key, $value)
    [Environment]::SetEnvironmentVariable($key, $value, "Machine")
}

### ALIASES

function cmdchk {
    param($command)
    $exists = $null -ne (Get-Command $command -ErrorAction SilentlyContinue)
    return $exists
}
function y {
    $tmp = (New-TemporaryFile).FullName
    yazi $PWD $args --cwd-file="$tmp"
    $cwd = Get-Content -Path $tmp -Encoding UTF8
    if (-not [String]::IsNullOrEmpty($cwd) -and $cwd -ne $PWD.Path) {
        Set-Location -LiteralPath (Resolve-Path -LiteralPath $cwd).Path
    }
    Remove-Item -Path $tmp
}

function zz   { cd - }
function ..   { cd .. }
function ...  { cd ../.. }
function .... { cd ../../.. }

function vi { nvim }
function l  { dir }
function ll { dir }
function lg { lazygit }

function gl   { git status -bs; git log --pretty=nice -n10 }
function gd   { git diff }
function pull { git pull origin }
function push { git push origin }

function pi { scoop install }
function pr { scoop uninstall }
function pu { scoop update --all }
function pf { scoop search }
function pa { scoop info }

### THEME

$PSReadLineOptions = @{
    PredictionSource = 'History'
    PredictionViewStyle = 'ListView'
    BellStyle = 'None'
    EditMode = 'Vi'
    HistoryNoDuplicates = $true
    HistorySearchCursorMovesToEnd = $true
    Colors = @{
        Command = '#7DCFFF'
        Comment = '#565F89'
        ContinuationPrompt = '#565F89'
        Default = '#C0CAF5'
        Emphasis = '#ff9e64'
        Error = '#FF6E67'
        # InlinePrediction
        Keyword = '#FF79C6'
        ListPrediction = '#C0CAF5'
        # ListPredictionSelected = '#364a82'
        Member = 'DarkGray'
        Number = '#FF9E64'
        Operator = '#9AEDFE'
        Parameter = '#FF9E64'
        Selection = '#C0CAF5'
        String = '#5AF79E'
        Type = '#F0E68C'
        Variable = '#7DCFFF'
    }
}
Set-PSReadLineOption @PSReadLineOptions

### BINDINGS

Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadLineKeyHandler -Chord 'Ctrl+w' -Function BackwardDeleteWord
Set-PSReadLineKeyHandler -Chord 'Ctrl+LeftArrow' -Function BackwardWord
Set-PSReadLineKeyHandler -Chord 'Ctrl+RightArrow' -Function ForwardWord

### SETUP

if (cmdchk zoxide) {
    Invoke-Expression (& { (zoxide init powershell | Out-String) })
}
if (cmdchk starship) {
    Invoke-Expression (& starship init powershell --print-full-init | Out-String)
}

