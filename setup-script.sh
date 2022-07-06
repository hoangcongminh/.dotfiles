#!/usr/bin/env bash
# Setup script for setting up a new macos machine
echo "Starting setup"
# install xcode CLI
xcode-select --install

# Check for Homebrew to be present, install if it's missing
if test ! $(which brew); then
    echo "Installing homebrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update homebrew recipes
brew update

PACKAGES=(
    git
    tmux
    bat
    exa
    fd
    neofetch
    fzf
    neovim
    htop
    sqlite
    fvm
    lazygit
    nvm
    wget
)

echo "Installing packages..."
brew install ${PACKAGES[@]}

echo "Installing rust..."
brew install rustup
rustup-init

echo "Installing cask..."
CASKS=(
    alacritty
    iterm2
    kitty
    visual-studio-code
    numi
    font-sf-mono-nerd-font
    font-fira-code-nerd-font
    font-hack-nerd-font
    karabiner-elements
)
echo "Installing cask apps..."
brew install ${CASKS[@]} --cask 

echo "Cleaning up..."
brew cleanup

echo "Macbook setup completed!"
