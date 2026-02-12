function not_installed {
    param($command)
    $exists = $null -eq (Get-Command $command -ErrorAction SilentlyContinue)
    return $exists
}

cls
if (not_installed scoop) {
    Write-Host "DOWNLOADING SCOOP..."
    Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
    Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
} else {
    Write-Host "UPDATING SCOOP..."
    scoop update || pause
}

if (not_installed git) {
    Write-Host "INSTALLING GIT..."
    scoop install git || pause
}


cls
Write-Host "ADDING SCOOP BUCKETS..."
scoop bucket add versions || pause
scoop bucket add extras || pause
scoop bucket add nerd-fonts || pause


cls
Write-Host "INSTALLING PACKAGES..."
if (not_installed aria2) { scoop install aria2 }
scoop config aria2-warning-enabled false || pause

scoop install git versions/neovim-nightly extras/kanata || pause
# scoop install pwsh yazi extras/alacritty extras/librewolf nerd-fonts/SourceCodePro-NF-Mono starship
# scoop install ffmpeg 7zip jq poppler fd ripgrep fzf zoxide resvg imagemagick


cls
Write-Host "DOWNLOADING DOTFILES..."
if (Test-Path -Path ~/dotfiles -PathType Container) {
    Set-Location ~/dotfiles || pause
    git pull origin || pause
} else {
    git clone --depth 1 "https://github.com/AminurAlam/dotfiles" ~/dotfiles || pause
}

cls
# Write-Host "LINKING DOTFILES..."
# Copy-Item -Recurse -Force -Path ~/dotfiles/others/starship.toml ~/.config/starship.toml
# Copy-Item -Recurse -Force -Path ~/AppData/Local/nvim/           ~/dotfiles/nvim/
# Copy-Item -Recurse -Force -Path ~/AppData/alacritty/            ~/dotfiles/alacritty/
# Copy-Item -Recurse -Force -Path ~/AppData/yazi/                 ~/dotfiles/yazi/

if ($PSVersionTable.PSEdition -eq "Core") {
    # New-Item -Path ~/Documents/Powershell/ -ItemType SymbolicLink -Target ~/dotfiles/powershell/
} elseif ($PSVersionTable.PSEdition -eq "Desktop") {
    # New-Item -Path ~/Documents/WindowsPowerShell/ -ItemType SymbolicLink -Target ~/dotfiles/powershell/
}

# irm https://christitus.com/win | iex
