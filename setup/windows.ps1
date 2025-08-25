cls
if (-not (Get-Command scoop -ErrorAction SilentlyContinue)) {
    Write-Host "DOWNLOADING SCOOP..."
    Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
    Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
} else {
    Write-Host "UPDATING SCOOP..."
    scoop update
}


cls
Write-Host "ADDING SCOOP BUCKETS..."
scoop bucket add versions
scoop bucket add extras
scoop bucket add nerd-fonts


cls
Write-Host "INSTALLING PACKAGES..."
if (-not (Get-Command aria2  -ErrorAction SilentlyContinue)) { scoop install aria2 }
scoop config aria2-warning-enabled false

scoop install git versions/neovim-nightly extras/kanata
# scoop install pwsh yazi extras/alacritty extras/librewolf nerd-fonts/SourceCodePro-NF-Mono starship
# scoop install ffmpeg 7zip jq poppler fd ripgrep fzf zoxide resvg imagemagick


cls
Write-Host "DOWNLOADING DOTFILES..."
if (Test-Path -Path ~/dotfiles -PathType Container) {
    Set-Location ~/dotfiles ;
    git pull
} else {
    git clone --depth 1 "https://github.com/AminurAlam/dotfiles" ~/dotfiles ;
}

cls
Write-Host "LINKING DOTFILES..."
New-Item -Path ~/AppData/Local/nvim/ -ItemType SymbolicLink -Target ~/dotfiles/nvim/
New-Item -Path ~/AppData/alacritty/ -ItemType SymbolicLink -Target ~/dotfiles/alacritty/
New-Item -Path ~/AppData/yazi/ -ItemType SymbolicLink -Target ~/dotfiles/yazi/
if ($PSVersionTable.PSEdition -eq "Core") {
    New-Item -Path ~/Documents/Powershell/ -ItemType SymbolicLink -Target ~/dotfiles/powershell/
} elseif ($PSVersionTable.PSEdition -eq "Desktop") {
    New-Item -Path ~/Documents/WindowsPowerShell/ -ItemType SymbolicLink -Target ~/dotfiles/powershell/
}

# irm https://christitus.com/win | iex
