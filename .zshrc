
CASE_SENSITIVE="false"

DISABLE_AUTO_TITLE="true"

TIMEFMT=$'\ncpu\t%P\nuser\t%*U\nsys\t%*S\ntotal\t%*E'

ZSH_AUTOSUGGEST_USE_ASYNC=true
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey '^ ' autosuggest-accept
bindkey '^H' backward-kill-word

alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'


source <(antibody init)
antibody bundle < ~/.zsh_plugins
