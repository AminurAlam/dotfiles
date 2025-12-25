# $env:XDG_CONFIG_HOME = "$HOME/dotfiles"

# https://wiki.archlinux.org/title/PowerShell#Telemetry
# POWERSHELL_TELEMETRY_OPTOUT=1

Set-Alias -Name vi -Value nvim

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


Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadLineKeyHandler -Chord 'Ctrl+w' -Function BackwardDeleteWord
Set-PSReadLineKeyHandler -Chord 'Ctrl+LeftArrow' -Function BackwardWord
Set-PSReadLineKeyHandler -Chord 'Ctrl+RightArrow' -Function ForwardWord

if (cmdchk zoxide) {
    Invoke-Expression (& { (zoxide init powershell | Out-String) })
}
if (cmdchk starship) {
    Invoke-Expression (& starship init powershell --print-full-init | Out-String)
}

