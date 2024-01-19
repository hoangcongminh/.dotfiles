# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

export ZSH="$HOME/.oh-my-zsh"

# ZSH_THEME="powerlevel10k/powerlevel10k"
ZSH_THEME="robbyrussell"

# export PS1='%n %F{1}::%f %F{2}%~%f %F{1}%(?..%? )%f%F{4}'$'\U00BB''%f '

plugins=(
  git
  tmux
  fzf
  fzf-tab
  z
  fd
  zsh-autosuggestions
  zsh-syntax-highlighting
  zsh-aliases-exa
  vi-mode
)

source $ZSH/oh-my-zsh.sh

# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# preview directory's content with exa when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'

### Fix slowness of pastes with zsh-syntax-highlighting.zsh
pasteinit() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic # I wonder if you'd need `.    ul-quote-magic`?
}
 pastefinish() {
   zle -N self-insert $OLD_SELF_INSERT
}
zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish
### End fix slowness of pastes

export EDITOR='nvim'
export TERM="alacritty"
export MACOSX_DEPLOYMENT_TARGET=10.15

export DOTFILES_DIR="$HOME/.dotfiles"
export PATH="$DOTFILES_DIR/bin/:$PATH"

export PATH="$PATH:$HOME/fvm/default/bin"
export PATH="$PATH:$HOME/fvm/default/bin/cache/dart-sdk/bin"
export PATH="$PATH":"$HOME/.pub-cache/bin"

export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin

export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && \. "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

bindkey '^n' autosuggest-accept
bindkey -s ^f "tmux-sessionizer\n"
