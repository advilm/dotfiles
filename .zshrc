# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/advil/.oh-my-zsh"

ZSH_THEME="agnoster"

CASE_SENSITIVE="false"

DISABLE_AUTO_TITLE="true"

COMPLETION_WAITING_DOTS="false"

ZSH_AUTOSUGGEST_USE_ASYNC=true
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

plugins=(git cp zsh-autosuggestions zsh-completions)

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

bindkey '^ ' autosuggest-accept

alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

source $ZSH/oh-my-zsh.sh
