# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
  git
  tmux
  fzf
  z
  zsh-autosuggestions
  zsh-syntax-highlighting
  web-search
)

# ZSH_TMUX_AUTOSTART=true

source $ZSH/oh-my-zsh.sh

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export PATH="$PATH:$HOME/fvm/versions/stable/bin"
export PATH="$PATH:$HOME/fvm/versions/stable/bin/cache/dart-sdk/bin"
export PATH="$PATH":"$HOME/.pub-cache/bin"

export FZF_BASE=~/.fzf.zsh
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'

bindkey '^n' autosuggest-accept

alias v="nvim"

alias lg="lazygit"

alias t="tmux"

alias ws="web-search"

alias flutter='fvm flutter'
alias dart='fvm dart'
alias fdoc='fvm flutter doctor'
alias fl='fvm flutter clean'
alias fpg='fvm flutter pub get'
alias fr='fvm flutter run'
alias fb='fvm flutter pub run build_runner build --delete-conflicting-outputs'

alias wp='cd ~/Documents/Workspace'
alias h='cd ~'
alias df='cd ~/.dotfiles'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
