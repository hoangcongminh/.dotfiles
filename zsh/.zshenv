export PATH="$PATH:$HOME/.cargo/bin/"

export PATH="/usr/local/opt/java/bin:$PATH"

## Aliases
# Navigating
alias h='cd ~'
alias df='cd ~/.dotfiles'

# ls
# alias l='ls -Flh'
# alias ll='ls -Flha'

# mv, rm, cp
alias mv='mv -v'
alias rm='rm -i -v'
alias cp='cp -v'

# Git
alias g='git'
alias glog='git log --oneline --decorate --graph'
alias gs='git status --short'
alias gS='git status'
alias gd='git diff'
alias gD='git diff --staged'
alias ga='git add'
alias gc='git commit'
alias gp='git push'

# Nvim
alias v="nvim"

# Tmux
alias t="tmux"
alias ta='tmux attach'

# Flutter
alias flutter='fvm flutter'
alias dart='fvm dart'
alias fdoc='fvm flutter doctor'
alias fl='fvm flutter clean'
alias fpg='fvm flutter pub get'
alias fr='fvm flutter run'
alias fb='fvm flutter pub run build_runner build --delete-conflicting-outputs'
alias fbl='fvm flutter pub run build_runner clean'

# Another
alias lg="lazygit"
alias so="source"
alias cl="clear"

## Functions
function gpp() {
    git status
    git add .
  if [ "$1" != "" ]
  then
    echo "New commit message set to: $1\n"
    git commit -m "$1"
  else
    # default commit message is `update`
    echo "New commit message set to: update\n"
    git commit -m update 
  fi 
    git push
}

