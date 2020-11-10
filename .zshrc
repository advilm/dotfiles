
CASE_SENSITIVE="false"

DISABLE_AUTO_TITLE="true"

COMPLETION_WAITING_DOTS="false"

ZSH_AUTOSUGGEST_USE_ASYNC=true
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

bindkey '^ ' autosuggest-accept

bindkey '^H' backward-kill-word

alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'


source <(antibody init)
antibody bundle < ~/.zsh_plugins
