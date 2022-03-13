export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(
  git
  tmux
  zsh-autosuggestions
  zsh-syntax-highlighting
  web-search
)

ZSH_TMUX_AUTOSTART=true

source $ZSH/oh-my-zsh.sh

export PATH="$PATH:$HOME/fvm/versions/stable/bin"
export PATH="$PATH:$HOME/fvm/versions/stable/bin/cache/dart-sdk/bin"

bindkey '^n' autosuggest-accept

alias v="nvim"

alias lg="lazygit"

alias t="tmux"

alias ws="web-search"

alias flutter='fvm flutter'
alias dart='fvm dart'
alias fd='fvm flutter doctor'
alias fl='fvm flutter clean'
alias fpg='fvm flutter pub get'
alias fr='fvm flutter run'
alias fb='fvm flutter pub run build_runner build --delete-conflicting-outputs'

alias wp='cd ~/Documents/Workspace'
alias h='cd ~'
alias df='cd ~/.dotfiles'
