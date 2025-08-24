if (-not (Get-Command scoop -ErrorAction SilentlyContinue)) {
    Write-Host "downloading scoop..."
    Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
    Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
} else {
    Write-Host "updating scoop..."
    scoop update
}


Write-Host "adding scoop buckets..."
scoop bucket add versions
scoop bucket add extras
scoop bucket add nerd-fonts


Write-Host "installing packages..."
if (-not (Get-Command aria2  -ErrorAction SilentlyContinue)) { scoop install aria2 }
scoop config aria2-warning-enabled false

scoop install git pwsh yazi versions/neovim-nightly extras/kanata extras/alacritty nerd-fonts/SourceCodePro-NF-Mono
# scoop install ffmpeg 7zip jq poppler fd ripgrep fzf zoxide resvg imagemagick

# scoop update *
# scoop checkup


Write-Host "downloading dotfiles..."

if (Test-Path -Path ~/dotfiles -PathType Container) {
    Set-Location ~/dotfiles ;
    git pull
} else {
    git clone --depth 1 "https://github.com/AminurAlam/dotfiles" ~/dotfiles ;
}

New-Item -Path ~/AppData/Local/nvim/ -ItemType SymbolicLink -Target ~/dotfiles/nvim/
New-Item -Path ~/AppData/alacritty/ -ItemType SymbolicLink -Target ~/dotfiles/alacritty/
New-Item -Path ~/AppData/yazi/ -ItemType SymbolicLink -Target ~/dotfiles/yazi/

if ($PSVersionTable.PSEdition -eq "Core") {
    New-Item -Path "~/Documents/Powershell/" -ItemType SymbolicLink -Target ~/dotfiles/powershell/
} elseif ($PSVersionTable.PSEdition -eq "Desktop") {
    New-Item -Path "~/Documents/WindowsPowerShell/" -ItemType SymbolicLink -Target ~/dotfiles/powershell/
}

# irm https://christitus.com/win | iex
