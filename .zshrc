CASE_SENSITIVE="false"
DISABLE_AUTO_TITLE="true"
TIMEFMT=$'\nuser\t%*U\nsys\t%*S\ntotal\t%*E'
ZLE_RPROMPT_INDENT=0
ZSH_AUTOSUGGEST_USE_ASYNC=true
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey '^ ' autosuggest-accept
bindkey '^H' backward-kill-word

alias ff=firefox-developer-edition
alias code=code-insiders
alias vim=nvim

setopt correct

path+=("$HOME/.local/bin" "$HOME/.cargo/bin")
export PATH

source <(antibody init)
antibody bundle < ~/.zsh_plugins

autoload -Uz compinit
compinit

alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias yay='paru'

eval "$(starship init zsh)"

FIRST_RUN=true
precmd() {
    if [ "$FIRST_RUN" = true ]; then
        FIRST_RUN=false
    else
        echo
    fi
}
alias clear='FIRST_RUN=true; clear'

if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec startx
fi
export PATH=$PATH:/home/advil/.spicetify
