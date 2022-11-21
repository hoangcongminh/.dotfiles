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
  fd
  zsh-autosuggestions
  zsh-syntax-highlighting
  zsh-aliases-exa
  zsh-vim-mode
)

# ZSH_TMUX_AUTOSTART=true
# ZSH_TMUX_AUTOQUIT=false

source $ZSH/oh-my-zsh.sh

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export PATH="$PATH:$HOME/fvm/versions/stable/bin"
export PATH="$PATH:$HOME/fvm/versions/stable/bin/cache/dart-sdk/bin"
export PATH="$PATH":"$HOME/.pub-cache/bin"
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH="$PATH:$HOME/.cargo/bin/"
export PATH="$PATH:/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin"

export DOTFILES_DIR="$HOME/.dotfiles"

export FZF_BASE=~/.fzf.zsh
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'

export MACOSX_DEPLOYMENT_TARGET=10.15

export EDITOR='nvim'

export NVM_DIR="$HOME/.nvm"
  [ -s "/usr/local/opt/nvm/nvm.sh" ] && \. "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

export JAVA_HOME="/usr/local/opt/java/bin:$PATH"

export PATH="$DOTFILES_DIR/bin/:$PATH"

bindkey '^n' autosuggest-accept
bindkey -s ^f "tmux-sessionizer\n"

# Aliases
source $HOME/.dotfiles/zsh/.aliases

# Functions
source $HOME/.dotfiles/zsh/.functions

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
