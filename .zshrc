export ZSH=/home/erfan/.oh-my-zsh

ZSH_THEME="bullet-train"
BULLETTRAIN_PROMPT_ORDER=(
  time
  dir
  status
  git
)
BULLETTRAIN_STATUS_EXIT_SHOW="true"

HYPHEN_INSENSITIVE="true"
DISABLE_AUTO_TITLE="true"
ENABLE_CORRECTION="true"
plugins=(
  git
  gitfast
  z
)

source $ZSH/oh-my-zsh.sh

# User configuration
export LANG=en_US.UTF-8

alias opd="xdg-open . & ; disown xdg-open"
alias xclip-copy="xclip -selection clipboard -i"

export VISUAL="vim"
export TERMINAL=termite

source $HOME/.zshrc_custom
